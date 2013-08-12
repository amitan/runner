//
//  Page12.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/12.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page12.h"
#import "PointUtil.h"
#import "Rail.h"

@interface Page12 ()
@property (nonatomic, retain)Block *_land2;
@end

@implementation Page12
const int PAGE12_INTERVAL1 = 1920;

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        self._land = [Block createBlock:2];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        float rightX = self._land.position.x + [self._land getWidth] / 2;
        self._land2 = [Block createBlock:1];
        self._land2.position = ccpAdd(ccp(rightX + [PointUtil getPoint:PAGE12_INTERVAL1], 0), [self getLandPosition:self._land2]);
        [self._land2 stageOn:self];
        
        // ブロック追加
        self._blocks = [NSArray arrayWithObjects:
                        [Block createBlock:102 x:170 y:-730],
                        [Block createBlock:102 x:170 y:-670],
                        [Block createBlock:102 x:170 y:-610],
                        nil];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // レール追加
        self._rails = [NSArray arrayWithObjects:
                       [Rail createRail:1 rotation:4 x:800 y:-430],
                       [Rail createRail:2 rotation:2 x:1300 y:-330],
                       [Rail createRail:1 rotation:45 x:1750 y:-380],
                        nil];
        for (Rail *rail in self._rails) {
            [rail stageOn:self];
        }
        
        // コインを追加
        self._coins = [NSArray arrayWithObjects:
                       [Coin createCoin:1 x:350 y:-430],
                       [Coin createCoin:1 x:410 y:-370],
                       [Coin createCoin:1 x:470 y:-310],
                       [Coin createCoin:1 x:710 y:-220],
                       [Coin createCoin:1 x:770 y:-220],
                       [Coin createCoin:1 x:830 y:-280],
                       [Coin createCoin:1 x:1070 y:-280],
                       [Coin createCoin:1 x:1130 y:-220],
                       [Coin createCoin:1 x:1550 y:-130],
                       [Coin createCoin:1 x:1580 y:-160],
                       [Coin createCoin:1 x:1610 y:-190],
                       [Coin createCoin:1 x:1640 y:-220],
                       [Coin createCoin:1 x:1670 y:-250],
                       [Coin createCoin:1 x:1700 y:-280],
                       [Coin createCoin:1 x:1730 y:-310],
                       [Coin createCoin:1 x:1760 y:-340],
                       [Coin createCoin:1 x:1790 y:-370],
                       [Coin createCoin:1 x:1820 y:-400],
                       [Coin createCoin:1 x:1850 y:-430],
                       [Coin createCoin:1 x:1880 y:-460],
                       [Coin createCoin:1 x:1910 y:-490],
                       [Coin createCoin:1 x:1940 y:-520],
                       [Coin createCoin:1 x:1970 y:-550],
                       [Coin createCoin:1 x:2000 y:-580],
                       nil];
        self._lastCoin = [self._coins objectAtIndex:self._coins.count - 1];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

- (float)getWidth {
    return [self._land getWidth] + [self._land2 getWidth] + [PointUtil getPoint:PAGE12_INTERVAL1];
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
