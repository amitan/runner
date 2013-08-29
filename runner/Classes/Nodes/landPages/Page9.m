//
//  Page9.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/03.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page9.h"
#import "PointUtil.h"

// コインスイッチ
@implementation Page9

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
                        [Block createBlock:102 x:470 y:-190], // ここまで階段
                        [Block createBlock:103 x:470 y:-430],
                        [Block createBlock:103 x:530 y:-370],
                        [Block createBlock:101 x:590 y:-430],
                        [Block createBlock:101 x:530 y:-310],
                        [Block createBlock:101 x:590 y:-310],
                        [Block createBlock:101 x:590 y:-250], // ここまで山
                        [Block createBlock:105 x:770 y:-60],
                        [Block createBlock:106 x:1070 y:-460],
                        [Block createBlock:106 x:1970 y:-460],
                        [Block createBlock:106 x:1250 y:-150],
                        [Block createBlock:106 x:1250 y:-30]];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // スイッチ
        self._switches = [NSArray arrayWithObjects:
                          [Switch createSwitch:101 x:718 y:-150],
                          nil];
        for (Switch *sw in self._switches) {
            [sw stageOn:self];
        }
        
        // コインを追加
        self._coins = @[[Coin createCoin:4 x:830 y:-370],
                       [Coin createCoin:4 x:830 y:-310],
                       [Coin createCoin:4 x:830 y:-250],
                       [Coin createCoin:4 x:890 y:-370],
                       [Coin createCoin:4 x:890 y:-310],
                       [Coin createCoin:4 x:890 y:-250],
                       [Coin createCoin:4 x:950 y:-370],
                       [Coin createCoin:4 x:950 y:-310],
                       [Coin createCoin:4 x:950 y:-250],
                       [Coin createCoin:4 x:1010 y:-370],
                       [Coin createCoin:4 x:1010 y:-310],
                       [Coin createCoin:4 x:1010 y:-250],
                       [Coin createCoin:4 x:1070 y:-370],
                       [Coin createCoin:4 x:1070 y:-310],
                       [Coin createCoin:4 x:1070 y:-250],
                       [Coin createCoin:4 x:1130 y:-370],
                       [Coin createCoin:4 x:1130 y:-310],
                       [Coin createCoin:4 x:1130 y:-250],
                       [Coin createCoin:4 x:1190 y:-370],
                       [Coin createCoin:4 x:1190 y:-310],
                       [Coin createCoin:4 x:1190 y:-250],
                       [Coin createCoin:4 x:1250 y:-370],
                       [Coin createCoin:4 x:1250 y:-310],
                       [Coin createCoin:4 x:1250 y:-250],
                       [Coin createCoin:4 x:1310 y:-370],
                       [Coin createCoin:4 x:1310 y:-310],
                       [Coin createCoin:4 x:1310 y:-250],
                       [Coin createCoin:4 x:1370 y:-370],
                       [Coin createCoin:4 x:1370 y:-310],
                       [Coin createCoin:4 x:1370 y:-250],
                       [Coin createCoin:4 x:1430 y:-370],
                       [Coin createCoin:4 x:1430 y:-310],
                       [Coin createCoin:4 x:1430 y:-250],
                       [Coin createCoin:4 x:1490 y:-370],
                       [Coin createCoin:4 x:1490 y:-310],
                       [Coin createCoin:4 x:1490 y:-250],
                       [Coin createCoin:4 x:1550 y:-370],
                       [Coin createCoin:4 x:1550 y:-310],
                       [Coin createCoin:4 x:1550 y:-250],
                       [Coin createCoin:4 x:1610 y:-370],
                       [Coin createCoin:4 x:1610 y:-310],
                       [Coin createCoin:4 x:1610 y:-250],
                       [Coin createCoin:4 x:1670 y:-370],
                       [Coin createCoin:4 x:1670 y:-310],
                       [Coin createCoin:4 x:1670 y:-250],
                       [Coin createCoin:4 x:1730 y:-370],
                       [Coin createCoin:4 x:1730 y:-310],
                       [Coin createCoin:4 x:1730 y:-250]];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }

    }
    return self;
}

@end
