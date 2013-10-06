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
        Block *land = [Block createBlock:LAND_LONG];
        land.position = [self getLandPosition:land];
        [land stageOn:self];
        self._lands = @[land];
        
        
        // ブロック追加
        self._blocks = @[[Block createBlock:101 x:300 y:-460],
                        [Block createBlock:101 x:300 y:-400],
                        [Block createBlock:101 x:300 y:-310]];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        self._coins = @[[Coin createCoin:C_STANDARD x:700 y:-395],
                        [Coin createCoin:C_STANDARD x:750 y:-345],
                        [Coin createCoin:C_STANDARD x:800 y:-345],
                        [Coin createCoin:C_STANDARD x:850 y:-345],
                        [Coin createCoin:C_STANDARD x:900 y:-345],
                        [Coin createCoin:C_STANDARD x:950 y:-395],
                        [Coin createCoin:C_STANDARD x:1350 y:-395],
                        [Coin createCoin:C_STANDARD x:1400 y:-395],
                        [Coin createCoin:C_STANDARD x:1450 y:-395],
                        [Coin createCoin:C_STANDARD x:1350 y:-345],
                        [Coin createCoin:C_STANDARD x:1400 y:-345],
                        [Coin createCoin:C_STANDARD x:1450 y:-345]];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
        
        // クリスタル
        self._crystal = [Crystal createCrystal:420 y:-70];
        [self._crystal stageOn:self];
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
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:1500 y:-522]];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:1570 y:-522]];
        self._enemies = extraEnemies;
    }
    
    [super reset];
}

@end
