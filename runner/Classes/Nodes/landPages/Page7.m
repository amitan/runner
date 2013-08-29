//
//  Page7.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/01.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page7.h"
#import "PointUtil.h"
#import "Block.h"

// ブロック縦3個とでかコイン
@implementation Page7

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        self._land = [Block createBlock:3];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        // ブロック追加
        self._blocks = @[[Block createBlock:101 x:300 y:-490],
                        [Block createBlock:101 x:300 y:-430],
                        [Block createBlock:101 x:300 y:-370]];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        self._coins = @[[Coin createCoin:2 x:500 y:-60],
                        [Coin createCoin:1 x:700 y:-495],
                        [Coin createCoin:1 x:750 y:-495],
                        [Coin createCoin:1 x:800 y:-495],
                        [Coin createCoin:1 x:850 y:-495],
                        [Coin createCoin:1 x:900 y:-495],
                        [Coin createCoin:1 x:950 y:-495],
                        [Coin createCoin:1 x:1000 y:-495],
                        [Coin createCoin:1 x:1050 y:-495],
                        [Coin createCoin:1 x:1100 y:-495],
                        [Coin createCoin:1 x:1150 y:-495],
                        [Coin createCoin:1 x:1200 y:-495],
                        [Coin createCoin:1 x:1250 y:-495],
                        [Coin createCoin:1 x:1300 y:-495],
                        [Coin createCoin:1 x:1350 y:-495],
                        [Coin createCoin:1 x:1400 y:-495],
                        [Coin createCoin:1 x:1450 y:-495]];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }        
    }
    return self;
}

@end
