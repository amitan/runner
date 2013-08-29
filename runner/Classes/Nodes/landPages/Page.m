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

@implementation Page

+ (Page*)create:(int)pageId type:(int)type {
    switch (type) {
        case 1:
            return [LandPage create:pageId];
        default:
            return NULL;
    }
}

- (id)init {
    self = [super init];
	if (self) {
        self.isPlaying = false;
        self.isStaged = false;
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

- (void)start {
}

- (void)stop {
}

- (void)reset {
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

@end
