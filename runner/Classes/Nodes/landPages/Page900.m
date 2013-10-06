//
//  Page900.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/21.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page900.h"


@implementation Page900

- (id)init {
    self = [super init];
	if (self) {
        self.isSpeedUp = true;
        
        // 地面を追加
        Block *land = [Block createBlock:LAND_DEFAULT];
        land.position = [self getLandPosition:land];
        [land stageOn:self];
        self._lands = @[land];
        
        
        // コインを追加
        self._coins = @[[Coin createCoin:C_STANDARD x:100 y:-465],
                        [Coin createCoin:C_STANDARD x:150 y:-465],
                        [Coin createCoin:C_STANDARD x:200 y:-465],
                        [Coin createCoin:C_STANDARD x:250 y:-465],
                        [Coin createCoin:C_STANDARD x:300 y:-465],
                        [Coin createCoin:C_STANDARD x:350 y:-465],
                        [Coin createCoin:C_STANDARD x:400 y:-465],
                        [Coin createCoin:C_STANDARD x:450 y:-465],
                        [Coin createCoin:C_STANDARD x:500 y:-465],
                        [Coin createCoin:C_STANDARD x:550 y:-465],
                        [Coin createCoin:C_STANDARD x:600 y:-465],
                        [Coin createCoin:C_STANDARD x:650 y:-465],
                        [Coin createCoin:C_STANDARD x:700 y:-465],
                        [Coin createCoin:C_STANDARD x:750 y:-465],
                        [Coin createCoin:C_STANDARD x:800 y:-465],
                        [Coin createCoin:C_STANDARD x:850 y:-465],
                        [Coin createCoin:C_STANDARD x:900 y:-465],
                        [Coin createCoin:C_STANDARD x:950 y:-465],
                        [Coin createCoin:C_STANDARD x:1000 y:-465],
                        [Coin createCoin:C_STANDARD x:1050 y:-465],
                        [Coin createCoin:C_STANDARD x:1100 y:-465]];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

- (void)reset {
    [super reset];
    self.isSpeedUp = true;
}
@end
