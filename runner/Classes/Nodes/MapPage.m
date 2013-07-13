//
//  MapPage.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/10.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "MapPage.h"


@implementation MapPage

- (id)init {
    self = [super init];
	if (self) {
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (BOOL)containsPoint:(CGPoint)point {
    return true;
}

@end
