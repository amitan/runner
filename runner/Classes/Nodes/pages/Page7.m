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
        self._blocks = @[[Block createBlock:101 x:300 y:-730],
                        [Block createBlock:101 x:300 y:-670],
                        [Block createBlock:101 x:300 y:-610]];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        self._coins = @[[Coin createCoin:2 x:500 y:-300]];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

@end
