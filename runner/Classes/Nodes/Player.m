//
//  Player.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Player.h"
#import "GameScene.h"
#import "PointUtil.h"
#import "PlayerAnimation.h"
#import "Enemy.h"
#import "PointUtil.h"
#import "Follower.h"

@interface Player ()
@property (nonatomic, readwrite)int _monsterId;
@property (nonatomic, readwrite)BOOL _isStaged;
@property (nonatomic, readwrite)int _jumpNum, _currentJumpNum, _jumpSpeed;
@property (nonatomic, retain)CCSprite *_playerSprite;
@property (nonatomic, readwrite)BOOL _onGround, _isAdjusting;
@property (nonatomic, readwrite)float _vx, _vy;
@property (nonatomic, readwrite)float _properPositionX;
@property (nonatomic, readwrite)float _limitX, _limitY;
@property (nonatomic, readwrite)int _speedStep;
@property (nonatomic, readwrite)float _dx1, _dx2;
@property (nonatomic, retain)NSMutableArray *_follower1Points;
@property (nonatomic, retain)NSMutableArray *_follower2Points;
@end

@implementation Player
const int GRAVITY = 35;
const int MAX_SPEED_STEP = 3;

+ (Player*)createPlayer:(int)monsterId {
    return [[[self alloc] initWithMonsterId:monsterId] autorelease];
}

