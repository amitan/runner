//
//  Page3.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/20.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page3.h"
#import "PointUtil.h"
#import "Enemy.h"

// 敵敵敵 -> ブロック（下にコイン）
@implementation Page3

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        self._land = [Block createBlock:1];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        // 敵を追加
        self._enemies = @[[Enemy createEnemy:1 x:184 y:-522],
                         [Enemy createEnemy:1 x:268 y:-522],
                         [Enemy createEnemy:1 x:352 y:-522]];
        for (Enemy *enemy in self._enemies) {
            [enemy stageOn:self];
        }
        
        // ブロック追加
        self._blocks = @[[Block createBlock:101 x:792 y:-360],
                        [Block createBlock:101 x:852 y:-360],
                        [Block createBlock:101 x:912 y:-360],
                        [Block createBlock:101 x:972 y:-360],
                        [Block createBlock:101 x:1032 y:-360]];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        self._coins = @[[Coin createCoin:C_STANDARD x:600 y:-495],
                       [Coin createCoin:C_STANDARD x:664 y:-495],
                       [Coin createCoin:C_STANDARD x:728 y:-495],
                       [Coin createCoin:C_STANDARD x:792 y:-495],
                       [Coin createCoin:C_STANDARD x:852 y:-495],
                       [Coin createCoin:C_STANDARD x:912 y:-495],
                       [Coin createCoin:C_STANDARD x:972 y:-495],
                       [Coin createCoin:C_STANDARD x:1032 y:-495]];
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
        [extraEnemies addObject:[Enemy createEnemy:E_NEEDLE_HALF x:1002 y:-330]];
        self._enemies = extraEnemies;
        
    } else if (self.appearNum == 2) {
        NSMutableArray *extraEnemies = [NSMutableArray arrayWithArray:self._enemies];
        [extraEnemies addObject:[Enemy createEnemy:E_SLYME x:912 y:-330]];
        self._enemies = extraEnemies;
        
    } else if (self.appearNum == 3) {
        NSMutableArray *extraCoins = [NSMutableArray arrayWithArray:self._coins];
        [extraCoins addObject:[Coin createCoin:C_100 x:912 y:-200]];
        self._coins = extraCoins;
    }
    
    [super reset];
}

@end
