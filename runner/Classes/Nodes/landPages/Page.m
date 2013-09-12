//
//  Page.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/29.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page.h"
#import "PointUtil.h"
#import "LandPage.h"
#import "SkyPage.h"

@implementation Page

- (id)init {
    self = [super init];
	if (self) {
        self.isPlaying = false;
        self.isStaged = false;
        [self resetAppearNum];
    }
    return self;
}

- (BOOL)isOut {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    float limitX = winSize.width / 2 - [PointUtil getPoint:BASE_WIDTH / 2];
    float currentRightX = self.position.x + [self parent].position.x + [self getWidth];
    if (currentRightX < limitX) {
        return true;
    }
    return false;
}

- (void)resetAppearNum {
    self.appearNum = 1;
}

- (void)dealloc {
    self._coins = nil;
    self._enemies = nil;
    [super dealloc];
}

- (void)start {
    self.isPlaying = true;
    for (Coin *coin in self._coins) {
        [coin start];
    }
    for (Enemy *enemy in self._enemies) {
        [enemy start];
    }
}

- (void)stop {
    self.isPlaying = false;
    for (Coin *coin in self._coins) {
        [coin stop];
    }
    for (Enemy *enemy in self._enemies) {
        [enemy stop];
    }
}

- (void)reset {
    self.appearNum++;
    for (Coin *coin in self._coins) {
        [coin reset];
        [coin stageOn:self];
    }
    for (Enemy *enemy in self._enemies) {
        [enemy reset];
        [enemy stageOn:self];
    }
}

- (void)stageOn:(CCNode*)map {
    self.isStaged = true;
    [map addChild:self];
}

- (void)stageOff {
    self.isStaged = false;
    [self stop];
    [self reset];
    [self removeFromParentAndCleanup:NO];
}

- (float)getWidth {
    return 0;
}

- (void)clear {
}


@end
