//
//  Page10102001.m
//  runner
//
//  Created by Ayumi Otomo on 2013/10/06.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page10102001.h"
#import "PointUtil.h"

@implementation Page10102001

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        Block *land = [Block createBlock:LAND_30];
        land.position = [self getLandPosition:land];
        [land stageOn:self];
        
        Block *land2 = [Block createBlock:LAND_8];
        land2.position = ccpAdd(ccp([land getRightX] + [PointUtil getPoint:240], 0), [self getLandPosition:land2]);
        [land2 stageOn:self];

        self._lands = @[land, land2];
        
        // ブロック追加
        self._blocks = @[[Block createBlock:B_X6 bx:9 by:5],
                         [Block createBlock:B_HATENA bx:12 by:8],
                         [Block createBlock:B_X2 bx:17 by:5],
                         [Block createBlock:B_X10 bx:19 by:5],
                         [Block createBlock:B_STANDARD bx:19 by:8],
                         [Block createBlock:B_HATENA bx:20 by:8],
                         [Block createBlock:B_X4 bx:21 by:8],
                         [Block createBlock:B_HATENA bx:25 by:8],
                         [Block createBlock:B_X8 bx:28 by:8],
                         ];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        self._coins = @[[Coin createCoin:C_STANDARD bx:[self getCoinBx:9 index:0] by:6],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:9 index:1] by:6],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:9 index:2] by:6],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:9 index:3] by:6],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:9 index:4] by:6],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:9 index:5] by:6],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:9 index:6] by:6],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:9 index:7] by:6],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:17 index:0] by:6],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:17 index:1] by:6],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:37 index:0] by:5],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:37 index:1] by:5],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:37 index:2] by:5],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:37 index:3] by:5],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:37 index:4] by:5],
                        [Coin createCoin:C_100 bx:32 by:10],
                        ];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

@end
