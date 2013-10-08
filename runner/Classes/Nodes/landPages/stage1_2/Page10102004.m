//
//  Page10102004.m
//  runner
//
//  Created by Ayumi Otomo on 2013/10/06.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page10102004.h"
#import "PointUtil.h"

@implementation Page10102004

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        Block *land = [Block createBlock:LAND_4];
        land.position = [self getLandPosition:land];
        [land stageOn:self];
        
        Block *land2 = [Block createBlock:LAND_4];
        land2.position = ccpAdd(ccp([land getRightX] + [PointUtil getPoint:240], 0), [self getLandPosition:land2]);
        [land2 stageOn:self];
        
        Block *land3 = [Block createBlock:LAND_26];
        land3.position = ccpAdd(ccp([land2 getRightX] + [PointUtil getPoint:240], 0), [self getLandPosition:land3]);
        [land3 stageOn:self];
        
        self._lands = @[land, land2, land3];
    }
    return self;
}

@end
