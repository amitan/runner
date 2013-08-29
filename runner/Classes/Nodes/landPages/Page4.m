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

// 穴とコイン
@implementation Page4

- (id)init {
    self = [super init];
	if (self) {
        
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
        self._coins = @[[Coin createCoin:1 x:375 y:-300],
                       [Coin createCoin:1 x:425 y:-300],
                       [Coin createCoin:1 x:565 y:-495],
                       [Coin createCoin:1 x:615 y:-495],
                       [Coin createCoin:1 x:665 y:-495],
                       [Coin createCoin:1 x:715 y:-495],
                       [Coin createCoin:1 x:855 y:-300],
                       [Coin createCoin:1 x:905 y:-300]];
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
