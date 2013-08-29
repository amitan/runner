//
//  Page2.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/20.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page2.h"
#import "Block.h"
#import "PointUtil.h"
#import "Coin.h"

// ブロック縦に3つ並んでいて、間にコイン
@implementation Page2

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        self._land = [Block createBlock:1];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        // ブロック追加
        self._blocks = @[[Block createBlock:101 x:300 y:-490],
                        [Block createBlock:101 x:300 y:-430],
                        [Block createBlock:101 x:360 y:-490],
                        [Block createBlock:101 x:360 y:-430],
                        [Block createBlock:101 x:640 y:-490],
                        [Block createBlock:101 x:640 y:-430],
                        [Block createBlock:101 x:700 y:-490],
                        [Block createBlock:101 x:700 y:-430],
                        [Block createBlock:101 x:970 y:-490],
                        [Block createBlock:101 x:970 y:-430],
                        [Block createBlock:101 x:970 y:-370],
                        [Block createBlock:101 x:1030 y:-490],
                        [Block createBlock:101 x:1030 y:-430],
                        [Block createBlock:101 x:1030 y:-370]];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        self._coins = @[[Coin createCoin:1 x:100 y:-360],
                       [Coin createCoin:1 x:150 y:-310],
                       [Coin createCoin:1 x:200 y:-260],
                       [Coin createCoin:1 x:250 y:-260],
                       [Coin createCoin:1 x:300 y:-356],
                       [Coin createCoin:1 x:360 y:-356],
                       [Coin createCoin:1 x:450 y:-210],
                       [Coin createCoin:1 x:500 y:-160],
                       [Coin createCoin:1 x:550 y:-210],
                       [Coin createCoin:1 x:640 y:-356],
                       [Coin createCoin:1 x:700 y:-356],
                       [Coin createCoin:1 x:786 y:-210],
                       [Coin createCoin:1 x:836 y:-160],
                       [Coin createCoin:1 x:886 y:-210],
                       [Coin createCoin:1 x:970 y:-290],
                       [Coin createCoin:1 x:1030 y:-290]];
        self._lastCoin = [self._coins objectAtIndex:self._coins.count - 1];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

@end
