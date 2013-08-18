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
        self._blocks = @[[Block createBlock:104 x:100 y:-670],
                        [Block createBlock:101 x:100 y:-550],
                        [Block createBlock:105 x:160 y:-610],
                        [Block createBlock:304 x:220 y:-610],
                        [Block createBlock:107 x:520 y:-340],
                        [Block createBlock:107 x:820 y:-340],
                        [Block createBlock:107 x:1240 y:-340],
                        [Block createBlock:107 x:1540 y:-340],
                        [Block createBlock:107 x:1840 y:-340],
                        [Block createBlock:107 x:2140 y:-340],
                        [Block createBlock:107 x:2560 y:-340], // ここまで上ブロック
                        [Block createBlock:105 x:1000 y:-370],
                        [Block createBlock:104 x:1000 y:-130],
                        [Block createBlock:105 x:1060 y:-370],
                        [Block createBlock:104 x:1060 y:-130], // ここまでへこみ部分1
                        [Block createBlock:105 x:2320 y:-370],
                        [Block createBlock:104 x:2320 y:-130],
                        [Block createBlock:105 x:2380 y:-370],
                        [Block createBlock:104 x:2380 y:-130], // ここまでへこみ部分2
                        [Block createBlock:108 x:3070 y:-700],
                        [Block createBlock:108 x:2830 y:-460],
                        [Block createBlock:108 x:3070 y:-220],
                        [Block createBlock:105 x:3280 y:-310],
                        [Block createBlock:108 x:3190 y:-700], // ここまで階段
                        [Block createBlock:303 x:3280 y:-610],
                        [Block createBlock:304 x:2740 y:-370], // ここまで反転ブロック
                        [Block createBlock:107 x:3460 y:-460],
                        [Block createBlock:109 x:3760 y:-610],
                        [Block createBlock:109 x:4060 y:-610],
                        [Block createBlock:107 x:4450 y:-310], // ここまで狭い通路部分（大ブロック）
                        [Block createBlock:105 x:3730 y:-220],
                        [Block createBlock:105 x:3790 y:-220],
                        [Block createBlock:109 x:4060 y:-490],
                        [Block createBlock:102 x:3970 y:-220],
                        [Block createBlock:102 x:3970 y:-160],
                        [Block createBlock:103 x:4210 y:-220],
                        [Block createBlock:103 x:4210 y:-160],
                        [Block createBlock:101 x:3100 y:-430]];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }

        // スイッチ
        self._switches = @[[Switch createSwitch:102 groupId:1 x:1030 y:-543],
                          [Switch createSwitch:102 groupId:2 x:3100 y:-483]];
        for (Switch *sw in self._switches) {
            [sw stageOn:self];
        }

        // コインを追加
        self._coins = @[[Coin createCoin:4 groupId:1 x:1120 y:-730],
                       [Coin createCoin:4 groupId:1 x:1180 y:-730],
                       [Coin createCoin:4 groupId:1 x:1240 y:-730],
                       [Coin createCoin:4 groupId:1 x:1300 y:-730],
                       [Coin createCoin:4 groupId:1 x:1360 y:-730],
                       [Coin createCoin:4 groupId:1 x:1420 y:-730],
                       [Coin createCoin:4 groupId:1 x:1480 y:-730],
                       [Coin createCoin:4 groupId:1 x:1540 y:-730],
                       [Coin createCoin:4 groupId:1 x:1600 y:-730],
                       [Coin createCoin:4 groupId:1 x:1660 y:-730],
                       [Coin createCoin:4 groupId:1 x:1720 y:-730],
                       [Coin createCoin:4 groupId:1 x:1780 y:-730],
                       [Coin createCoin:4 groupId:1 x:1840 y:-730],
                       [Coin createCoin:4 groupId:1 x:1900 y:-730],
                       [Coin createCoin:4 groupId:1 x:1960 y:-730],
                       [Coin createCoin:4 groupId:1 x:2020 y:-730],
                       [Coin createCoin:4 groupId:1 x:2080 y:-730],
                       [Coin createCoin:4 groupId:1 x:2140 y:-730],
                       [Coin createCoin:4 groupId:1 x:2200 y:-730],
                       [Coin createCoin:4 groupId:1 x:2260 y:-730],
                       [Coin createCoin:4 groupId:1 x:2320 y:-730],
                       [Coin createCoin:4 groupId:1 x:2380 y:-730],
                       [Coin createCoin:4 groupId:1 x:2440 y:-730],
                       [Coin createCoin:4 groupId:1 x:2500 y:-730],
                       [Coin createCoin:4 groupId:1 x:2560 y:-730],
                       [Coin createCoin:4 groupId:1 x:2620 y:-730],
                       [Coin createCoin:4 groupId:1 x:2680 y:-730],
                       [Coin createCoin:4 groupId:1 x:2740 y:-730],
                       [Coin createCoin:4 groupId:1 x:2800 y:-730],
                       [Coin createCoin:4 groupId:1 x:2860 y:-730],
                       [Coin createCoin:4 groupId:2 x:3640 y:-190],
                       [Coin createCoin:4 groupId:2 x:3640 y:-250],
                       [Coin createCoin:4 groupId:2 x:3640 y:-310],
                       [Coin createCoin:4 groupId:2 x:3640 y:-370],
                       [Coin createCoin:4 groupId:2 x:3640 y:-430],
                       [Coin createCoin:4 groupId:2 x:3700 y:-430],
                       [Coin createCoin:4 groupId:2 x:3760 y:-430],
                       [Coin createCoin:4 groupId:2 x:3820 y:-430],
                       [Coin createCoin:4 groupId:2 x:3880 y:-430],
                       [Coin createCoin:4 groupId:2 x:3880 y:-370],
                       [Coin createCoin:4 groupId:2 x:3880 y:-310],
                       [Coin createCoin:4 groupId:2 x:3940 y:-310],
                       [Coin createCoin:4 groupId:2 x:4000 y:-310],
                       [Coin createCoin:4 groupId:2 x:4060 y:-310],
                       [Coin createCoin:4 groupId:2 x:4120 y:-310],
                       [Coin createCoin:4 groupId:2 x:4180 y:-310],
                       [Coin createCoin:4 groupId:2 x:4240 y:-310],
                       [Coin createCoin:4 groupId:2 x:4240 y:-370],
                       [Coin createCoin:4 groupId:2 x:4240 y:-430],
                       [Coin createCoin:4 groupId:2 x:4240 y:-490],
                       [Coin createCoin:4 groupId:2 x:4240 y:-550],
                       [Coin createCoin:4 groupId:2 x:4240 y:-610],
                       [Coin createCoin:4 groupId:2 x:4240 y:-670],
                       [Coin createCoin:4 groupId:2 x:4300 y:-730],
                       [Coin createCoin:4 groupId:2 x:4360 y:-730],
                       [Coin createCoin:4 groupId:2 x:4420 y:-730],
                       [Coin createCoin:4 groupId:2 x:4480 y:-730],
                       [Coin createCoin:4 groupId:2 x:4540 y:-730],
                       [Coin createCoin:4 groupId:2 x:4600 y:-730],
                       [Coin createCoin:4 groupId:2 x:4660 y:-730],
                       [Coin createCoin:5 groupId:2 x:2350 y:-580]];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }

    }
    return self;
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
