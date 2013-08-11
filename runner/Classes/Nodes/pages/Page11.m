//
//  Page11.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/10.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page11.h"
#import "Trampoline.h"
#import "PointUtil.h"

@implementation Page11

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期設定
        self._trampolines = [NSMutableArray arrayWithCapacity:1];

        // 地面を追加
        self._land = [Block createBlock:1];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];

        // ブロック追加
        self._blocks = [NSArray arrayWithObjects:
                        [Block createBlock:110 x:160 y:-730],
                        [Block createBlock:110 x:220 y:-730], // ジャンプ台
                        [Block createBlock:101 x:500 y:-260],
                        [Block createBlock:101 x:560 y:-260],
                        [Block createBlock:101 x:620 y:-260],
                        [Block createBlock:101 x:680 y:-260],
                        [Block createBlock:101 x:740 y:-260],
                        [Block createBlock:101 x:800 y:-260],
                        [Block createBlock:101 x:860 y:-260],
                        [Block createBlock:101 x:920 y:-260],
                        [Block createBlock:101 x:980 y:-260],
                        [Block createBlock:101 x:1040 y:-260],
                        [Block createBlock:101 x:1100 y:-260],
                        nil];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // ジャンプ台
        self._trampolines = [NSArray arrayWithObjects:
                             [Trampoline createTrampoline:1 x:190 y:-685],
                             nil];
        for (Trampoline *trampoline in self._trampolines) {
            [trampoline stageOn:self];
        }
        
        // コインを追加
        self._coins = [NSArray arrayWithObjects:
                       [Coin createCoin:1 x:190 y:-600],
                       [Coin createCoin:1 x:190 y:-550],
                       [Coin createCoin:1 x:190 y:-500],
                       [Coin createCoin:1 x:240 y:-450],
                       [Coin createCoin:1 x:240 y:-400],
                       [Coin createCoin:1 x:240 y:-350],
                       [Coin createCoin:1 x:290 y:-300],
                       [Coin createCoin:1 x:290 y:-250],
                       [Coin createCoin:1 x:290 y:-200], // 縦コイン
                       [Coin createCoin:1 x:500 y:-200],
                       [Coin createCoin:1 x:560 y:-200],
                       [Coin createCoin:1 x:620 y:-200],
                       [Coin createCoin:1 x:680 y:-200],
                       [Coin createCoin:1 x:740 y:-200],
                       [Coin createCoin:1 x:800 y:-200],
                       [Coin createCoin:1 x:860 y:-200],
                       [Coin createCoin:1 x:920 y:-200],
                       [Coin createCoin:1 x:980 y:-200],
                       [Coin createCoin:1 x:1040 y:-200],
                       [Coin createCoin:1 x:1100 y:-200],
                       nil];
        self._lastCoin = [self._coins objectAtIndex:self._coins.count - 1];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

@end
