//
//  Page8.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/01.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page8.h"
#import "PointUtil.h"
#import "Crystal.h"

// 反転ブロックとでかコイン
@implementation Page8

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        Block *land = [Block createBlock:LAND_LONG];
        land.position = [self getLandPosition:land];
        [land stageOn:self];
        self._lands = @[land];
        
        
        // ブロック追加
        self._blocks = @[
                        [Block createBlock:502 x:100 y:-460],
                        [Block createBlock:501 x:500 y:-460],
                        ];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // クリスタル
        self._crystal = [Crystal createCrystal:300 y:-350];
        [self._crystal stageOn:self];
    }
    return self;
}

@end
