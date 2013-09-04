//
//  Page6.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/28.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page6.h"
#import "PointUtil.h"
#import "Enemy.h"

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
                        [Block createBlock:102 x:170 y:-490],
                        [Block createBlock:102 x:530 y:-330],
                        [Block createBlock:102 x:890 y:-170],
                        [Block createBlock:102 x:1250 y:-330],
                        nil];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        self._coins = @[[Coin createCoin:C_STANDARD x:50 y:-420],
                       [Coin createCoin:C_STANDARD x:110 y:-420],
                       [Coin createCoin:C_STANDARD x:170 y:-420],
                       [Coin createCoin:C_STANDARD x:230 y:-420],
                       [Coin createCoin:C_STANDARD x:290 y:-420],
                       [Coin createCoin:C_STANDARD x:410 y:-260],
                       [Coin createCoin:C_STANDARD x:470 y:-260],
                       [Coin createCoin:C_STANDARD x:530 y:-260],
                       [Coin createCoin:C_STANDARD x:590 y:-260],
                       [Coin createCoin:C_STANDARD x:650 y:-260],
                       [Coin createCoin:C_STANDARD x:770 y:-100],
                       [Coin createCoin:C_STANDARD x:830 y:-100],
                       [Coin createCoin:C_STANDARD x:890 y:-100],
                       [Coin createCoin:C_STANDARD x:950 y:-100],
                       [Coin createCoin:C_STANDARD x:1010 y:-100],
                       [Coin createCoin:C_STANDARD x:1130 y:-260],
                       [Coin createCoin:C_STANDARD x:1190 y:-260],
                       [Coin createCoin:C_STANDARD x:1250 y:-260],
                       [Coin createCoin:C_STANDARD x:1310 y:-260],
                       [Coin createCoin:C_STANDARD x:1370 y:-260]];
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
        [extraEnemies addObject:[Enemy createEnemy:E_ENJIN x:790 y:-300]];
        [extraEnemies addObject:[Enemy createEnemy:E_ENJIN x:890 y:-300]];
        [extraEnemies addObject:[Enemy createEnemy:E_ENJIN x:990 y:-300]];
        self._enemies = extraEnemies;
        
    } else if (self.appearNum == 2) {
        NSMutableArray *extraEnemies = [NSMutableArray arrayWithArray:self._enemies];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:1500 y:-522]];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:1570 y:-522]];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:1640 y:-522]];
        self._enemies = extraEnemies;
        
    } else if (self.appearNum == 3) {
        NSMutableArray *extraCoins = [NSMutableArray arrayWithArray:self._coins];
        [extraCoins addObject:[Coin createCoin:C_100 x:890 y:-480]];
        self._coins = extraCoins;
    }
    
    [super reset];
}

@end
