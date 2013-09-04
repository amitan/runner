//
//  BigCoin.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/01.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "BigCoin.h"
#import "PointUtil.h"

@interface BigCoin ()
@property (nonatomic, retain)NSMutableArray *_coins;
@end

@implementation BigCoin
const int INIT_DROPPING_COIN_X = 300;
const int INIT_DROPPING_COIN_Y = 100;

- (id)initWithCoinId:(int)coinId groupId:(int)groupId {
    self = [super initWithCoinId:coinId groupId:groupId];
    if (self) {
        self._coins = [NSMutableArray arrayWithCapacity:20];
        Coin *coin1 = [Coin createCoin:C_DROPPING];
        Coin *coin2 = [Coin createCoin:C_DROPPING];
        Coin *coin3 = [Coin createCoin:C_DROPPING];
        Coin *coin4 = [Coin createCoin:C_DROPPING];
        Coin *coin5 = [Coin createCoin:C_DROPPING];
        Coin *coin6 = [Coin createCoin:C_DROPPING];
        Coin *coin7 = [Coin createCoin:C_DROPPING];
        Coin *coin8 = [Coin createCoin:C_DROPPING];
        Coin *coin9 = [Coin createCoin:C_DROPPING];
        Coin *coin10 = [Coin createCoin:C_DROPPING];
        Coin *coin11 = [Coin createCoin:C_DROPPING];
        Coin *coin12 = [Coin createCoin:C_DROPPING];
        Coin *coin13 = [Coin createCoin:C_DROPPING];
        Coin *coin14 = [Coin createCoin:C_DROPPING];
        Coin *coin15 = [Coin createCoin:C_DROPPING];
        Coin *coin16 = [Coin createCoin:C_DROPPING];
        Coin *coin17 = [Coin createCoin:C_DROPPING];
        Coin *coin18 = [Coin createCoin:C_DROPPING];
        Coin *coin19 = [Coin createCoin:C_DROPPING];
        Coin *coin20 = [Coin createCoin:C_DROPPING];
        Coin *coin21 = [Coin createCoin:C_DROPPING];
        Coin *coin22 = [Coin createCoin:C_DROPPING];
        Coin *coin23 = [Coin createCoin:C_DROPPING];
        Coin *coin24 = [Coin createCoin:C_DROPPING];
        Coin *coin25 = [Coin createCoin:C_DROPPING];
        Coin *coin26 = [Coin createCoin:C_DROPPING];
        Coin *coin27 = [Coin createCoin:C_DROPPING];
        Coin *coin28 = [Coin createCoin:C_DROPPING];
        Coin *coin29 = [Coin createCoin:C_DROPPING];
        Coin *coin30 = [Coin createCoin:C_DROPPING];
        Coin *coin31 = [Coin createCoin:C_DROPPING];
        Coin *coin32 = [Coin createCoin:C_DROPPING];
        Coin *coin33 = [Coin createCoin:C_DROPPING];
        Coin *coin34 = [Coin createCoin:C_DROPPING];
        Coin *coin35 = [Coin createCoin:C_DROPPING];
        Coin *coin36 = [Coin createCoin:C_DROPPING];
        Coin *coin37 = [Coin createCoin:C_DROPPING];
        Coin *coin38 = [Coin createCoin:C_DROPPING];
        Coin *coin39 = [Coin createCoin:C_DROPPING];
        Coin *coin40 = [Coin createCoin:C_DROPPING];
        Coin *coin41 = [Coin createCoin:C_DROPPING];
        Coin *coin42 = [Coin createCoin:C_DROPPING];
        Coin *coin43 = [Coin createCoin:C_DROPPING];
        Coin *coin44 = [Coin createCoin:C_DROPPING];
        Coin *coin45 = [Coin createCoin:C_DROPPING];
        Coin *coin46 = [Coin createCoin:C_DROPPING];
        Coin *coin47 = [Coin createCoin:C_DROPPING];
        Coin *coin48 = [Coin createCoin:C_DROPPING];
        Coin *coin49 = [Coin createCoin:C_DROPPING];
        Coin *coin50 = [Coin createCoin:C_DROPPING];

        [self._coins addObject:coin1];
        [self._coins addObject:coin2];
        [self._coins addObject:coin3];
        [self._coins addObject:coin4];
        [self._coins addObject:coin5];
        [self._coins addObject:coin6];
        [self._coins addObject:coin7];
        [self._coins addObject:coin8];
        [self._coins addObject:coin9];
        [self._coins addObject:coin10];
        [self._coins addObject:coin11];
        [self._coins addObject:coin12];
        [self._coins addObject:coin13];
        [self._coins addObject:coin14];
        [self._coins addObject:coin15];
        [self._coins addObject:coin16];
        [self._coins addObject:coin17];
        [self._coins addObject:coin18];
        [self._coins addObject:coin19];
        [self._coins addObject:coin20];
        [self._coins addObject:coin21];
        [self._coins addObject:coin22];
        [self._coins addObject:coin23];
        [self._coins addObject:coin24];
        [self._coins addObject:coin25];
        [self._coins addObject:coin26];
        [self._coins addObject:coin27];
        [self._coins addObject:coin28];
        [self._coins addObject:coin29];
        [self._coins addObject:coin30];
        [self._coins addObject:coin31];
        [self._coins addObject:coin32];
        [self._coins addObject:coin33];
        [self._coins addObject:coin34];
        [self._coins addObject:coin35];
        [self._coins addObject:coin36];
        [self._coins addObject:coin37];
        [self._coins addObject:coin38];
        [self._coins addObject:coin39];
        [self._coins addObject:coin40];
        [self._coins addObject:coin41];
        [self._coins addObject:coin42];
        [self._coins addObject:coin43];
        [self._coins addObject:coin44];
        [self._coins addObject:coin45];
        [self._coins addObject:coin46];
        [self._coins addObject:coin47];
        [self._coins addObject:coin48];
        [self._coins addObject:coin49];
        [self._coins addObject:coin50];
    }
    return self;
}

- (void)dealloc {
    self._coins = nil;
    [super dealloc];
}

- (void)stageOn:(CCNode*)page {
    [super stageOn:page];
    for (Coin *coin in self._coins) {
        int dx = floor(CCRANDOM_0_1()*800);
        int dy = floor(CCRANDOM_0_1()*300);
        coin.position = ccpAdd(ccp(self.position.x, 0), [PointUtil getPosition:INIT_DROPPING_COIN_X + dx y:INIT_DROPPING_COIN_Y + dy]);
        [coin stageOn:[self parent]];
    }
}

- (void)start {
    [super start];
    for (Coin *coin in self._coins) {
        [coin start];
    }
}

- (void)stop {
    [super stop];
    for (Coin *coin in self._coins) {
        [coin stop];
    }    
}

- (void)reset {
    [super reset];
    for (Coin *coin in self._coins) {
        int dx = floor(CCRANDOM_0_1()*800);
        coin.position = ccpAdd(ccp(self.position.x, 0), [PointUtil getPosition:INIT_DROPPING_COIN_X + dx y:INIT_DROPPING_COIN_Y]);
        [coin reset];
    }
}

- (BOOL)takenIfCollided:(CGRect)rect {
    BOOL result = [super takenIfCollided:rect];
    if (result) {
        for (Coin *coin in self._coins) {
            [coin drop];
        }
    }
    for (Coin *coin in self._coins) {
        [coin takenIfCollided:rect];
    }    
    return result;
}

@end
