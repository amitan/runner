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
        
        // 地面を追加
        self._land = [Block createBlock:1];
        self._land.position =  [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        // コインを追加
        self._coins = [NSArray arrayWithObjects:
                       [Coin createCoin:1 x:100 y:-720],
                       [Coin createCoin:1 x:150 y:-720],
                       [Coin createCoin:1 x:200 y:-720],
                       [Coin createCoin:1 x:250 y:-720],
                       [Coin createCoin:1 x:300 y:-720],
                       [Coin createCoin:1 x:350 y:-720],
                       [Coin createCoin:1 x:400 y:-720],
                       [Coin createCoin:1 x:450 y:-720],
                       [Coin createCoin:1 x:600 y:-600],
                       [Coin createCoin:1 x:650 y:-550],
                       [Coin createCoin:1 x:700 y:-550],
                       [Coin createCoin:1 x:750 y:-600],
                       nil];
        self._lastCoin = [self._coins objectAtIndex:self._coins.count - 1];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

@end
