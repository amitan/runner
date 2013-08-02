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
        
        // 初期設定
        self._blocks = [NSMutableArray arrayWithCapacity:3];
        self._coins = [NSMutableArray arrayWithCapacity:1];
        
        // 地面を追加
        self._land = [Block createBlock:3];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        // ブロック追加
        Block *block1 = [Block createBlock:101];
        Block *block2 = [Block createBlock:101];
        Block *block3 = [Block createBlock:101];
        
        block1.position = [PointUtil getPosition:300 y:-730];
        block2.position = [PointUtil getPosition:300 y:-670];
        block3.position = [PointUtil getPosition:300 y:-610];
        
        [self._blocks addObject:block1];
        [self._blocks addObject:block2];
        [self._blocks addObject:block3];
        
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        Coin *coin1 = [Coin createCoin:2];
        coin1.position = [PointUtil getPosition:500 y:-300];
        [self._coins addObject:coin1];
        
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

@end
