//
//  SkyPage.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/29.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "SkyPage.h"
#import "PointUtil.h"
#import "Coin.h"
#import "Page1000.h"
#import "Page1001.h"

@implementation SkyPage

- (BOOL)takeCoinsIfCollided:(CGPoint)center radius:(float)radius {
    
    // コイン取得チェック
    for (Coin *coin in self._coins) {
        if ([coin takenIfCollided:center radius:radius]) return true;
    }
    return false;
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
        [coin reset];
        [coin stageOn:self];
    }
}

- (float)getWidth {
    return [PointUtil getPoint:960];
}

@end
