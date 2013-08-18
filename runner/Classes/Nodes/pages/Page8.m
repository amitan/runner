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
        self._blocks = @[[Block createBlock:102 x:170 y:-730],
                        [Block createBlock:102 x:470 y:-730],
                        [Block createBlock:102 x:230 y:-670],
                        [Block createBlock:102 x:290 y:-610],
                        [Block createBlock:102 x:350 y:-550],
                        [Block createBlock:102 x:410 y:-490],
                        [Block createBlock:102 x:470 y:-430],
                        [Block createBlock:103 x:470 y:-670],
                        [Block createBlock:103 x:470 y:-370],
                        [Block createBlock:103 x:530 y:-310],
                        [Block createBlock:104 x:590 y:-610],
                        [Block createBlock:101 x:470 y:-610],
                        [Block createBlock:101 x:530 y:-610],
                        [Block createBlock:101 x:530 y:-550],
                        [Block createBlock:101 x:590 y:-490],
                        [Block createBlock:101 x:590 y:-370], // ここまで山
                        [Block createBlock:304 x:650 y:-610],
                        [Block createBlock:302 x:650 y:-430],
                        [Block createBlock:302 x:650 y:-370],
                        [Block createBlock:302 x:650 y:-310],
                        [Block createBlock:304 x:950 y:60],
                        [Block createBlock:304 x:950 y:-240], // ここまで反転ブロック
                        [Block createBlock:105 x:890 y:0],
                        [Block createBlock:105 x:890 y:-300],
                        [Block createBlock:102 x:1010 y:-420],
                        [Block createBlock:102 x:1310 y:-480],
                        [Block createBlock:102 x:1610 y:-540],
                        [Block createBlock:103 x:2000 y:-730],
                        [Block createBlock:103 x:2000 y:-670],
                        [Block createBlock:103 x:2300 y:-490],
                        [Block createBlock:303 x:2420 y:-370]];        
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        self._coins = @[[Coin createCoin:2 x:1100 y:-250]];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

@end
