//
//  Page5.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/25.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page5.h"
#import "PointUtil.h"
#import "Enemy.h"

@interface Page5 ()
@property (nonatomic, retain)Block *_land2;
@property (nonatomic, retain)Block *_land3;
@end

// ブロック2段と穴
@implementation Page5
const int PAGE5_INTERVAL1 = 100;
const int PAGE5_INTERVAL2 = 150;

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        Block *land = [Block createBlock:LAND_12];
        land.position = [self getLandPosition:land];
        [land stageOn:self];
        
        float rightX = land.position.x + [land getWidth] / 2;
        Block *land2= [Block createBlock:LAND_12];
        land2.position = ccpAdd(ccp(rightX + [PointUtil getPoint:PAGE5_INTERVAL1], 0), [self getLandPosition:land2]);
        [land2 stageOn:self];
        
        float rightX2 = land2.position.x + [land2 getWidth] / 2;
        Block *land3= [Block createBlock:LAND_8];
        land3.position = ccpAdd(ccp(rightX2 + [PointUtil getPoint:PAGE5_INTERVAL2], 0), [self getLandPosition:land3]);
        [land3 stageOn:self];
        self._lands = @[land, land2, land3];
        
        // ブロック追加
        self._blocks = @[[Block createBlock:101 x:1460 y:-330],
                        [Block createBlock:101 x:1520 y:-330],
                        [Block createBlock:101 x:1580 y:-330],
                        [Block createBlock:102 x:1820 y:-110],
                        [Block createBlock:101 x:2000 y:-110],
                        [Block createBlock:101 x:2180 y:-110],
                        [Block createBlock:101 x:2240 y:-110],
                        [Block createBlock:101 x:2300 y:-110],
                        [Block createBlock:101 x:2300 y:-330]];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        self._coins = @[[Coin createCoin:C_STANDARD x:75 y:-332],
                       [Coin createCoin:C_STANDARD x:125 y:-332],
                       [Coin createCoin:C_STANDARD x:1460 y:-262],
                       [Coin createCoin:C_STANDARD x:1520 y:-262],
                       [Coin createCoin:C_STANDARD x:1580 y:-262],
                       [Coin createCoin:C_STANDARD x:1700 y:-42],
                       [Coin createCoin:C_STANDARD x:1760 y:-42],
                       [Coin createCoin:C_STANDARD x:1820 y:-42],
                       [Coin createCoin:C_STANDARD x:1880 y:-42],
                       [Coin createCoin:C_STANDARD x:1940 y:-42],
                       [Coin createCoin:C_STANDARD x:2000 y:-42]];
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
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:1520 y:-522]];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:1580 y:-522]];
        self._enemies = extraEnemies;
    
    } else if (self.appearNum == 2) {
        NSMutableArray *extraEnemies = [NSMutableArray arrayWithArray:self._enemies];
        [extraEnemies addObject:[Enemy createEnemy:E_NEEDLE_HALF x:2240 y:-520]];
        self._enemies = extraEnemies;

    } else if (self.appearNum == 3) {
        NSMutableArray *extraEnemies = [NSMutableArray arrayWithArray:self._enemies];
        [extraEnemies addObject:[Enemy createEnemy:E_NEEDLE_HALF x:125 y:-520]];
        self._enemies = extraEnemies;
    }
    
    [super reset];
}

@end
