//
//  Page102.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/25.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page102.h"
#import "PointUtil.h"

@implementation Page102

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期設定
        self._blocks = [NSMutableArray arrayWithCapacity:7];
        
        // 地面を追加
        self._land = [Block createBlock:3];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        // ブロック追加
        Block *block1 = [Block createPipe:1];
        Block *block2 = [Block createBlock:201];
        Block *block3 = [Block createPipe:1];
        Block *block4 = [Block createBlock:201];
        Block *block5 = [Block createPipe:1];
        Block *block6 = [Block createBlock:201];
        Block *block7 = [Block createBlock:201];
        
        block1.position = [PointUtil getPosition:100 y:-640];
        block2.position = [PointUtil getPosition:100 y:-720];
        block3.position = [PointUtil getPosition:900 y:-640];
        block4.position = [PointUtil getPosition:900 y:-720];
        block5.position = [PointUtil getPosition:1500 y:-560];
        block6.position = [PointUtil getPosition:1500 y:-640];
        block7.position = [PointUtil getPosition:1500 y:-720];
        
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
