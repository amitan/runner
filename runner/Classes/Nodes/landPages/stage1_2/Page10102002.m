//
//  Page10102002.m
//  runner
//
//  Created by Ayumi Otomo on 2013/10/06.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page10102002.h"
#import "PointUtil.h"

@implementation Page10102002

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        Block *land = [Block createBlock:LAND_17];
        land.position = [self getLandPosition:land];
        [land stageOn:self];
        
        Block *land2 = [Block createBlock:LAND_8];
        land2.position = ccpAdd(ccp([land getRightX] + [PointUtil getPoint:240], 0), [self getLandPosition:land2]);
        [land2 stageOn:self];

        Block *land3 = [Block createBlock:LAND_9];
        land3.position = ccpAdd(ccp([land2 getRightX] + [PointUtil getPoint:240], 0), [self getLandPosition:land3]);
        [land3 stageOn:self];

        self._lands = @[land, land2, land3];
        
        // ブロック追加
        self._blocks = @[[Block createBlock:B_X2 bx:3 by:5],
                         [Block createBlock:B_X2 bx:7 by:5],
                         [Block createBlock:B_X2 bx:11 by:5],
                         [Block createBlock:B_X2 bx:15 by:7],
                         [Block createBlock:B_X2 bx:19 by:7],
                         [Block createBlock:B_X2 bx:23 by:7],
                         [Block createBlock:B_X2 bx:27 by:9],
                         [Block createBlock:B_X2 bx:31 by:9],
                         [Block createBlock:B_X2 bx:35 by:9],
                         ];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        self._coins = @[[Coin createCoin:C_STANDARD bx:[self getCoinBx:3.5 index:0] by:6],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:3.5 index:1] by:6],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:7.5 index:0] by:6],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:7.5 index:1] by:6],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:11.5 index:0] by:6],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:11.5 index:1] by:6],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:15.5 index:0] by:8],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:15.5 index:1] by:8],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:19.5 index:0] by:8],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:19.5 index:1] by:8],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:23.5 index:0] by:8],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:23.5 index:1] by:8],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:27.5 index:0] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:27.5 index:1] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:31.5 index:0] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:31.5 index:1] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:35.5 index:0] by:10],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:35.5 index:1] by:10],
                        [Coin createCoin:C_100 bx:39 by:10],
                        ];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

@end
