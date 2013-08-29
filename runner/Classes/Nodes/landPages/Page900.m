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
        self._land = [Block createBlock:1];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        // コインを追加
        self._coins = @[[Coin createCoin:1 x:100 y:-735],
                        [Coin createCoin:1 x:150 y:-735],
                        [Coin createCoin:1 x:200 y:-735],
                        [Coin createCoin:1 x:250 y:-735],
                        [Coin createCoin:1 x:300 y:-735],
                        [Coin createCoin:1 x:350 y:-735],
                        [Coin createCoin:1 x:400 y:-735],
                        [Coin createCoin:1 x:450 y:-735],
                        [Coin createCoin:1 x:500 y:-735],
                        [Coin createCoin:1 x:550 y:-735],
                        [Coin createCoin:1 x:600 y:-735],
                        [Coin createCoin:1 x:650 y:-735],
                        [Coin createCoin:1 x:700 y:-735],
                        [Coin createCoin:1 x:750 y:-735],
                        [Coin createCoin:1 x:800 y:-735],
                        [Coin createCoin:1 x:850 y:-735],
                        [Coin createCoin:1 x:900 y:-735],
                        [Coin createCoin:1 x:950 y:-735],
                        [Coin createCoin:1 x:1000 y:-735],
                        [Coin createCoin:1 x:1050 y:-735],
                        [Coin createCoin:1 x:1100 y:-735]];
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
