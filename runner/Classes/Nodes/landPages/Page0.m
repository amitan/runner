//
//  Page0.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/16.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page0.h"
#import "Block.h"
#import "PointUtil.h"
#import "GameUtil.h"

// 地面のみ
@implementation Page0

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        Block *land = [Block createBlock:LAND_DEFAULT];
        land.position = [self getLandPosition:land];
        [land stageOn:self];
        self._lands = @[land];
    }
    return self;
}

@end
