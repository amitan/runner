//
//  Page1.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/16.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page1.h"
#import "Block.h"
#import "PointUtil.h"
#import "GameUtil.h"

// 地面のみ
@implementation Page1

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        self._land = [Block createBlock:1];
        self._land.position = [PointUtil getPosition:[self._land getWidth] / 2 y:-BASE_HEIGHT + [self._land getHeight] / 2];
        [self._land stageOn:self];
    }
    return self;
}

@end
