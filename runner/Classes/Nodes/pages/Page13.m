//
//  Page13.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/12.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page13.h"
#import "PointUtil.h"
#import "Enemy.h"

// ブロック、エネミー、コイン
@implementation Page13

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        self._land = [Block createBlock:5];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        // ブロック追加
        self._blocks = @[[Block createBlock:103 x:100 y:-730],
                         [Block createBlock:103 x:500 y:-730],
                         [Block createBlock:103 x:900 y:-730],
                         [Block createBlock:103 x:1300 y:-730],
                         [Block createBlock:103 x:1700 y:-730],
                         [Block createBlock:103 x:1880 y:-730],
                         [Block createBlock:103 x:2060 y:-730],
                         [Block createBlock:103 x:2240 y:-730]];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }

        // コインを追加
        self._coins = @[[Coin createCoin:1 x:250 y:-460],
                        [Coin createCoin:1 x:300 y:-430],
                        [Coin createCoin:1 x:350 y:-460],
                        [Coin createCoin:1 x:650 y:-460],
                        [Coin createCoin:1 x:700 y:-430],
                        [Coin createCoin:1 x:750 y:-460],
                        [Coin createCoin:1 x:1050 y:-460],
                        [Coin createCoin:1 x:1100 y:-430],
                        [Coin createCoin:1 x:1150 y:-460],
                        [Coin createCoin:1 x:1450 y:-460],
                        [Coin createCoin:1 x:1500 y:-430],
                        [Coin createCoin:1 x:1550 y:-460],
                        [Coin createCoin:5 x:2060 y:-620]];
        self._lastCoin = [self._coins objectAtIndex:self._coins.count - 1];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
        
        // 敵を追加
        self._enemies = @[[Enemy createEnemy:1 x:1880 y:-655],
                          [Enemy createEnemy:1 x:2320 y:-655]];
        for (Enemy *enemy in self._enemies) {
            [enemy stageOn:self];
        }

    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

@end
