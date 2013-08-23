//
//  Page13.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/12.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page13.h"
#import "PointUtil.h"

@interface Page13 ()
@property (nonatomic, retain)Block *_land2;
@end

@implementation Page13
const int PAGE13_INTERVAL1 = 100;

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        self._land = [Block createBlock:2];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        float rightX = self._land.position.x + [self._land getWidth] / 2;
        self._land2 = [Block createBlock:2];
        self._land2.position = ccpAdd(ccp(rightX + [PointUtil getPoint:PAGE13_INTERVAL1], 0), [self getLandPosition:self._land2]);
        [self._land2 stageOn:self];
    }
    return self;
}

- (void)dealloc {
    self._land2 = nil;
    [super dealloc];
}

- (float)getWidth {
    return [self._land getWidth] + [self._land2 getWidth] + [PointUtil getPoint:PAGE13_INTERVAL1];
}

- (Block*)getHitBlock:(CGPoint)point {
    for (Block *block in self._blocks) {
        if ([block isHit:point]) return block;
    }
    if ([self._land isHit:point]) return self._land;
    if ([self._land2 isHit:point]) return self._land2;
    return NULL;
}

@end
