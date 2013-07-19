//
//  Page.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/16.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page.h"

@implementation Page
@synthesize isPlaying;

- (id)init {
    self = [super init];
	if (self) {
        isPlaying = false;
    }
    return self;
}

// needs to be overwritten
- (void)start {
    isPlaying = true;
}

// needs to be overwritten
- (void)stop {
    isPlaying = false;
}

// needs to be overwritten
- (void)reset {
}

// needs to be overwritten
- (float)getWidth {
    return 0;
}

// needs to be overwritten
- (Block*)getHitBlock:(CGPoint)point {
    return NULL;
}

- (BOOL)checkHitCoins:(CGPoint)point {
    return false;
}

@end
