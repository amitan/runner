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
#import "Enemy.h"

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
        self._blocks = @[[Block createBlock:101 x:300 y:-490],
                        [Block createBlock:101 x:300 y:-430],
                        [Block createBlock:101 x:300 y:-370]];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        self._coins = @[[Coin createCoin:C_BIG x:500 y:-60],
                        [Coin createCoin:C_STANDARD x:700 y:-495],
                        [Coin createCoin:C_STANDARD x:750 y:-495],
                        [Coin createCoin:C_STANDARD x:800 y:-495],
                        [Coin createCoin:C_STANDARD x:850 y:-495],
                        [Coin createCoin:C_STANDARD x:900 y:-495],
                        [Coin createCoin:C_STANDARD x:950 y:-495],
                        [Coin createCoin:C_STANDARD x:1000 y:-495],
                        [Coin createCoin:C_STANDARD x:1050 y:-495],
                        [Coin createCoin:C_STANDARD x:1100 y:-495],
                        [Coin createCoin:C_STANDARD x:1150 y:-495],
                        [Coin createCoin:C_STANDARD x:1200 y:-495],
                        [Coin createCoin:C_STANDARD x:1250 y:-495],
                        [Coin createCoin:C_STANDARD x:1300 y:-495],
                        [Coin createCoin:C_STANDARD x:1350 y:-495],
                        [Coin createCoin:C_STANDARD x:1400 y:-495],
                        [Coin createCoin:C_STANDARD x:1450 y:-495]];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }        
    }
    return self;
}

- (void)reset {
    
    if (self.appearNum == 1) {
        NSMutableArray *extraEnemies = [NSMutableArray arrayWithArray:self._enemies];
        [extraEnemies addObject:[Enemy createEnemy:E_NEEDLE_HALF x:400 y:-520]];
        self._enemies = extraEnemies;
        
    } else if (self.appearNum == 2) {
        NSMutableArray *extraEnemies = [NSMutableArray arrayWithArray:self._enemies];
        [extraEnemies addObject:[Enemy createEnemy:E_ENJIN x:1150 y:-400]];
        [extraEnemies addObject:[Enemy createEnemy:E_ENJIN x:1250 y:-400]];
        [extraEnemies addObject:[Enemy createEnemy:E_ENJIN x:1350 y:-400]];
        self._enemies = extraEnemies;
    }
    
    [super reset];
}

@end
