//
//  Page11.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/06.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page11.h"


@implementation Page11

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        self._land = [Block createBlock:1];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
    }
    return self;
}

@end
