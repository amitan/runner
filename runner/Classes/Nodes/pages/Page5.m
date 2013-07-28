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

@implementation Page5
const int PAGE5_INTERVAL1 = 100;
const int PAGE5_INTERVAL2 = 150;

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期設定
        self._blocks = [NSMutableArray arrayWithCapacity:7];
        self._coins = [NSMutableArray arrayWithCapacity:11];
        
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
        Block *block1 = [Block createBlock:202];
        Block *block2 = [Block createBlock:201];
        Block *block13 = [Block createBlock:101];
        Block *block14 = [Block createBlock:101];
        Block *block15 = [Block createBlock:101];
        Block *block21 = [Block createBlock:101];
        Block *block22 = [Block createBlock:101];
        Block *block23 = [Block createBlock:101];
        Block *block24 = [Block createBlock:101];
        Block *block25 = [Block createBlock:101];
        Block *block26 = [Block createBlock:101];
        Block *block31 = [Block createBlock:101];
        Block *block32 = [Block createBlock:101];
        Block *block33 = [Block createBlock:101];
        Block *block34 = [Block createBlock:101];

        block1.position = [PointUtil getPosition:100 y:-640];
        block2.position = [PointUtil getPosition:100 y:-720];
        block13.position = [PointUtil getPosition:1460 y:-570];
        block14.position = [PointUtil getPosition:1524 y:-570];
        block15.position = [PointUtil getPosition:1588 y:-570];
        block21.position = [PointUtil getPosition:1652 y:-350];
        block22.position = [PointUtil getPosition:1716 y:-350];
        block23.position = [PointUtil getPosition:1780 y:-350];
        block24.position = [PointUtil getPosition:1844 y:-350];
        block25.position = [PointUtil getPosition:1908 y:-350];
        block26.position = [PointUtil getPosition:1972 y:-350];
        block31.position = [PointUtil getPosition:2226 y:-350];
        block32.position = [PointUtil getPosition:2290 y:-350];
        block33.position = [PointUtil getPosition:2354 y:-350];
        block34.position = [PointUtil getPosition:2354 y:-570];
        
        [self._blocks addObject:block1];
        [self._blocks addObject:block2];
        [self._blocks addObject:block13];
        [self._blocks addObject:block14];
        [self._blocks addObject:block15];
        [self._blocks addObject:block21];
        [self._blocks addObject:block22];
        [self._blocks addObject:block23];
        [self._blocks addObject:block24];
        [self._blocks addObject:block25];
        [self._blocks addObject:block26];
        [self._blocks addObject:block31];
        [self._blocks addObject:block32];
        [self._blocks addObject:block33];
        [self._blocks addObject:block34];
        
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        Coin *coin1 = [Coin node];
        Coin *coin2 = [Coin node];
        Coin *coin13 = [Coin node];
        Coin *coin14 = [Coin node];
        Coin *coin15 = [Coin node];
        Coin *coin21 = [Coin node];
        Coin *coin22 = [Coin node];
        Coin *coin23 = [Coin node];
        Coin *coin24 = [Coin node];
        Coin *coin25 = [Coin node];
        Coin *coin26 = [Coin node];
        self._lastCoin = coin26;
        
        block1.position = [PointUtil getPosition:100 y:-640];
        block2.position = [PointUtil getPosition:100 y:-720];
        block13.position = [PointUtil getPosition:1460 y:-570];
        block14.position = [PointUtil getPosition:1524 y:-570];
        block15.position = [PointUtil getPosition:1588 y:-570];
        block21.position = [PointUtil getPosition:1652 y:-350];
        block22.position = [PointUtil getPosition:1716 y:-350];
        block23.position = [PointUtil getPosition:1780 y:-350];
        block24.position = [PointUtil getPosition:1844 y:-350];
        block25.position = [PointUtil getPosition:1908 y:-350];
        block26.position = [PointUtil getPosition:1972 y:-350];
        block31.position = [PointUtil getPosition:2226 y:-350];
        block32.position = [PointUtil getPosition:2290 y:-350];
        block33.position = [PointUtil getPosition:2354 y:-350];
        block34.position = [PointUtil getPosition:2354 y:-570];

        coin1.position = [PointUtil getPosition:75 y:-572];
        coin2.position = [PointUtil getPosition:125 y:-572];
        coin13.position = [PointUtil getPosition:1460 y:-502];
        coin14.position = [PointUtil getPosition:1524 y:-502];
        coin15.position = [PointUtil getPosition:1588 y:-502];
        coin21.position = [PointUtil getPosition:1652 y:-282];
        coin22.position = [PointUtil getPosition:1716 y:-282];
        coin23.position = [PointUtil getPosition:1780 y:-282];
        coin24.position = [PointUtil getPosition:1844 y:-282];
        coin25.position = [PointUtil getPosition:1908 y:-282];
        coin26.position = [PointUtil getPosition:1972 y:-282];
        
        [self._coins addObject:coin1];
        [self._coins addObject:coin2];
        [self._coins addObject:coin13];
        [self._coins addObject:coin14];
        [self._coins addObject:coin15];
        [self._coins addObject:coin21];
        [self._coins addObject:coin22];
        [self._coins addObject:coin23];
        [self._coins addObject:coin24];
        [self._coins addObject:coin25];
        [self._coins addObject:coin26];
        
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }

    }
    return self;
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
