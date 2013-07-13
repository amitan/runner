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
@property (nonatomic, retain)CCSprite *_playerSprite;
@property (nonatomic, readwrite)BOOL _onGround;
@property (nonatomic, readwrite)int _jumNum;
@property (nonatomic, readwrite)float _vx;
@property (nonatomic, readwrite)float _vy;
@end

@implementation Player
const int JUMP_SPEED = 1000;
const int GRAVITY = 30;
const int INIT_SPEED = 100;

+ (Player*)createPlayer:(int)enemyId {
    return [[[self alloc] initWithEnemyId:enemyId] autorelease];
}

- (id)initWithEnemyId:(int)enemyId {
    self = [super init];
	if (self) {
        
        // 初期値設定
        self._enemyId = enemyId;
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
    [PointUtil setPosition:self x:100 y:760 offsetX:0 offsetY:-self._playerSprite.contentSize.height / 2];
    [[GameScene sharedInstance].gameLayer addChild:self];
}

- (void)start {
    [self._playerSprite runAction:[PlayerAnimation getWalkAnimation:self._enemyId]];
    [self scheduleUpdate];
}

- (void)stop {
    [self unscheduleUpdate];
    [self stopAllActions];
}

- (void)jump {
    if ((self._jumNum == 0 && self._onGround) || self._jumNum < 2) {
        self._jumNum++;
        self._vy += JUMP_SPEED;
    }
}

- (void)update:(ccTime)dt {

    MapController *mapController = [GameScene sharedInstance].mapController;

    // 横軸の判定
    float x = self.position.x;
    float dx = self._vx * dt;
    CGPoint nextRightXPosition = ccpAdd([self getRightPosition], ccp(dx, 0));
    
    // ブロックに衝突している場合はプレイヤーも一緒に移動
    Block *blockX = [mapController getCollidedBlock:nextRightXPosition];
    if (blockX) {
        x = blockX.position.x - [blockX getWidth] / 2 - self._playerSprite.contentSize.width / 2;
    }
    // マップスクロール
    [mapController scroll:dx];
    
    // 縦軸の判定
    self._vy -= GRAVITY;
    float y = self.position.y;
    float dy = self._vy * dt;
    CGPoint nextCenterBottomYPosition = ccpAdd([self getCenterBottomPosition], ccp(0, dy));
    
    // 衝突するブロックがなければ移動
    Block *blockY = [mapController getCollidedBlock:nextCenterBottomYPosition];
    if (!blockY) {
        y += dy;
        self._onGround = false; // 衝突していないので空中
    } else {
        
        // 着地
        if (self._vy <= 0) {
            y = blockY.position.y + [blockY getHeight] / 2 + self._playerSprite.contentSize.height / 2;
            self._vy = 0;
            self._jumNum = 0;
            self._onGround = true;
        }
    }
    
    self.position = ccp(x, y);
}

- (CGPoint)getCenterBottomPosition {
    return ccp(self.position.x, self.position.y - self._playerSprite.contentSize.height / 2);
}
- (CGPoint)getRightPosition {
    return ccp(self.position.x + self._playerSprite.contentSize.width / 2, self.position.y);
}

@end
