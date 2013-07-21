//
//  Page2.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/16.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page2.h"
#import "Block.h"
#import "PointUtil.h"
#import "Coin.h"

// 地面とコイン
@implementation Page2

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期設定
        self._coins = [NSMutableArray arrayWithCapacity:12];
        
        // 地面を追加
        self._land = [Block createBlock:1];
        self._land.position = [PointUtil getPosition:[self._land getWidth] / 2 y:-BASE_HEIGHT + [self._land getHeight] / 2];
        [self._land stageOn:self];
        
        // コインを追加
        Coin *coin1 = [Coin node];
        Coin *coin2 = [Coin node];
        Coin *coin3 = [Coin node];
        Coin *coin4 = [Coin node];
        Coin *coin5 = [Coin node];
        Coin *coin6 = [Coin node];        
        Coin *coin11 = [Coin node];
        Coin *coin12 = [Coin node];
        Coin *coin13 = [Coin node];
        Coin *coin14 = [Coin node];
        Coin *coin15 = [Coin node];
        Coin *coin16 = [Coin node];
        self._lastCoin = coin16;

        coin1.position = [PointUtil getPosition:100 y:-600];
        coin2.position = [PointUtil getPosition:150 y:-550];
        coin3.position = [PointUtil getPosition:200 y:-500];
        coin4.position = [PointUtil getPosition:250 y:-500];
        coin5.position = [PointUtil getPosition:300 y:-550];
        coin6.position = [PointUtil getPosition:350 y:-600];
        
        coin11.position = [PointUtil getPosition:550 y:-600];
        coin12.position = [PointUtil getPosition:600 y:-550];
        coin13.position = [PointUtil getPosition:650 y:-500];
        coin14.position = [PointUtil getPosition:700 y:-500];
        coin15.position = [PointUtil getPosition:750 y:-550];
        coin16.position = [PointUtil getPosition:800 y:-600];

        [self._coins addObject:coin1];
        [self._coins addObject:coin2];
        [self._coins addObject:coin3];
        [self._coins addObject:coin4];
        [self._coins addObject:coin5];
        [self._coins addObject:coin6];
        [self._coins addObject:coin11];
        [self._coins addObject:coin12];
        [self._coins addObject:coin13];
        [self._coins addObject:coin14];
        [self._coins addObject:coin15];
        [self._coins addObject:coin16];
        
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

@end
