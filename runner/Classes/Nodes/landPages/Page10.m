//
//  Page10.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/05.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page10.h"
#import "PointUtil.h"

@interface Page10 ()
@property (nonatomic, retain)Block *_land2;
@end

// 下くぐる、100コイン
@implementation Page10

- (id)init {
    
    self = [super init];
	if (self) {
        
        // 地面を追加
        Block *land = [Block createBlock:5];
        land.position = [self getLandPosition:land];
        [land stageOn:self];
        self._lands = @[land];
        
        // ブロック追加
        self._blocks = @[
                        [Block createBlock:107 x:220 y:-100],
                        [Block createBlock:107 x:520 y:-100],
                        [Block createBlock:107 x:940 y:-100],
                        [Block createBlock:107 x:1240 y:-100],
                        [Block createBlock:107 x:1540 y:-100],
                        [Block createBlock:107 x:1840 y:-100],
                        [Block createBlock:107 x:2260 y:-100], // ここまで上ブロック
                        [Block createBlock:105 x:700 y:-130],
                        [Block createBlock:104 x:700 y:110],
                        [Block createBlock:105 x:760 y:-130],
                        [Block createBlock:104 x:760 y:110], // ここまでへこみ部分1
                        [Block createBlock:105 x:2020 y:-130],
                        [Block createBlock:104 x:2020 y:110],
                        [Block createBlock:105 x:2080 y:-130],
                        [Block createBlock:104 x:2080 y:110], // ここまでへこみ部分2
                        ];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }

        // スイッチ
        self._switches = @[[Switch createSwitch:102 groupId:1 x:730 y:-303]];
        for (Switch *sw in self._switches) {
            [sw stageOn:self];
        }

        // コインを追加
        self._coins = @[[Coin createCoin:C_SWITCH groupId:1 x:820 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:880 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:940 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:1000 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:1060 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:1120 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:1180 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:1240 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:1300 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:1360 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:1420 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:1480 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:1540 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:1600 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:1660 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:1720 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:1780 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:1840 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:1900 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:1960 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:2020 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:2080 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:2140 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:2200 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:2260 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:2320 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:2380 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:2440 y:-490],
                       [Coin createCoin:C_SWITCH groupId:1 x:2500 y:-490],
                        [Coin createCoin:C_100 x:2050 y:-340]];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }

    }
    return self;
}

@end
