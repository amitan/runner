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

@interface Player ()
@property (nonatomic, readwrite)int _monsterId;
@property (nonatomic, readwrite)BOOL _isStaged;
@property (nonatomic, readwrite)int _jumpNum, _currentJumpNum;
@property (nonatomic, retain)CCSprite *_playerSprite;
@property (nonatomic, readwrite)BOOL _onGround, _isAdjusting;
@property (nonatomic, readwrite)float _vx, _vy;
@property (nonatomic, readwrite)float _properPositionX;
@property (nonatomic, readwrite)float _limitX, _limitY;
@end

@implementation Player
const int JUMP_SPEED = 1000;
const int GRAVITY = 30;
const int INIT_SPEED = 300;
const int ADJUST_DISTANCE = 1;
const int ADJUST_LIMIT = 50;

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
        self._vx = INIT_SPEED;
        self._isAdjusting = false;
        self._limitX = winSize.width / 2 - [PointUtil getPoint:BASE_WIDTH / 2];
        self._limitY = winSize.height / 2 - [PointUtil getPoint:BASE_HEIGHT / 2];
        
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

- (void)stageOn:(int)order { // TODO:: orderの実装
    self._isStaged = true;
    [PointUtil setPosition:self x:150 y:760 offsetX:0 offsetY:-self._playerSprite.contentSize.height / 2];
    self._properPositionX = self.position.x;
    [[GameScene sharedInstance].gameLayer addChild:self];
}

- (void)start {
    [self._playerSprite runAction:[PlayerAnimation getWalkAction:self._monsterId]];
    [self scheduleUpdate];
}

- (void)stop {
    [self unscheduleUpdate];
    [self stopAllActions];
}

- (void)jump {
    if ((self._currentJumpNum == 0 && self._onGround) || (self._currentJumpNum != 0 && self._currentJumpNum < self._jumpNum)) {
        self._currentJumpNum++;
        self._vy += JUMP_SPEED;
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
                x = self.position.x + ADJUST_DISTANCE;
            }
        } else { // 規定値より後ろにいる場合
            if (self._properPositionX - ADJUST_LIMIT > self.position.x) {
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
        self._vy += JUMP_SPEED * 1.5;
        y += self._vy * dt;
    
    // ブロックチェック
    } else {
    
        // 着地判定
        Block *blockY = [mapController getHitBlock:nextCenterBottomYPosition];
        if (blockY) {
            if (self._vy <= 0) {
                y = [blockY getLandPoint] + self._playerSprite.contentSize.height / 2;
                self._vy = 0;
                self._currentJumpNum = 0;
                self._onGround = true;
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
    self.position = ccp(x, y);
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
