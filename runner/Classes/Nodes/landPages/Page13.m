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
        Block *land = [Block createBlock:5];
        land.position = [self getLandPosition:land];
        [land stageOn:self];
        self._lands = @[land];
        
        // ブロック追加
        self._blocks = @[[Block createBlock:103 x:100 y:-490],
                         [Block createBlock:103 x:500 y:-490],
                         [Block createBlock:103 x:900 y:-490],
                         [Block createBlock:103 x:1300 y:-490],
                         [Block createBlock:103 x:1700 y:-490],
                         [Block createBlock:103 x:1880 y:-490],
                         [Block createBlock:103 x:2060 y:-490],
                         [Block createBlock:103 x:2240 y:-490]];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }

        // コインを追加
        self._coins = @[[Coin createCoin:C_STANDARD x:250 y:-220],
                        [Coin createCoin:C_STANDARD x:300 y:-190],
                        [Coin createCoin:C_STANDARD x:350 y:-220],
                        [Coin createCoin:C_STANDARD x:650 y:-220],
                        [Coin createCoin:C_STANDARD x:700 y:-190],
                        [Coin createCoin:C_STANDARD x:750 y:-220],
                        [Coin createCoin:C_STANDARD x:1050 y:-220],
                        [Coin createCoin:C_STANDARD x:1100 y:-190],
                        [Coin createCoin:C_STANDARD x:1150 y:-220],
                        [Coin createCoin:C_STANDARD x:1450 y:-220],
                        [Coin createCoin:C_STANDARD x:1500 y:-190],
                        [Coin createCoin:C_STANDARD x:1550 y:-220],
                        [Coin createCoin:C_100 x:2060 y:-380]];
        self._lastCoin = [self._coins objectAtIndex:self._coins.count - 1];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }        
    }
    return self;
}

- (void)reset {
    
    if (self.appearNum == 1) {
        NSMutableArray *extraEnemies = [NSMutableArray arrayWithArray:self._enemies];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:300 y:-520]];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:1500 y:-520]];
        self._enemies = extraEnemies;
        
    } else if (self.appearNum == 2) {
        NSMutableArray *extraEnemies = [NSMutableArray arrayWithArray:self._enemies];
        [extraEnemies addObject:[Enemy createEnemy:E_SLYME x:700 y:-520]];
        [extraEnemies addObject:[Enemy createEnemy:E_SLYME x:1100 y:-520]];
        self._enemies = extraEnemies;
        
    } else if (self.appearNum == 3) {
        NSMutableArray *extraEnemies = [NSMutableArray arrayWithArray:self._enemies];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:1880 y:-460]];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:2320 y:-460]];
        self._enemies = extraEnemies;
    }
    
    [super reset];
}
@end
