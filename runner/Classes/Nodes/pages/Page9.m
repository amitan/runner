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
        self._blocks = [NSArray arrayWithObjects:
                        [Block createBlock:102 x:170 y:-730],
                        [Block createBlock:102 x:470 y:-730],
                        [Block createBlock:102 x:230 y:-670],
                        [Block createBlock:102 x:290 y:-610],
                        [Block createBlock:102 x:350 y:-550],
                        [Block createBlock:102 x:410 y:-490],
                        [Block createBlock:102 x:470 y:-430], // ここまで階段
                        [Block createBlock:103 x:470 y:-670],
                        [Block createBlock:103 x:530 y:-610],
                        [Block createBlock:101 x:590 y:-670],
                        [Block createBlock:101 x:530 y:-550],
                        [Block createBlock:101 x:590 y:-550],
                        [Block createBlock:101 x:590 y:-490], // ここまで山
                        [Block createBlock:105 x:770 y:0],
                        [Block createBlock:105 x:770 y:-300],
                        [Block createBlock:106 x:1070 y:-700],
                        [Block createBlock:106 x:1970 y:-700],
                        [Block createBlock:106 x:1250 y:-390],
                        [Block createBlock:106 x:1250 y:-270],
                        [Block createBlock:106 x:1250 y:-150], // ここまで壁
                        nil];
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
        self._coins = [NSArray arrayWithObjects:
                       [Coin createCoin:4 x:830 y:-610],
                       [Coin createCoin:4 x:830 y:-550],
                       [Coin createCoin:4 x:830 y:-490],
                       [Coin createCoin:4 x:890 y:-610],
                       [Coin createCoin:4 x:890 y:-550],
                       [Coin createCoin:4 x:890 y:-490],
                       [Coin createCoin:4 x:950 y:-610],
                       [Coin createCoin:4 x:950 y:-550],
                       [Coin createCoin:4 x:950 y:-490],
                       [Coin createCoin:4 x:1010 y:-610],
                       [Coin createCoin:4 x:1010 y:-550],
                       [Coin createCoin:4 x:1010 y:-490],
                       [Coin createCoin:4 x:1070 y:-610],
                       [Coin createCoin:4 x:1070 y:-550],
                       [Coin createCoin:4 x:1070 y:-490],
                       [Coin createCoin:4 x:1130 y:-610],
                       [Coin createCoin:4 x:1130 y:-550],
                       [Coin createCoin:4 x:1130 y:-490],
                       [Coin createCoin:4 x:1190 y:-610],
                       [Coin createCoin:4 x:1190 y:-550],
                       [Coin createCoin:4 x:1190 y:-490],
                       [Coin createCoin:4 x:1250 y:-610],
                       [Coin createCoin:4 x:1250 y:-550],
                       [Coin createCoin:4 x:1250 y:-490],
                       [Coin createCoin:4 x:1310 y:-610],
                       [Coin createCoin:4 x:1310 y:-550],
                       [Coin createCoin:4 x:1310 y:-490],
                       [Coin createCoin:4 x:1370 y:-610],
                       [Coin createCoin:4 x:1370 y:-550],
                       [Coin createCoin:4 x:1370 y:-490],
                       [Coin createCoin:4 x:1430 y:-610],
                       [Coin createCoin:4 x:1430 y:-550],
                       [Coin createCoin:4 x:1430 y:-490],
                       [Coin createCoin:4 x:1490 y:-610],
                       [Coin createCoin:4 x:1490 y:-550],
                       [Coin createCoin:4 x:1490 y:-490],
                       [Coin createCoin:4 x:1550 y:-610],
                       [Coin createCoin:4 x:1550 y:-550],
                       [Coin createCoin:4 x:1550 y:-490],
                       [Coin createCoin:4 x:1610 y:-610],
                       [Coin createCoin:4 x:1610 y:-550],
                       [Coin createCoin:4 x:1610 y:-490],
                       [Coin createCoin:4 x:1670 y:-610],
                       [Coin createCoin:4 x:1670 y:-550],
                       [Coin createCoin:4 x:1670 y:-490],
                       [Coin createCoin:4 x:1730 y:-610],
                       [Coin createCoin:4 x:1730 y:-550],
                       [Coin createCoin:4 x:1730 y:-490],
                       nil];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }

    }
    return self;
}

@end
