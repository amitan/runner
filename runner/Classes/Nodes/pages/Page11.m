//
//  Page11.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/10.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page11.h"
#import "Trampoline.h"
#import "PointUtil.h"

@implementation Page11

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期設定
        self._trampolines = [NSMutableArray arrayWithCapacity:1];

        // 地面を追加
        self._land = [Block createBlock:1];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];

        // ジャンプ台
        Trampoline *trampoline1 = [Trampoline createTrampoline:1];
        trampoline1.position = [PointUtil getPosition:160 y:-730];
        [self._trampolines addObject:trampoline1];
        for (Trampoline *trampoline in self._trampolines) {
            [trampoline stageOn:self];
        }
        
    }
    return self;
}

@end
