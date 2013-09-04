//
//  Page8.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/01.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page8.h"
#import "PointUtil.h"

// 反転ブロックとでかコイン
@implementation Page8

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        self._land = [Block createBlock:5];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        // ブロック追加
        self._blocks = @[[Block createBlock:102 x:170 y:-490],
                        [Block createBlock:102 x:470 y:-490],
                        [Block createBlock:102 x:230 y:-430],
                        [Block createBlock:102 x:290 y:-370],
                        [Block createBlock:102 x:350 y:-310],
                        [Block createBlock:102 x:410 y:-250],
                        [Block createBlock:102 x:470 y:-190],
                        [Block createBlock:103 x:470 y:-430],
                        [Block createBlock:103 x:470 y:-130],
                        [Block createBlock:103 x:530 y:-70],
                        [Block createBlock:104 x:590 y:-370],
                        [Block createBlock:101 x:470 y:-370],
                        [Block createBlock:101 x:530 y:-370],
                        [Block createBlock:101 x:530 y:-310],
                        [Block createBlock:101 x:590 y:-250],
                        [Block createBlock:101 x:590 y:-130], // ここまで山
                        [Block createBlock:304 x:650 y:-370],
                        [Block createBlock:302 x:650 y:-190],
                        [Block createBlock:302 x:650 y:-130],
                        [Block createBlock:302 x:650 y:-70],
                        [Block createBlock:304 x:950 y:-60], // ここまで反転ブロック
                        [Block createBlock:105 x:890 y:-120],
                        [Block createBlock:102 x:1010 y:-240],
                        [Block createBlock:102 x:1310 y:-300],
                        [Block createBlock:103 x:1700 y:-490],
                        [Block createBlock:103 x:1700 y:-430],
                        [Block createBlock:103 x:2000 y:-250],
                        [Block createBlock:303 x:2120 y:-130]];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        self._coins = @[[Coin createCoin:C_BIG x:1100 y:-70]];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

- (void)reset {
    
    if (self.appearNum == 1) {
        NSMutableArray *extraCoins = [NSMutableArray arrayWithArray:self._coins];
        [extraCoins addObject:[Coin createCoin:C_100 x:2000 y:-130]];
        self._coins = extraCoins;
    }
    
    [super reset];
}

@end
