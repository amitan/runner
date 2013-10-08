//
//  Page10101001.m
//  runner
//
//  Created by Ayumi Otomo on 2013/10/05.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page10101001.h"


@implementation Page10101001

- (id)init {
    self = [super init];
	if (self) {

        // 地面を追加
        Block *land = [Block createBlock:LAND_LONG];
        land.position = [self getLandPosition:land];
        [land stageOn:self];
        self._lands = @[land];
        
        // ブロック追加
        self._blocks = @[[Block createBlock:B_X2 bx:25 by:6],
                         [Block createBlock:B_HATENA bx:27 by:6],
                         [Block createBlock:B_X7 bx:28 by:6],
                         [Block createBlock:B_X4 bx:35 by:10],
                         [Block createBlock:B_X4 bx:42 by:10],
                         ];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }

        // コインを追加
        self._coins = @[[Coin createCoin:C_STANDARD bx:[self getCoinBx:7 index:0] by:5],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:7 index:1] by:5],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:7 index:2] by:5],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:7 index:3] by:5],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:7 index:4] by:5],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:13 index:0] by:6],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:13 index:1] by:6],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:13 index:2] by:6],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:13 index:3] by:6],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:13 index:4] by:6],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:19 index:0] by:5],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:19 index:1] by:5],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:19 index:2] by:5],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:19 index:3] by:5],
                        [Coin createCoin:C_STANDARD bx:[self getCoinBx:19 index:4] by:5],
                        [Coin createCoin:C_STANDARD bx:26 by:9],
                        [Coin createCoin:C_STANDARD bx:28 by:9],
                        [Coin createCoin:C_STANDARD bx:30 by:9],
                        [Coin createCoin:C_STANDARD bx:32 by:9],
                        [Coin createCoin:C_100 bx:40 by:11],
                        ];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }        
    }
    return self;
}

@end
