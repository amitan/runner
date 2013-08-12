//
//  DroppingCoin.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/01.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "DroppingCoin.h"
#import "PointUtil.h"
#import "MapController.h"
#import "GameScene.h"

@interface DroppingCoin ()
@property (nonatomic, readwrite)float _vy;
@property (nonatomic, readwrite)float _boundsFactor;
@end

@implementation DroppingCoin
const int COIN_GRAVITY = 100;
const int INIT_BOUNDS_FACTOR = 3000;

- (id)initWithCoinId:(int)coinId groupId:(int)groupId {
    self = [super initWithCoinId:coinId groupId:groupId];
    if (self) {
        self._boundsFactor = INIT_BOUNDS_FACTOR;
    }
    return self;
}

- (void)drop {
    [self scheduleUpdate];
}

// アニメーションさせない
- (void)start {
}
- (void)stop {
    [self unscheduleUpdate];
}

- (void)reset {
    [super reset];
    self._vy = 0;
    self._boundsFactor = INIT_BOUNDS_FACTOR;
}

- (void)update:(ccTime)dt {
    
    // ステージ上にいなければ何も処理しない
    if (!self._isStaged) return;
    MapController *mapController = [GameScene sharedInstance].mapController;

    ///////////////////////////////////////////////////////////////
    // 当たり判定用座標計算
    ///////////////////////////////////////////////////////////////
    self._vy -= [PointUtil getPoint:COIN_GRAVITY];
    float dy = self._vy * dt;
    float x = self.position.x;
    float y = self.position.y;
    
    ///////////////////////////////////////////////////////////////
    // 縦軸の判定
    ///////////////////////////////////////////////////////////////
    CGPoint nextCenterBottomYPosition = ccpAdd([self getCenterBottomPosition], ccp(0, dy));
    
    // 着地判定
    BOOL isHit = false;
    Block *blockY = [mapController getHitBlock:nextCenterBottomYPosition];
    if (blockY) {
        if (self._vy <= 0) {
            y = [blockY getLandPoint] - [[self parent] parent].position.y - [self parent].position.y + [self getHeight] / 2;
            isHit = true;
            if (self._boundsFactor > 0) {
                self._boundsFactor = self._boundsFactor - floor(CCRANDOM_0_1() * self._boundsFactor) * 0.6;
                self._vy = [PointUtil getPoint:self._boundsFactor];
            } else {
                self._vy = 0;
            }
            y += self._vy * dt;
        }
    }
    if (!isHit) {
        y += dy;
    }
    
    ///////////////////////////////////////////////////////////////
    // 位置更新
    ///////////////////////////////////////////////////////////////
    self.position = ccp(x, y);
}

- (CGPoint)getCenterBottomPosition {
    return ccp(self.position.x + [self parent].position.x + [[self parent] parent].position.x,
               self.position.y - [self parent].position.y + [[self parent] parent].position.y - [self getHeight] / 2);
}

@end
