//
//  Page6.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/28.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page6.h"
#import "PointUtil.h"

// ブロック横5個が4段とコイン
@implementation Page6

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期設定
        self._blocks = [NSMutableArray arrayWithCapacity:4];
        self._coins = [NSMutableArray arrayWithCapacity:20];
        
        // 地面を追加
        self._land = [Block createBlock:3];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        // ブロック追加
        Block *block1 = [Block createBlock:102];
        Block *block2 = [Block createBlock:102];
        Block *block3 = [Block createBlock:102];
        Block *block4 = [Block createBlock:102];
        
        block1.position = [PointUtil getPosition:170 y:-730];
        block2.position = [PointUtil getPosition:530 y:-570];
        block3.position = [PointUtil getPosition:890 y:-410];
        block4.position = [PointUtil getPosition:1250 y:-250];
        
        [self._blocks addObject:block1];
        [self._blocks addObject:block2];
        [self._blocks addObject:block3];
        [self._blocks addObject:block4];
        
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        Coin *coin1 = [Coin createCoin:1];
        Coin *coin2 = [Coin createCoin:1];
        Coin *coin3 = [Coin createCoin:1];
        Coin *coin4 = [Coin createCoin:1];
        Coin *coin5 = [Coin createCoin:1];
        Coin *coin6 = [Coin createCoin:1];
        Coin *coin7 = [Coin createCoin:1];
        Coin *coin8 = [Coin createCoin:1];
        Coin *coin9 = [Coin createCoin:1];
        Coin *coin10 = [Coin createCoin:1];
        Coin *coin11 = [Coin createCoin:1];
        Coin *coin12 = [Coin createCoin:1];
        Coin *coin13 = [Coin createCoin:1];
        Coin *coin14 = [Coin createCoin:1];
        Coin *coin15 = [Coin createCoin:1];
        Coin *coin16 = [Coin createCoin:1];
        Coin *coin17 = [Coin createCoin:1];
        Coin *coin18 = [Coin createCoin:1];
        Coin *coin19 = [Coin createCoin:1];
        Coin *coin20 = [Coin createCoin:1];
        self._lastCoin = coin20;

        coin1.position = [PointUtil getPosition:50 y:-660];
        coin2.position = [PointUtil getPosition:110 y:-660];
        coin3.position = [PointUtil getPosition:170 y:-660];
        coin4.position = [PointUtil getPosition:230 y:-660];
        coin5.position = [PointUtil getPosition:290 y:-660];
        coin6.position = [PointUtil getPosition:410 y:-500];
        coin7.position = [PointUtil getPosition:470 y:-500];
        coin8.position = [PointUtil getPosition:530 y:-500];
        coin9.position = [PointUtil getPosition:590 y:-500];
        coin10.position = [PointUtil getPosition:650 y:-500];
        coin11.position = [PointUtil getPosition:770 y:-340];
        coin12.position = [PointUtil getPosition:830 y:-340];
        coin13.position = [PointUtil getPosition:890 y:-340];
        coin14.position = [PointUtil getPosition:950 y:-340];
        coin15.position = [PointUtil getPosition:1010 y:-340];
        coin16.position = [PointUtil getPosition:1130 y:-180];
        coin17.position = [PointUtil getPosition:1190 y:-180];
        coin18.position = [PointUtil getPosition:1250 y:-180];
        coin19.position = [PointUtil getPosition:1310 y:-180];
        coin20.position = [PointUtil getPosition:1370 y:-180];
        
        [self._coins addObject:coin1];
        [self._coins addObject:coin2];
        [self._coins addObject:coin3];
        [self._coins addObject:coin4];
        [self._coins addObject:coin5];
        [self._coins addObject:coin6];
        [self._coins addObject:coin7];
        [self._coins addObject:coin8];
        [self._coins addObject:coin9];
        [self._coins addObject:coin10];
        [self._coins addObject:coin11];
        [self._coins addObject:coin12];
        [self._coins addObject:coin13];
        [self._coins addObject:coin14];
        [self._coins addObject:coin15];
        [self._coins addObject:coin16];
        [self._coins addObject:coin17];
        [self._coins addObject:coin18];
        [self._coins addObject:coin19];
        [self._coins addObject:coin20];

        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }

    }
    return self;
}

@end
