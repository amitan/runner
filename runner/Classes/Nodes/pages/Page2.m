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
        
        // 初期設定
        self._blocks = [NSMutableArray arrayWithCapacity:14];
        self._coins = [NSMutableArray arrayWithCapacity:16];

        // 地面を追加
        self._land = [Block createBlock:1];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        // ブロック追加
        Block *block1 = [Block createBlock:101];
        Block *block2 = [Block createBlock:101];
        Block *block3 = [Block createBlock:101];
        Block *block4 = [Block createBlock:101];
        Block *block11 = [Block createBlock:101];
        Block *block12 = [Block createBlock:101];
        Block *block13 = [Block createBlock:101];
        Block *block14 = [Block createBlock:101];
        Block *block21 = [Block createBlock:101];
        Block *block22 = [Block createBlock:101];
        Block *block23 = [Block createBlock:101];
        Block *block24 = [Block createBlock:101];
        Block *block25 = [Block createBlock:101];
        Block *block26 = [Block createBlock:101];
        
        block1.position = [PointUtil getPosition:300 y:-730];
        block2.position = [PointUtil getPosition:300 y:-670];
        block3.position = [PointUtil getPosition:360 y:-730];
        block4.position = [PointUtil getPosition:360 y:-670];
        block11.position = [PointUtil getPosition:640 y:-730];
        block12.position = [PointUtil getPosition:640 y:-670];
        block13.position = [PointUtil getPosition:700 y:-730];
        block14.position = [PointUtil getPosition:700 y:-670];
        block21.position = [PointUtil getPosition:970 y:-730];
        block22.position = [PointUtil getPosition:970 y:-670];
        block23.position = [PointUtil getPosition:970 y:-610];
        block24.position = [PointUtil getPosition:1030 y:-730];
        block25.position = [PointUtil getPosition:1030 y:-670];
        block26.position = [PointUtil getPosition:1030 y:-610];

        [self._blocks addObject:block1];
        [self._blocks addObject:block2];
        [self._blocks addObject:block3];
        [self._blocks addObject:block4];
        [self._blocks addObject:block11];
        [self._blocks addObject:block12];
        [self._blocks addObject:block13];
        [self._blocks addObject:block14];
        [self._blocks addObject:block21];
        [self._blocks addObject:block22];
        [self._blocks addObject:block23];
        [self._blocks addObject:block24];
        [self._blocks addObject:block25];
        [self._blocks addObject:block26];
        
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        Coin *coin1 = [Coin createCoin:1];
        Coin *coin2 = [Coin createCoin:1];
        Coin *coin3 = [Coin createCoin:1];
        Coin *coin4 = [Coin createCoin:1];
        Coin *coin11 = [Coin createCoin:1];
        Coin *coin12 = [Coin createCoin:1];
        Coin *coin13 = [Coin createCoin:1];
        Coin *coin14 = [Coin createCoin:1];
        Coin *coin15 = [Coin createCoin:1];
        Coin *coin16 = [Coin createCoin:1];
        Coin *coin21 = [Coin createCoin:1];
        Coin *coin22 = [Coin createCoin:1];
        Coin *coin23 = [Coin createCoin:1];
        Coin *coin24 = [Coin createCoin:1];
        Coin *coin25 = [Coin createCoin:1];
        Coin *coin26 = [Coin createCoin:1];
        self._lastCoin = coin16;

        coin1.position = [PointUtil getPosition:100 y:-600];
        coin2.position = [PointUtil getPosition:150 y:-550];
        coin3.position = [PointUtil getPosition:200 y:-500];
        coin4.position = [PointUtil getPosition:250 y:-500];
        
        // ブロックの上
        coin11.position = [PointUtil getPosition:300 y:-596];
        coin12.position = [PointUtil getPosition:360 y:-596];
        coin13.position = [PointUtil getPosition:640 y:-596];
        coin14.position = [PointUtil getPosition:700 y:-596];
        coin15.position = [PointUtil getPosition:970 y:-532];
        coin16.position = [PointUtil getPosition:1030 y:-532];
        
        coin21.position = [PointUtil getPosition:450 y:-450];
        coin22.position = [PointUtil getPosition:500 y:-400];
        coin23.position = [PointUtil getPosition:550 y:-450];
        coin24.position = [PointUtil getPosition:786 y:-400];
        coin25.position = [PointUtil getPosition:836 y:-350];
        coin26.position = [PointUtil getPosition:886 y:-400];
        

        [self._coins addObject:coin1];
        [self._coins addObject:coin2];
        [self._coins addObject:coin3];
        [self._coins addObject:coin4];
        [self._coins addObject:coin11];
        [self._coins addObject:coin12];
        [self._coins addObject:coin13];
        [self._coins addObject:coin14];
        [self._coins addObject:coin15];
        [self._coins addObject:coin16];
        [self._coins addObject:coin21];
        [self._coins addObject:coin22];
        [self._coins addObject:coin23];
        [self._coins addObject:coin24];
        [self._coins addObject:coin25];
        [self._coins addObject:coin26];

        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

@end
