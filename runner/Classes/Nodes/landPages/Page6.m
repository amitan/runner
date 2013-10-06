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
        Block *land = [Block createBlock:LAND_LONG];
        land.position = [self getLandPosition:land];
        [land stageOn:self];
        self._lands = @[land];
        
        
        // ブロック追加
        self._blocks = [NSArray arrayWithObjects:
                        [Block createBlock:B_X5 x:170 y:-460],
                        [Block createBlock:B_X5 x:530 y:-300],
                        [Block createBlock:B_X5 x:890 y:-140],
                        [Block createBlock:B_X5 x:1250 y:-300],
                        nil];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        self._coins = @[[Coin createCoin:C_STANDARD x:170 y:-420],
                       [Coin createCoin:C_STANDARD x:230 y:-420],
                       [Coin createCoin:C_STANDARD x:290 y:-420],
                       [Coin createCoin:C_STANDARD x:350 y:-420],
                       [Coin createCoin:C_STANDARD x:410 y:-420],
                       [Coin createCoin:C_STANDARD x:530 y:-260],
                       [Coin createCoin:C_STANDARD x:590 y:-260],
                       [Coin createCoin:C_STANDARD x:650 y:-260],
                       [Coin createCoin:C_STANDARD x:710 y:-260],
                       [Coin createCoin:C_STANDARD x:770 y:-260],
                       [Coin createCoin:C_STANDARD x:950 y:-100],
                       [Coin createCoin:C_STANDARD x:1010 y:-100],
                       [Coin createCoin:C_STANDARD x:1070 y:-100],
                       [Coin createCoin:C_STANDARD x:1130 y:-100],
                       [Coin createCoin:C_STANDARD x:1190 y:-100],
                       [Coin createCoin:C_STANDARD x:1250 y:-260],
                       [Coin createCoin:C_STANDARD x:1310 y:-260],
                       [Coin createCoin:C_STANDARD x:1370 y:-260],
                       [Coin createCoin:C_STANDARD x:1430 y:-260],
                       [Coin createCoin:C_STANDARD x:1490 y:-260]];
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
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:1500 y:-522]];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:1570 y:-522]];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:1640 y:-522]];
        self._enemies = extraEnemies;
        
    }
    
    [super reset];
}

@end
