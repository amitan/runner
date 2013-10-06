//
//  Page9.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/03.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page9.h"
#import "PointUtil.h"
#import "Enemy.h"

// コインスイッチ
@implementation Page9

- (id)init {
    
    self = [super init];
	if (self) {
        
        // 地面を追加
        Block *land = [Block createBlock:LAND_LONG];
        land.position = [self getLandPosition:land];
        [land stageOn:self];
        self._lands = @[land];

        // ブロック追加
        self._blocks = @[[Block createBlock:102 x:170 y:-460],
                        [Block createBlock:102 x:470 y:-460],
                        [Block createBlock:102 x:230 y:-400],
                        [Block createBlock:102 x:290 y:-340],
                        [Block createBlock:102 x:350 y:-280],
                        [Block createBlock:102 x:410 y:-220],
                        [Block createBlock:102 x:470 y:-160], // ここまで階段
                        [Block createBlock:103 x:470 y:-400],
                        [Block createBlock:103 x:530 y:-340],
                        [Block createBlock:101 x:590 y:-400],
                        [Block createBlock:101 x:530 y:-280],
                        [Block createBlock:101 x:590 y:-280],
                        [Block createBlock:101 x:590 y:-220], // ここまで山
                        [Block createBlock:105 x:770 y:-60],
                        [Block createBlock:106 x:1070 y:-430],
                        [Block createBlock:106 x:1970 y:-430],
                        [Block createBlock:106 x:1250 y:-120],
                        [Block createBlock:106 x:1250 y:-30]];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // スイッチ
        self._switches = [NSArray arrayWithObjects:
                          [Switch createSwitch:101 x:748 y:-90],
                          nil];
        for (Switch *sw in self._switches) {
            [sw stageOn:self];
        }
        
        // コインを追加
        self._coins = @[[Coin createCoin:C_SWITCH x:830 y:-370],
                       [Coin createCoin:C_SWITCH x:830 y:-310],
                       [Coin createCoin:C_SWITCH x:830 y:-250],
                       [Coin createCoin:C_SWITCH x:890 y:-370],
                       [Coin createCoin:C_SWITCH x:890 y:-310],
                       [Coin createCoin:C_SWITCH x:890 y:-250],
                       [Coin createCoin:C_SWITCH x:950 y:-370],
                       [Coin createCoin:C_SWITCH x:950 y:-310],
                       [Coin createCoin:C_SWITCH x:950 y:-250],
                       [Coin createCoin:C_SWITCH x:1010 y:-370],
                       [Coin createCoin:C_SWITCH x:1010 y:-310],
                       [Coin createCoin:C_SWITCH x:1010 y:-250],
                       [Coin createCoin:C_SWITCH x:1070 y:-370],
                       [Coin createCoin:C_SWITCH x:1070 y:-310],
                       [Coin createCoin:C_SWITCH x:1070 y:-250],
                       [Coin createCoin:C_SWITCH x:1130 y:-370],
                       [Coin createCoin:C_SWITCH x:1130 y:-310],
                       [Coin createCoin:C_SWITCH x:1130 y:-250],
                       [Coin createCoin:C_SWITCH x:1190 y:-370],
                       [Coin createCoin:C_SWITCH x:1190 y:-310],
                       [Coin createCoin:C_SWITCH x:1190 y:-250],
                       [Coin createCoin:C_SWITCH x:1250 y:-370],
                       [Coin createCoin:C_SWITCH x:1250 y:-310],
                       [Coin createCoin:C_SWITCH x:1250 y:-250],
                       [Coin createCoin:C_SWITCH x:1310 y:-370],
                       [Coin createCoin:C_SWITCH x:1310 y:-310],
                       [Coin createCoin:C_SWITCH x:1310 y:-250],
                       [Coin createCoin:C_SWITCH x:1370 y:-370],
                       [Coin createCoin:C_SWITCH x:1370 y:-310],
                       [Coin createCoin:C_SWITCH x:1370 y:-250],
                       [Coin createCoin:C_SWITCH x:1430 y:-370],
                       [Coin createCoin:C_SWITCH x:1430 y:-310],
                       [Coin createCoin:C_SWITCH x:1430 y:-250],
                       [Coin createCoin:C_SWITCH x:1490 y:-370],
                       [Coin createCoin:C_SWITCH x:1490 y:-310],
                       [Coin createCoin:C_SWITCH x:1490 y:-250],
                       [Coin createCoin:C_SWITCH x:1550 y:-370],
                       [Coin createCoin:C_SWITCH x:1550 y:-310],
                       [Coin createCoin:C_SWITCH x:1550 y:-250],
                       [Coin createCoin:C_SWITCH x:1610 y:-370],
                       [Coin createCoin:C_SWITCH x:1610 y:-310],
                       [Coin createCoin:C_SWITCH x:1610 y:-250],
                       [Coin createCoin:C_SWITCH x:1670 y:-370],
                       [Coin createCoin:C_SWITCH x:1670 y:-310],
                       [Coin createCoin:C_SWITCH x:1670 y:-250],
                       [Coin createCoin:C_SWITCH x:1730 y:-370],
                       [Coin createCoin:C_SWITCH x:1730 y:-310],
                       [Coin createCoin:C_SWITCH x:1730 y:-250]];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }

    }
    return self;
}

- (void)reset {
    
    if (self.appearNum == 1) {
        NSMutableArray *extraEnemies = [NSMutableArray arrayWithArray:self._enemies];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:2100 y:-402]];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:2170 y:-402]];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:2240 y:-402]];
        self._enemies = extraEnemies;
    }
    
    [super reset];
}

@end
