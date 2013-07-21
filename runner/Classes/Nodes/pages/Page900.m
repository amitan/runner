//
//  Page900.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/21.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page900.h"


@implementation Page900

- (id)init {
    self = [super init];
	if (self) {
        self.isSpeedUp = true;
        
        // 地面を追加
        self._land = [Block createBlock:1];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
    }
    return self;
}

- (void)reset {
    [super reset];
    self.isSpeedUp = true;
}
@end
