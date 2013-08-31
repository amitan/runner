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

// 迷路、100コイン
@implementation Page10

- (id)init {
    
    self = [super init];
	if (self) {
        
        // 地面を追加
        self._land = [Block createBlock:5];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        self._land2 = [Block createBlock:5];
        self._land2.position = ccpAdd(ccp(self._land.position.x + [self._land getWidth] / 2, 0), [self getLandPosition:self._land2]);
        [self._land2 stageOn:self];
        
        // ブロック追加
        self._blocks = @[[Block createBlock:104 x:100 y:-430],
                        [Block createBlock:101 x:100 y:-310],
                        [Block createBlock:105 x:160 y:-370],
                        [Block createBlock:304 x:220 y:-370],
                        [Block createBlock:107 x:520 y:-100],
                        [Block createBlock:107 x:820 y:-100],
                        [Block createBlock:107 x:1240 y:-100],
                        [Block createBlock:107 x:1540 y:-100],
                        [Block createBlock:107 x:1840 y:-100],
                        [Block createBlock:107 x:2140 y:-100],
                        [Block createBlock:107 x:2560 y:-100], // ここまで上ブロック
                        [Block createBlock:105 x:1000 y:-130],
                        [Block createBlock:104 x:1000 y:110],
                        [Block createBlock:105 x:1060 y:-130],
                        [Block createBlock:104 x:1060 y:110], // ここまでへこみ部分1
                        [Block createBlock:105 x:2320 y:-130],
                        [Block createBlock:104 x:2320 y:110],
                        [Block createBlock:105 x:2380 y:-130],
                        [Block createBlock:104 x:2380 y:110], // ここまでへこみ部分2
                        [Block createBlock:108 x:3070 y:-460],
                        [Block createBlock:108 x:3190 y:-460],
                        [Block createBlock:108 x:2830 y:-220],
//                        [Block createBlock:108 x:3130 y:-160], // ここまで階段
                        [Block createBlock:303 x:3280 y:-370],
                        [Block createBlock:304 x:2740 y:-130], // ここまで反転ブロック
                        [Block createBlock:109 x:3460 y:-370],
                        [Block createBlock:109 x:3760 y:-370]];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }

        // スイッチ
        self._switches = @[[Switch createSwitch:102 groupId:1 x:1030 y:-303],
                          [Switch createSwitch:102 groupId:2 x:2860 y:-303]];
        for (Switch *sw in self._switches) {
            [sw stageOn:self];
        }

        // コインを追加
        self._coins = @[[Coin createCoin:4 groupId:1 x:1120 y:-490],
                       [Coin createCoin:4 groupId:1 x:1180 y:-490],
                       [Coin createCoin:4 groupId:1 x:1240 y:-490],
                       [Coin createCoin:4 groupId:1 x:1300 y:-490],
                       [Coin createCoin:4 groupId:1 x:1360 y:-490],
                       [Coin createCoin:4 groupId:1 x:1420 y:-490],
                       [Coin createCoin:4 groupId:1 x:1480 y:-490],
                       [Coin createCoin:4 groupId:1 x:1540 y:-490],
                       [Coin createCoin:4 groupId:1 x:1600 y:-490],
                       [Coin createCoin:4 groupId:1 x:1660 y:-490],
                       [Coin createCoin:4 groupId:1 x:1720 y:-490],
                       [Coin createCoin:4 groupId:1 x:1780 y:-490],
                       [Coin createCoin:4 groupId:1 x:1840 y:-490],
                       [Coin createCoin:4 groupId:1 x:1900 y:-490],
                       [Coin createCoin:4 groupId:1 x:1960 y:-490],
                       [Coin createCoin:4 groupId:1 x:2020 y:-490],
                       [Coin createCoin:4 groupId:1 x:2080 y:-490],
                       [Coin createCoin:4 groupId:1 x:2140 y:-490],
                       [Coin createCoin:4 groupId:1 x:2200 y:-490],
                       [Coin createCoin:4 groupId:1 x:2260 y:-490],
                       [Coin createCoin:4 groupId:1 x:2320 y:-490],
                       [Coin createCoin:4 groupId:1 x:2380 y:-490],
                       [Coin createCoin:4 groupId:1 x:2440 y:-490],
                       [Coin createCoin:4 groupId:1 x:2500 y:-490],
                       [Coin createCoin:4 groupId:1 x:2560 y:-490],
                       [Coin createCoin:4 groupId:1 x:2620 y:-490],
                       [Coin createCoin:4 groupId:1 x:2680 y:-490],
                       [Coin createCoin:4 groupId:1 x:2740 y:-490],
                       [Coin createCoin:4 groupId:1 x:2800 y:-490],
                       [Coin createCoin:4 groupId:1 x:2860 y:-490],
                       [Coin createCoin:4 groupId:2 x:3400 y:-190],
                       [Coin createCoin:4 groupId:2 x:3460 y:-190],
                       [Coin createCoin:4 groupId:2 x:3520 y:-190],
                       [Coin createCoin:4 groupId:2 x:3580 y:-190],
                       [Coin createCoin:4 groupId:2 x:3640 y:-190],
                       [Coin createCoin:4 groupId:2 x:3700 y:-190],
                       [Coin createCoin:4 groupId:2 x:3760 y:-190],
                       [Coin createCoin:4 groupId:2 x:3820 y:-190],
                       [Coin createCoin:4 groupId:2 x:3880 y:-190],
                       [Coin createCoin:4 groupId:2 x:3940 y:-190],
                       [Coin createCoin:4 groupId:2 x:4000 y:-190],
                        [Coin createCoin:4 groupId:2 x:4030 y:-250],
                        [Coin createCoin:4 groupId:2 x:4060 y:-310],
                        [Coin createCoin:4 groupId:2 x:4090 y:-370],
                        [Coin createCoin:4 groupId:2 x:4120 y:-430],
                        [Coin createCoin:5 groupId:2 x:2350 y:-340]];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }

    }
    return self;
}

- (void)dealloc {
    self._land2 = nil;
    [super dealloc];
}

- (float)getWidth {
    return (self._land2.position.x + [self._land2 getWidth] / 2) - (self._land.position.x - [self._land getWidth] / 2);
}

- (Block*)getHitBlock:(CGPoint)point {
    for (Block *block in self._blocks) {
        if ([block isHit:point]) return block;
    }
    if ([self._land isHit:point]) return self._land;
    if ([self._land2 isHit:point]) return self._land2;
    return NULL;
}

@end
