//
//  Page10102003.m
//  runner
//
//  Created by Ayumi Otomo on 2013/10/06.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page10102003.h"
#import "PointUtil.h"

@implementation Page10102003

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        Block *land = [Block createBlock:LAND_4];
        land.position = [self getLandPosition:land];
        [land stageOn:self];
        
        Block *land2 = [Block createBlock:LAND_8];
        land2.position = ccpAdd(ccp([land getRightX] + [PointUtil getPoint:120], 0), [self getLandPosition:land2]);
        [land2 stageOn:self];
        
        Block *land3 = [Block createBlock:LAND_8];
        land3.position = ccpAdd(ccp([land2 getRightX] + [PointUtil getPoint:120], 0), [self getLandPosition:land3]);
        [land3 stageOn:self];

        Block *land4 = [Block createBlock:LAND_2];
        land4.position = ccpAdd(ccp([land3 getRightX] + [PointUtil getPoint:120], 0), [self getLandPosition:land4]);
        [land4 stageOn:self];

        Block *land5 = [Block createBlock:LAND_12];
        land5.position = ccpAdd(ccp([land4 getRightX] + [PointUtil getPoint:120], 0), [self getLandPosition:land5]);
        [land5 stageOn:self];

        self._lands = @[land, land2, land3, land4, land5];
        
        // ブロック追加
        self._blocks = @[
                         // 下段ブロック
                         [Block createBlock:B_X2 bx:3 by:3],
                         [Block createBlock:B_X2 bx:7 by:3],
                         [Block createBlock:B_X2 bx:13 by:3],
                         [Block createBlock:B_X2 bx:17 by:3],
                         [Block createBlock:B_X2 bx:23 by:3],
                         [Block createBlock:B_X2 bx:27 by:3],
                         [Block createBlock:B_X2 bx:31 by:3],
                         [Block createBlock:B_X2 bx:37 by:3],
                         [Block createBlock:B_X2 bx:41 by:3],
                         // 中段ブロック
                         [Block createBlock:B_X2 bx:5 by:6],
                         [Block createBlock:B_X2 bx:7 by:6],
                         [Block createBlock:B_X2 bx:17 by:6],
                         [Block createBlock:B_X2 bx:21 by:6],
                         [Block createBlock:B_X2 bx:33 by:6],
                         [Block createBlock:B_X4 bx:39 by:6],
                         // 上段ブロック
                         [Block createBlock:B_X4 bx:7 by:9],
                         [Block createBlock:B_X4 bx:13 by:9],
                         [Block createBlock:B_X4 bx:23 by:9],
                         [Block createBlock:B_X4 bx:29 by:9],
                         ];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        self._coins = @[[Coin createCoin:C_STANDARD bx:[self getCoinBx:7 index:0] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:7 index:1] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:7 index:2] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:7 index:3] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:7 index:4] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:13 index:0] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:13 index:1] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:13 index:2] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:13 index:3] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:13 index:4] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:23 index:0] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:23 index:1] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:23 index:2] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:23 index:3] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:23 index:4] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:29 index:0] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:29 index:1] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:29 index:2] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:29 index:3] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:29 index:4] by:10],
                        [Coin createCoin:C_100 bx:39 by:8],
                        ];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

@end
