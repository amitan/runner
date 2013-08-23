//
//  Page5.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/25.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page5.h"
#import "PointUtil.h"

@interface Page5 ()
@property (nonatomic, retain)Block *_land2;
@property (nonatomic, retain)Block *_land3;
@end

// 土管->ブロック2段と穴
@implementation Page5
const int PAGE5_INTERVAL1 = 100;
const int PAGE5_INTERVAL2 = 150;

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        self._land = [Block createBlock:4];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        float rightX = self._land.position.x + [self._land getWidth] / 2;
        self._land2 = [Block createBlock:1];
        self._land2.position = ccpAdd(ccp(rightX + [PointUtil getPoint:PAGE5_INTERVAL1], 0), [self getLandPosition:self._land2]);
        [self._land2 stageOn:self];

        float rightX2 = self._land2.position.x + [self._land2 getWidth] / 2;
        self._land3 = [Block createBlock:4];
        self._land3.position = ccpAdd(ccp(rightX2 + [PointUtil getPoint:PAGE5_INTERVAL2], 0), [self getLandPosition:self._land3]);
        [self._land3 stageOn:self];

        // ブロック追加
        self._blocks = @[[Block createBlock:202 x:100 y:-670],
                        [Block createBlock:201 x:100 y:-730],
                        [Block createBlock:101 x:1460 y:-570],
                        [Block createBlock:101 x:1520 y:-570],
                        [Block createBlock:101 x:1580 y:-570],
                        [Block createBlock:102 x:1820 y:-350],
                        [Block createBlock:101 x:2000 y:-350],
                        [Block createBlock:101 x:2180 y:-350],
                        [Block createBlock:101 x:2240 y:-350],
                        [Block createBlock:101 x:2300 y:-350],
                        [Block createBlock:101 x:2300 y:-570]];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        self._coins = @[[Coin createCoin:1 x:75 y:-572],
                       [Coin createCoin:1 x:125 y:-572],
                       [Coin createCoin:1 x:1460 y:-502],
                       [Coin createCoin:1 x:1520 y:-502],
                       [Coin createCoin:1 x:1580 y:-502],
                       [Coin createCoin:1 x:1700 y:-282],
                       [Coin createCoin:1 x:1760 y:-282],
                       [Coin createCoin:1 x:1820 y:-282],
                       [Coin createCoin:1 x:1880 y:-282],
                       [Coin createCoin:1 x:1940 y:-282],
                       [Coin createCoin:1 x:2000 y:-282]];
        self._lastCoin = [self._coins objectAtIndex:self._coins.count - 1];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

- (void)dealloc {
    self._land2 = nil;
    self._land3 = nil;
    [super dealloc];
}

- (float)getWidth {
    return [self._land getWidth] + [self._land2 getWidth] + [self._land3 getWidth] +
        [PointUtil getPoint:PAGE5_INTERVAL1] + [PointUtil getPoint:PAGE5_INTERVAL2];
}

- (Block*)getHitBlock:(CGPoint)point {
    for (Block *block in self._blocks) {
        if ([block isHit:point]) return block;
    }
    if ([self._land isHit:point]) return self._land;
    if ([self._land2 isHit:point]) return self._land2;
    if ([self._land3 isHit:point]) return self._land3;
    return NULL;
}

@end
