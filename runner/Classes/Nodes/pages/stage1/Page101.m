//
//  Page101.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/25.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page101.h"
#import "PointUtil.h"

@implementation Page101

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期設定
        self._blocks = [NSMutableArray arrayWithCapacity:9];
        
        // 地面を追加
        self._land = [Block createBlock:1];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        // ブロック追加
        Block *block1 = [Block createHatena:1];
        Block *block2 = [Block createBlock:101];
        Block *block3 = [Block createHatena:1];
        Block *block4 = [Block createBlock:101];
        Block *block5 = [Block createHatena:1];
        Block *block6 = [Block createBlock:101];
        Block *block7 = [Block createHatena:1];
        
        block1.position = [PointUtil getPosition:100 y:-570];
        block2.position = [PointUtil getPosition:500 y:-570];
        block3.position = [PointUtil getPosition:580 y:-570];
        block4.position = [PointUtil getPosition:660 y:-570];
        block5.position = [PointUtil getPosition:740 y:-570];
        block6.position = [PointUtil getPosition:820 y:-570];
        block7.position = [PointUtil getPosition:660 y:-350];
        
        [self._blocks addObject:block1];
        [self._blocks addObject:block2];
        [self._blocks addObject:block3];
        [self._blocks addObject:block4];
        [self._blocks addObject:block5];
        [self._blocks addObject:block6];
        [self._blocks addObject:block7];
        
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
    }
    return self;
}

@end
