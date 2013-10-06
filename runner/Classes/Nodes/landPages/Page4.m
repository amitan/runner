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

// 穴とコイン
@implementation Page4

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        Block *land = [Block createBlock:2];
        land.position = [self getLandPosition:land];
        [land stageOn:self];

        float rightX = land.position.x + [land getWidth] / 2;
        Block *land2= [Block createBlock:2];
        land2.position = ccpAdd(ccp(rightX + [PointUtil getPoint:160], 0), [self getLandPosition:land2]);
        [land2 stageOn:self];

        float rightX2 = land2.position.x + [land2 getWidth] / 2;
        Block *land3= [Block createBlock:2];
        land3.position = ccpAdd(ccp(rightX2 + [PointUtil getPoint:160], 0), [self getLandPosition:land3]);
        [land3 stageOn:self];
        self._lands = @[land, land2, land3];
        
        // コインを追加
        self._coins = @[[Coin createCoin:C_STANDARD x:375 y:-300],
                       [Coin createCoin:C_STANDARD x:425 y:-300],
                       [Coin createCoin:C_STANDARD x:565 y:-495],
                       [Coin createCoin:C_STANDARD x:615 y:-495],
                       [Coin createCoin:C_STANDARD x:665 y:-495],
                       [Coin createCoin:C_STANDARD x:715 y:-495],
                       [Coin createCoin:C_STANDARD x:855 y:-300],
                       [Coin createCoin:C_STANDARD x:905 y:-300]];
        self._lastCoin = [self._coins objectAtIndex:self._coins.count - 1];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

@end
