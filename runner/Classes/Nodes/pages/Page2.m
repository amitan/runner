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
        self._blocks = [NSArray arrayWithObjects:
                        [Block createBlock:101 x:300 y:-730],
                        [Block createBlock:101 x:300 y:-670],
                        [Block createBlock:101 x:360 y:-730],
                        [Block createBlock:101 x:360 y:-670],
                        [Block createBlock:101 x:640 y:-730],
                        [Block createBlock:101 x:640 y:-670],
                        [Block createBlock:101 x:700 y:-730],
                        [Block createBlock:101 x:700 y:-670],
                        [Block createBlock:101 x:970 y:-730],
                        [Block createBlock:101 x:970 y:-670],
                        [Block createBlock:101 x:970 y:-610],
                        [Block createBlock:101 x:1030 y:-730],
                        [Block createBlock:101 x:1030 y:-670],
                        [Block createBlock:101 x:1030 y:-610],
                        nil];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        self._coins = [NSArray arrayWithObjects:
                       [Coin createCoin:1 x:100 y:-600],
                       [Coin createCoin:1 x:150 y:-550],
                       [Coin createCoin:1 x:200 y:-500],
                       [Coin createCoin:1 x:250 y:-500],
                       [Coin createCoin:1 x:300 y:-596],
                       [Coin createCoin:1 x:360 y:-596],
                       [Coin createCoin:1 x:450 y:-450],
                       [Coin createCoin:1 x:500 y:-400],
                       [Coin createCoin:1 x:550 y:-450],
                       [Coin createCoin:1 x:640 y:-596],
                       [Coin createCoin:1 x:700 y:-596],
                       [Coin createCoin:1 x:786 y:-400],
                       [Coin createCoin:1 x:836 y:-350],
                       [Coin createCoin:1 x:886 y:-400],
                       [Coin createCoin:1 x:970 y:-530],
                       [Coin createCoin:1 x:1030 y:-530],
                       nil];
        self._lastCoin = [self._coins objectAtIndex:self._coins.count - 1];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

@end
