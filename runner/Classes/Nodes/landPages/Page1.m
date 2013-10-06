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
#import "Enemy.h"

// 地面とコイン
@implementation Page1

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        Block *land = [Block createBlock:LAND_DEFAULT];
        land.position = [self getLandPosition:land];
        [land stageOn:self];
        self._lands = @[land];
        
        // コインを追加
        self._coins = @[[Coin createCoin:C_STANDARD x:100 y:-450],
                       [Coin createCoin:C_STANDARD x:150 y:-450],
                       [Coin createCoin:C_STANDARD x:200 y:-450],
                       [Coin createCoin:C_STANDARD x:250 y:-450],
                       [Coin createCoin:C_STANDARD x:300 y:-450],
                       [Coin createCoin:C_STANDARD x:350 y:-450],
                       [Coin createCoin:C_STANDARD x:400 y:-450],
                       [Coin createCoin:C_STANDARD x:450 y:-450],
                       [Coin createCoin:C_STANDARD x:600 y:-360],
                       [Coin createCoin:C_STANDARD x:650 y:-310],
                       [Coin createCoin:C_STANDARD x:700 y:-310],
                       [Coin createCoin:C_STANDARD x:750 y:-360]];
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
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:640 y:-522]];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:710 y:-522]];
        self._enemies = extraEnemies;
    
    } else if (self.appearNum == 2) {
        NSMutableArray *extraEnemies = [NSMutableArray arrayWithArray:self._enemies];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:780 y:-522]];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:850 y:-522]];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:920 y:-522]];
        self._enemies = extraEnemies;
    }
    [super reset];
}

@end
