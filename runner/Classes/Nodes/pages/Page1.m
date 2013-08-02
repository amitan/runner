//
//  Page1.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/16.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page1.h"
#import "Block.h"
#import "PointUtil.h"
#import "Coin.h"

// 地面とコイン
@implementation Page1

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期設定
        self._coins = [NSMutableArray arrayWithCapacity:12];
        
        // 地面を追加
        self._land = [Block createBlock:1];
        self._land.position =  [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        // コインを追加
        Coin *coin1 = [Coin createCoin:1];
        Coin *coin2 = [Coin createCoin:1];
        Coin *coin3 = [Coin createCoin:1];
        Coin *coin4 = [Coin createCoin:1];
        Coin *coin5 = [Coin createCoin:1];
        Coin *coin6 = [Coin createCoin:1];
        Coin *coin11 = [Coin createCoin:1];
        Coin *coin12 = [Coin createCoin:1];
        Coin *coin13 = [Coin createCoin:1];
        Coin *coin14 = [Coin createCoin:1];
        Coin *coin15 = [Coin createCoin:1];
        Coin *coin16 = [Coin createCoin:1];
        self._lastCoin = coin16;

        coin1.position = [PointUtil getPosition:100 y:-720];
        coin2.position = [PointUtil getPosition:150 y:-720];
        coin3.position = [PointUtil getPosition:200 y:-720];
        coin4.position = [PointUtil getPosition:250 y:-720];
        coin5.position = [PointUtil getPosition:300 y:-720];
        coin6.position = [PointUtil getPosition:350 y:-720];
        coin11.position = [PointUtil getPosition:400 y:-720];
        coin12.position = [PointUtil getPosition:450 y:-720];
        
        coin13.position = [PointUtil getPosition:600 y:-600];
        coin14.position = [PointUtil getPosition:650 y:-550];
        coin15.position = [PointUtil getPosition:700 y:-550];
        coin16.position = [PointUtil getPosition:750 y:-600];

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
