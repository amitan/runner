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
        
        // 地面を追加
        self._land = [Block createBlock:3];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        // ブロック追加
        self._blocks = [NSArray arrayWithObjects:
                        [Block createBlock:102 x:170 y:-730],
                        [Block createBlock:102 x:530 y:-570],
                        [Block createBlock:102 x:890 y:-410],
                        [Block createBlock:102 x:1250 y:-250],
                        nil];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        self._coins = @[[Coin createCoin:1 x:50 y:-660],
                       [Coin createCoin:1 x:110 y:-660],
                       [Coin createCoin:1 x:170 y:-660],
                       [Coin createCoin:1 x:230 y:-660],
                       [Coin createCoin:1 x:290 y:-660],
                       [Coin createCoin:1 x:410 y:-500],
                       [Coin createCoin:1 x:470 y:-500],
                       [Coin createCoin:1 x:530 y:-500],
                       [Coin createCoin:1 x:590 y:-500],
                       [Coin createCoin:1 x:650 y:-500],
                       [Coin createCoin:1 x:770 y:-340],
                       [Coin createCoin:1 x:830 y:-340],
                       [Coin createCoin:1 x:890 y:-340],
                       [Coin createCoin:1 x:950 y:-340],
                       [Coin createCoin:1 x:1010 y:-340],
                       [Coin createCoin:1 x:1130 y:-180],
                       [Coin createCoin:1 x:1190 y:-180],
                       [Coin createCoin:1 x:1250 y:-180],
                       [Coin createCoin:1 x:1310 y:-180],
                       [Coin createCoin:1 x:1370 y:-180]];
        self._lastCoin = [self._coins objectAtIndex:self._coins.count - 1];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }

    }
    return self;
}

@end
