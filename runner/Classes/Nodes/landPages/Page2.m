//
//  Page2.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/20.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page2.h"
#import "Block.h"
#import "PointUtil.h"
#import "Coin.h"
#import "Enemy.h"

// ブロック縦に3つ並んでいて、間にコイン
@implementation Page2

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        Block *land = [Block createBlock:LAND_DEFAULT];
        land.position = [self getLandPosition:land];
        [land stageOn:self];
        self._lands = @[land];
        
        // ブロック追加
        self._blocks = @[[Block createBlock:101 x:300 y:-460],
                        [Block createBlock:101 x:300 y:-400],
                        [Block createBlock:101 x:360 y:-460],
                        [Block createBlock:101 x:360 y:-400],
                        [Block createBlock:101 x:640 y:-460],
                        [Block createBlock:101 x:640 y:-400],
                        [Block createBlock:101 x:700 y:-460],
                        [Block createBlock:101 x:700 y:-400],
                        [Block createBlock:101 x:970 y:-460],
                        [Block createBlock:101 x:970 y:-400],
                        [Block createBlock:101 x:970 y:-340],
                        [Block createBlock:101 x:1030 y:-460],
                        [Block createBlock:101 x:1030 y:-400],
                        [Block createBlock:101 x:1030 y:-340]];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        self._coins = @[[Coin createCoin:C_STANDARD x:100 y:-360],
                       [Coin createCoin:C_STANDARD x:150 y:-310],
                       [Coin createCoin:C_STANDARD x:200 y:-260],
                       [Coin createCoin:C_STANDARD x:250 y:-260],
                       [Coin createCoin:C_STANDARD x:300 y:-356],
                       [Coin createCoin:C_STANDARD x:360 y:-356],
                       [Coin createCoin:C_STANDARD x:450 y:-210],
                       [Coin createCoin:C_STANDARD x:500 y:-160],
                       [Coin createCoin:C_STANDARD x:550 y:-210],
                       [Coin createCoin:C_STANDARD x:640 y:-356],
                       [Coin createCoin:C_STANDARD x:700 y:-356],
                       [Coin createCoin:C_STANDARD x:786 y:-210],
                       [Coin createCoin:C_STANDARD x:836 y:-160],
                       [Coin createCoin:C_STANDARD x:886 y:-210],
                       [Coin createCoin:C_STANDARD x:970 y:-290],
                       [Coin createCoin:C_STANDARD x:1030 y:-290]];
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
        [extraEnemies addObject:[Enemy createEnemy:E_SLYME x:530 y:-520]];
        self._enemies = extraEnemies;

    } else if (self.appearNum == 2) {
        NSMutableArray *extraEnemies = [NSMutableArray arrayWithArray:self._enemies];
        [extraEnemies addObject:[Enemy createEnemy:E_SLYME x:460 y:-520]];
        [extraEnemies addObject:[Enemy createEnemy:E_SLYME x:600 y:-520]];
        self._enemies = extraEnemies;

    } else if (self.appearNum == 3) {
        NSMutableArray *extraEnemies = [NSMutableArray arrayWithArray:self._enemies];
        [extraEnemies addObject:[Enemy createEnemy:E_NEEDLE_HALF x:836 y:-520]];
        self._enemies = extraEnemies;
    }
    
    [super reset];
}

@end
