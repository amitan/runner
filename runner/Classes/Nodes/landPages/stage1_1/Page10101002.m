//
//  Page10101002.m
//  runner
//
//  Created by Ayumi Otomo on 2013/10/05.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page10101002.h"
#import "PointUtil.h"

@interface Page10101002 ()
@property (nonatomic, retain)Block *_land2;
@property (nonatomic, retain)Block *_land3;
@property (nonatomic, readwrite)float _interval1;
@property (nonatomic, readwrite)float _interval2;
@end

@implementation Page10101002

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期値設定
        self._interval1 = [PointUtil getPoint:240];
        self._interval2 = [PointUtil getPoint:240];
        
        // 地面を追加
        self._land = [Block createBlock:LAND_1440];
        self._land.position =  [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        float rightX = self._land.position.x + [self._land getWidth] / 2;
        self._land2 = [Block createBlock:LAND_360];
        self._land2.position = ccpAdd(ccp(rightX + self._interval1, 0), [self getLandPosition:self._land2]);
        [self._land2 stageOn:self];

        float rightX2 = self._land2.position.x + [self._land2 getWidth] / 2;
        self._land3 = [Block createBlock:LAND_240];
        self._land3.position = ccpAdd(ccp(rightX2 + self._interval2, 0), [self getLandPosition:self._land3]);
        [self._land3 stageOn:self];
        
        // ブロック追加
        self._blocks = @[[Block createBlock:B_X2Y2 bx:5 by:4],
                         [Block createBlock:B_X2Y2 bx:10 by:4],
                         [Block createBlock:B_X2Y2 bx:15 by:4],
                         [Block createBlock:B_X2Y2 bx:20 by:4]
                         ];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        self._coins = @[
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:8 index:0] by:7],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:8 index:1] by:7],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:13 index:0] by:7],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:13 index:1] by:7],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:18 index:0] by:7],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:18 index:1] by:7],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:30 index:0] by:3],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:30 index:1] by:3],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:30 index:2] by:3],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:30 index:3] by:3],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:30 index:4] by:3],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:40 index:0] by:5],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:40 index:1] by:5],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:40 index:2] by:5],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:40 index:3] by:5],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:40 index:4] by:5],
                        ];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }

        // エネミー追加
        self._enemies = @[[Enemy createEnemy:E_SLYME bx:8 by:3],
                          [Enemy createEnemy:E_SLYME bx:13 by:3],
                          [Enemy createEnemy:E_SLYME bx:18 by:3],
                          ];
        for (Enemy *enemy in self._enemies) {
            [enemy stageOn:self];
        }
    }
    return self;
}

- (float)getWidth {
    return self._land3.position.x + [self._land3 getWidth] / 2
    - self._land.position.x + [self._land getWidth] / 2;
}

- (Block*)getHitBlock:(CGPoint)point {
    for (Block *block in self._blocks) {
        if ([block isHit:point]) return block;
    }
    if ([self._land isHit:point]) return self._land;
    if ([self._land2 isHit:point]) return self._land2;
    if ([self._land3 isHit:point]) return self._land3;
    return NULL;
}

@end
