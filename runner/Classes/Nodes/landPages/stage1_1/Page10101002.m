//
//  Page10101002.m
//  runner
//
//  Created by Ayumi Otomo on 2013/10/05.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page10101002.h"
#import "PointUtil.h"

@implementation Page10101002

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        Block *land = [Block createBlock:LAND_24];
        land.position = [self getLandPosition:land];
        [land stageOn:self];

        float rightX = land.position.x + [land getWidth] / 2;
        Block *land2 = [Block createBlock:LAND_6];
        land2.position = ccpAdd(ccp(rightX + [PointUtil getPoint:240], 0), [self getLandPosition:land2]);
        [land2 stageOn:self];

        float rightX2 = land2.position.x + [land2 getWidth] / 2;
        Block *land3 = [Block createBlock:LAND_4];
        land3.position = ccpAdd(ccp(rightX2 + [PointUtil getPoint:240], 0), [self getLandPosition:land3]);
        [land3 stageOn:self];
        self._lands = @[land, land2, land3];
        
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
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:39 index:0] by:5],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:39 index:1] by:5],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:39 index:2] by:5],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:39 index:3] by:5],
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

@end