- (id)initWithMonsterId:(int)monsterId {
    self = [super init];
	if (self) {
        
        // 初期値設定
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        self._monsterId = monsterId;
        self._isStaged = false;
        self._jumpNum = 1;
        self._onGround = true;
        self._vx = [PointUtil getPoint:300];
        self._isAdjusting = false;
        self._limitX = winSize.width / 2 - [PointUtil getPoint:BASE_WIDTH / 2];
        self._limitY = winSize.height / 2 - [PointUtil getPoint:BASE_HEIGHT / 2];
        self._jumpSpeed = [PointUtil getPoint:1000];
        self._follower1Points = [NSMutableArray array];
        self._follower2Points = [NSMutableArray array];
        
        // アニメーションの最初のコマを読み込む
        NSString* fileName = [NSString stringWithFormat:@"monster%d_right1.png", self._monsterId];
        self._playerSprite = [CCSprite spriteWithSpriteFrameName:fileName];
        [self addChild:self._playerSprite];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)stageOn {
    self._isStaged = true;
    [PointUtil setPosition:self x:180 y:760 offsetX:0 offsetY:-self._playerSprite.contentSize.height / 2];
    self._properPositionX = self.position.x;
    [[GameScene sharedInstance].gameLayer addChild:self];
}

- (void)start {
    [self._playerSprite runAction:[PlayerAnimation getWalkAction:self._monsterId]];
    [self scheduleUpdate];
}

- (void)stop {
    [self unscheduleUpdate];
    [self._playerSprite stopAllActions];
}

- (void)jump {
    if ((self._currentJumpNum == 0 && self._onGround) || (self._currentJumpNum != 0 && self._currentJumpNum < self._jumpNum)) {
        self._currentJumpNum++;
        self._vy += self._jumpSpeed;
    }
}

- (void)speedUp {
    if (self._speedStep < MAX_SPEED_STEP) {
        [[GameScene sharedInstance].headerController showSpeedUpEffect];
        self._vx *= 1.3;
        self._speedStep++;
    }
}

- (void)update:(ccTime)dt {

    // ステージ上にいなければ何も処理しない
    if (!self._isStaged) return;
    
    ///////////////////////////////////////////////////////////////
    // 死亡判定
    ///////////////////////////////////////////////////////////////
    MapController *mapController = [GameScene sharedInstance].mapController;
    
    // 圧死判定
    if (self.position.x < self._limitX) {
        [self dead];
        return;
    }
    
    // 落下判定
    if (self.position.y < self._limitY) {
        [self dead];
        return;        
    }
    
    // 敵との当たり判定
    if ([mapController isHit:[self getCenterRightPosition]]) {
        [self dead];
        return;
    }
    
    ///////////////////////////////////////////////////////////////
    // 当たり判定用座標計算
    ///////////////////////////////////////////////////////////////
    self._vy -= GRAVITY;
    float dx = self._vx * dt;
    float dy = self._vy * dt;
    float x = self.position.x;
    float y = self.position.y;

    ///////////////////////////////////////////////////////////////
    // コイン/アイテム判定
    ///////////////////////////////////////////////////////////////
    [mapController takeCoinsIfCollided:[self getTopLeftPosition]];
    [mapController takeCoinsIfCollided:[self getTopRightPosition]];
    [mapController takeCoinsIfCollided:[self getBottomLeftPosition]];
    [mapController takeCoinsIfCollided:[self getBottomRightPosition]];

    ///////////////////////////////////////////////////////////////
    // 横軸の判定
    ///////////////////////////////////////////////////////////////
    CGPoint nextRightXPosition = ccpAdd([self getCenterRightPosition], ccp(dx, 0));
    
    // ブロックに衝突している場合はプレイヤーも一緒に移動
    Block *blockX = [mapController getHitBlock:nextRightXPosition];
    if (blockX) {
        x = [blockX getLeftPoint] - self._playerSprite.contentSize.width / 2;
    } else {
        if (self._isAdjusting) { // 場所調整中
            if (self._properPositionX <= self.position.x) {
                self._isAdjusting = false;
                x = self._properPositionX;
            } else {
                x = self.position.x + [PointUtil getPoint:1];
            }
        } else { // 規定値より後ろにいる場合
            if (self._properPositionX - [PointUtil getPoint:50] > self.position.x) {
                self._isAdjusting = true;
            }
        }
    }
    
    // マップスクロール
    [mapController scroll:dx];
    
    ///////////////////////////////////////////////////////////////
    // 縦軸の判定
    ///////////////////////////////////////////////////////////////
    CGPoint nextCenterBottomYPosition = ccpAdd([self getCenterBottomPosition], ccp(0, dy));
    
    // 敵チェック
    if ([mapController attackEnemyIfCollided:nextCenterBottomYPosition]) {
        self._vy += self._jumpSpeed * 1.5;
        y += self._vy * dt;
    
    // ブロックチェック
    } else {
    
        // 着地判定
        Block *blockY = [mapController getHitBlock:nextCenterBottomYPosition];
        if (!blockY) blockY = [mapController getHitBlock:ccpAdd(nextCenterBottomYPosition, ccp(-[self getWidth] / 2, 0))];
        if (blockY) {
            if (self._vy <= 0) {
                self._onGround = true;
                y = [blockY getLandPoint] + self._playerSprite.contentSize.height / 2;
                self._vy = 0;
                self._currentJumpNum = 0;
            }
        } else {
            self._onGround = false; // 衝突していないので空中

            // 上ブロック衝突判定
            CGPoint nextCenterTopYPosition = ccpAdd([self getCenterTopPosition], ccp(0, dy));
            Block *topBlock = [mapController getHitBlock:nextCenterTopYPosition];
            if (topBlock) {
                self._vy = 0;
            } else {
                y += dy;
            }
        }
    }
    
    ///////////////////////////////////////////////////////////////
    // 位置更新
    ///////////////////////////////////////////////////////////////
    self._dx1 += dx;
    self._dx2 += dx;
    CGPoint diff = ccpSub(ccp(x, y), self.position);
    [self._follower1Points addObject:[NSValue valueWithCGPoint:diff]];
    [self._follower2Points addObject:[NSValue valueWithCGPoint:diff]];
    if ([PointUtil getPoint:FOLLOWER_DX] < self._dx1) {
        self._dx1 = 0;
        [[GameScene sharedInstance].playerController moveFollower:1 points:self._follower1Points];
        self._follower1Points = [NSMutableArray array];
    }
    if ([PointUtil getPoint:FOLLOWER_DX * 2] < self._dx2) {
        self._dx2 = 0;
        [[GameScene sharedInstance].playerController moveFollower:2 points:self._follower2Points];
        self._follower2Points = [NSMutableArray array];
    }
    self.position = ccp(x, y);
    [[GameScene sharedInstance].playerController followerUpdate];
    
    ///////////////////////////////////////////////////////////////
    // スピードアップ判定
    ///////////////////////////////////////////////////////////////
    if ([mapController checkSpeedUp:self.position]) {
        [self speedUp];
    }
}

- (void)dead {
    self._isStaged = false;
    [self stop];
    CCParticleSystem *deadParticle = [PlayerAnimation getDeadParticle];
    deadParticle.position = self.position;
    [[GameScene sharedInstance].effectLayer addChild:deadParticle];
    [self removeFromParentAndCleanup:NO];
}

- (CGPoint)getCenterBottomPosition {
    return ccp(self.position.x, self.position.y - [self getHeight] / 2);
}
- (CGPoint)getCenterTopPosition {
    return ccp(self.position.x, self.position.y + [self getHeight] / 2);
}
- (CGPoint)getCenterRightPosition {
    return ccp(self.position.x + [self getWidth] / 2, self.position.y);
}
- (CGPoint)getTopLeftPosition {
    return ccp(self.position.x - [self getWidth] / 2, self.position.y + [self getHeight] / 2);
}
- (CGPoint)getTopRightPosition {
    return ccp(self.position.x + [self getWidth] / 2, self.position.y + [self getHeight] / 2);
}
- (CGPoint)getBottomLeftPosition {
    return ccp(self.position.x - [self getWidth] / 2, self.position.y - [self getHeight] / 2);
}
- (CGPoint)getBottomRightPosition {
    return ccp(self.position.x + [self getWidth] / 2, self.position.y - [self getHeight] / 2);
}

- (float)getWidth {
    return self._playerSprite.contentSize.width;
}

- (float)getHeight {
    return self._playerSprite.contentSize.height;
}

@end
