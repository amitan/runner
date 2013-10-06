//
//  Page10101003.m
//  runner
//
//  Created by Ayumi Otomo on 2013/10/05.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page10101003.h"


@implementation Page10101003

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        self._land = [Block createBlock:LAND_LONG];
        self._land.position =  [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        // ブロック追加
        self._blocks = @[[Block createBlock:B_X2 bx:3 by:5],
                         [Block createBlock:B_X2 bx:7 by:7],
                         [Block createBlock:B_X2 bx:11 by:9],
                         [Block createBlock:B_X6 bx:17 by:5],
                         [Block createBlock:B_X6 bx:25 by:7],
                         
                         // 階段
                         [Block createBlock:B_X8 bx:35 by:3],
                         [Block createBlock:B_X7 bx:36 by:4],
                         [Block createBlock:B_X6 bx:37 by:5],
                         [Block createBlock:B_X5 bx:38 by:6],
                         [Block createBlock:B_X4 bx:39 by:7],
                         [Block createBlock:B_X3 bx:40 by:8],
                         [Block createBlock:B_X2 bx:41 by:9],
                         ];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        self._coins = @[
                        [Coin createCoin:C_100 bx:14 by:10],
                        [Coin createCoin:C_STANDARD bx:18 by:6],
                        [Coin createCoin:C_STANDARD bx:19 by:6],
                        [Coin createCoin:C_STANDARD bx:20 by:6],
                        [Coin createCoin:C_STANDARD bx:21 by:6],
                        [Coin createCoin:C_STANDARD bx:22 by:6],
                        [Coin createCoin:C_STANDARD bx:26 by:8],
                        [Coin createCoin:C_STANDARD bx:27 by:8],
                        [Coin createCoin:C_STANDARD bx:28 by:8],
                        [Coin createCoin:C_STANDARD bx:29 by:8],
                        [Coin createCoin:C_STANDARD bx:30 by:8],
                        ];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

@end
