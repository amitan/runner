//
//  Page11.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/10.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page11.h"
#import "Trampoline.h"
#import "PointUtil.h"
#import "Enemy.h"

// ジャンプ台（縦）とブロック/コイン
@implementation Page11

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期設定
        self._trampolines = [NSMutableArray arrayWithCapacity:1];

        // 地面を追加
        self._land = [Block createBlock:1];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];

        // ブロック追加
        self._blocks = @[[Block createBlock:101 x:40 y:-490],
                        [Block createBlock:101 x:100 y:-490],
                        [Block createBlock:101 x:160 y:-490],
                        [Block createBlock:101 x:220 y:-490], // ジャンプ台ブロック
                        [Block createBlock:101 x:560 y:-140],
                        [Block createBlock:101 x:620 y:-140],
                        [Block createBlock:101 x:680 y:-140],
                        [Block createBlock:101 x:740 y:-140],
                        [Block createBlock:101 x:800 y:-140],
                        [Block createBlock:101 x:860 y:-140],
                        [Block createBlock:101 x:920 y:-140],
                        [Block createBlock:101 x:980 y:-140],
                        [Block createBlock:101 x:1040 y:-140],
                        [Block createBlock:101 x:1100 y:-140]];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // ジャンプ台
        self._trampolines = [NSArray arrayWithObjects:
                             [Trampoline createTrampoline:1 x:190 y:-430],
                             nil];
        for (Trampoline *trampoline in self._trampolines) {
            [trampoline stageOn:self];
        }
        
        // コインを追加
        self._coins = @[[Coin createCoin:C_STANDARD x:190 y:-360],
                       [Coin createCoin:C_STANDARD x:190 y:-310],
                       [Coin createCoin:C_STANDARD x:190 y:-260],
                       [Coin createCoin:C_STANDARD x:240 y:-210],
                       [Coin createCoin:C_STANDARD x:240 y:-160],
                       [Coin createCoin:C_STANDARD x:240 y:-110], // 縦コイン
                       [Coin createCoin:C_STANDARD x:620 y:-80],
                       [Coin createCoin:C_STANDARD x:680 y:-80],
                       [Coin createCoin:C_STANDARD x:740 y:-80],
                       [Coin createCoin:C_STANDARD x:800 y:-80],
                       [Coin createCoin:C_STANDARD x:860 y:-80],
                       [Coin createCoin:C_STANDARD x:920 y:-80],
                       [Coin createCoin:C_STANDARD x:980 y:-80],
                       [Coin createCoin:C_STANDARD x:1040 y:-80],
                       [Coin createCoin:C_STANDARD x:1100 y:-80]];
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
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:370 y:-520]];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:440 y:-520]];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:510 y:-520]];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:580 y:-520]];
        self._enemies = extraEnemies;
        
    } else if (self.appearNum == 2) {
        NSMutableArray *extraEnemies = [NSMutableArray arrayWithArray:self._enemies];
        [extraEnemies addObject:[Enemy createEnemy:E_SLYME x:650 y:-520]];
        [extraEnemies addObject:[Enemy createEnemy:E_SLYME x:720 y:-520]];
        [extraEnemies addObject:[Enemy createEnemy:E_SLYME x:790 y:-520]];
        self._enemies = extraEnemies;
        
    } else if (self.appearNum == 3) {
        NSMutableArray *extraEnemies = [NSMutableArray arrayWithArray:self._enemies];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:860 y:-520]];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:930 y:-520]];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:1000 y:-520]];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:1070 y:-520]];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:1140 y:-520]];
        self._enemies = extraEnemies;
    }
    
    [super reset];
}

@end
