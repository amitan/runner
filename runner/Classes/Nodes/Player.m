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

@interface Player ()
@property (nonatomic, readwrite)int _enemyId;
@property (nonatomic, readwrite)int _jumpNum;
@property (nonatomic, retain)CCSprite *_playerSprite;
@property (nonatomic, readwrite)BOOL _onGround;
@property (nonatomic, readwrite)int _currentJumpNum;
@property (nonatomic, readwrite)float _vx;
@property (nonatomic, readwrite)float _vy;
@end

@implementation Player
const int JUMP_SPEED = 1000;
const int GRAVITY = 30;
const int INIT_SPEED = 300;

+ (Player*)createPlayer:(int)enemyId {
    return [[[self alloc] initWithEnemyId:enemyId] autorelease];
}

- (id)initWithEnemyId:(int)enemyId {
    self = [super init];
	if (self) {
        
        // 初期値設定
        self._enemyId = enemyId;
        self._jumpNum = 1;
        self._onGround = true;
        self._vx = INIT_SPEED;
                
        // アニメーションの最初のコマを読み込む
        NSString* fileName = [NSString stringWithFormat:@"enemy%d_right1.png", self._enemyId];
        self._playerSprite = [CCSprite spriteWithSpriteFrameName:fileName];
        [self addChild:self._playerSprite];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)stageOn:(int)order { // TODO:: orderの実装
    [PointUtil setPosition:self x:150 y:760 offsetX:0 offsetY:-self._playerSprite.contentSize.height / 2];
    [[GameScene sharedInstance].gameLayer addChild:self];
}

- (void)start {
    [self._playerSprite runAction:[PlayerAnimation getWalkAction:self._enemyId]];
    [self scheduleUpdate];
}

- (void)stop {
    [self unscheduleUpdate];
    [self stopAllActions];
}

- (void)jump {
    if ((self._currentJumpNum == 0 && self._onGround) || self._currentJumpNum < self._jumpNum) {
        self._currentJumpNum++;
        self._vy += JUMP_SPEED;
    }
}

- (void)update:(ccTime)dt {

    ///////////////////////////////////////////////////////////////
    // 当たり判定用座標計算
    ///////////////////////////////////////////////////////////////
    MapController *mapController = [GameScene sharedInstance].mapController;
    self._vy -= GRAVITY;
    float dx = self._vx * dt;
    float dy = self._vy * dt;
    float x = self.position.x;
    float y = self.position.y;

    ///////////////////////////////////////////////////////////////
    // コイン/アイテム判定
    ///////////////////////////////////////////////////////////////
    if ([mapController checkHitCoins:[self getTopLeftPosition]]) {
    } else if ([mapController checkHitCoins:[self getTopRightPosition]]) {
    } else if ([mapController checkHitCoins:[self getBottomLeftPosition]]) {
    } else if ([mapController checkHitCoins:[self getBottomRightPosition]]) {
    }

    ///////////////////////////////////////////////////////////////
    // 横軸の判定
    ///////////////////////////////////////////////////////////////
    CGPoint nextRightXPosition = ccpAdd([self getCenterRightPosition], ccp(dx, 0));
    
    // ブロックに衝突している場合はプレイヤーも一緒に移動
    Block *blockX = [mapController getHitBlock:nextRightXPosition];
    if (blockX) {
        x = [blockX getLeftPoint] - self._playerSprite.contentSize.width / 2;
    } else {
        
    }
    
    // マップスクロール
    [mapController scroll:dx];
    
    ///////////////////////////////////////////////////////////////
    // 縦軸の判定
    ///////////////////////////////////////////////////////////////
    CGPoint nextCenterBottomYPosition = ccpAdd([self getCenterBottomPosition], ccp(0, dy));
    
    // 衝突するブロックがなければ移動
    Block *blockY = [mapController getHitBlock:nextCenterBottomYPosition];
    if (!blockY) {
        y += dy;
        self._onGround = false; // 衝突していないので空中
    } else {
        
        // 着地
        if (self._vy <= 0) {
            y = [blockY getLandPoint] + self._playerSprite.contentSize.height / 2;
            self._vy = 0;
            self._currentJumpNum = 0;
            self._onGround = true;
        }
    }
    self.position = ccp(x, y);
}

- (CGPoint)getCenterBottomPosition {
    return ccp(self.position.x, self.position.y - [self getHeight] / 2);
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
