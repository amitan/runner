//
//  Page4.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/21.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page4.h"
#import "PointUtil.h"
#import "Block.h"

@interface Page4 ()
@property (nonatomic, retain)Block *_land2;
@property (nonatomic, retain)Block *_land3;
@end

// 崖とコイン
@implementation Page4

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期設定
        self._coins = [NSMutableArray arrayWithCapacity:8];

        // 地面を追加
        self._land = [Block createBlock:2];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        float rightX = self._land.position.x + [self._land getWidth] / 2;
        self._land2 = [Block createBlock:2];
        self._land2.position = ccpAdd(ccp(rightX + [PointUtil getPoint:160], 0), [self getLandPosition:self._land2]);
        [self._land2 stageOn:self];

        float rightX2 = self._land2.position.x + [self._land2 getWidth] / 2;
        self._land3 = [Block createBlock:2];
        self._land3.position = ccpAdd(ccp(rightX2 + [PointUtil getPoint:160], 0), [self getLandPosition:self._land3]);
        [self._land3 stageOn:self];
        
        // コインを追加
        Coin *coin1 = [Coin createCoin:1];
        Coin *coin2 = [Coin createCoin:1];
        Coin *coin3 = [Coin createCoin:1];
        Coin *coin4 = [Coin createCoin:1];
        Coin *coin5 = [Coin createCoin:1];
        Coin *coin6 = [Coin createCoin:1];
        Coin *coin7 = [Coin createCoin:1];
        Coin *coin8 = [Coin createCoin:1];
        self._lastCoin = coin8;
        
        coin1.position = [PointUtil getPosition:375 y:-500];
        coin2.position = [PointUtil getPosition:425 y:-500];
        coin3.position = [PointUtil getPosition:565 y:-735];
        coin4.position = [PointUtil getPosition:615 y:-735];
        coin5.position = [PointUtil getPosition:665 y:-735];
        coin6.position = [PointUtil getPosition:715 y:-735];
        coin7.position = [PointUtil getPosition:855 y:-500];
        coin8.position = [PointUtil getPosition:905 y:-500];
        
        [self._coins addObject:coin1];
        [self._coins addObject:coin2];
        [self._coins addObject:coin3];
        [self._coins addObject:coin4];
        [self._coins addObject:coin5];
        [self._coins addObject:coin6];
        [self._coins addObject:coin7];
        [self._coins addObject:coin8];
        
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

- (float)getWidth {
    return self._land3.position.x + [self._land3 getWidth] / 2 - self._land.position.x - [self._land getWidth] / 2;
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
