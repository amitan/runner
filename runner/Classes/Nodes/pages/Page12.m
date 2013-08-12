//
//  Page12.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/12.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page12.h"
#import "PointUtil.h"
#import "Rail.h"

@interface Page12 ()
@property (nonatomic, retain)Block *_land2;
@end

@implementation Page12
const int PAGE12_INTERVAL1 = 300;

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        self._land = [Block createBlock:2];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        float rightX = self._land.position.x + [self._land getWidth] / 2;
        self._land2 = [Block createBlock:1];
        self._land2.position = ccpAdd(ccp(rightX + [PointUtil getPoint:PAGE12_INTERVAL1], 0), [self getLandPosition:self._land2]);
        [self._land2 stageOn:self];
        
        // ブロック追加
        self._blocks = [NSArray arrayWithObjects:
                        [Block createBlock:102 x:170 y:-730],
                        [Block createBlock:102 x:170 y:-670],
                        [Block createBlock:102 x:170 y:-610],
                        nil];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // レール追加
        self._rails = [NSArray arrayWithObjects:
                        [Rail createRail:1 x:270 y:-610],
                        nil];
        for (Rail *rail in self._rails) {
            [rail stageOn:self];
        }
        
    }
    return self;
}

- (float)getWidth {
    return [self._land getWidth] + [self._land2 getWidth] + [PointUtil getPoint:PAGE12_INTERVAL1];
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
