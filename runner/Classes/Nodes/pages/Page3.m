//
//  Page3.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/20.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page3.h"
#import "Block.h"
#import "PointUtil.h"

@interface Page3 ()
@property (nonatomic, retain)Block* _land;
@property (nonatomic, retain)NSMutableArray *_blocks;
@end

@implementation Page3
const int MAX_BLOCK_NUM = 1;

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期設定
        self._blocks = [NSMutableArray arrayWithCapacity:MAX_BLOCK_NUM];

        // 地面を追加
        self._land = [Block createBlock:1];
        self._land.position = [PointUtil getPosition:[self._land getWidth] / 2 y:-BASE_HEIGHT + [self._land getHeight] / 2];
        [self addChild:self._land];
        
        Block *block1 = [Block createBlock:101];
        block1.position = [PointUtil getPosition:300 y:-730];
        [self._blocks addObject:block1];
        
        for (Block *block in self._blocks) {
            [self addChild:block];
        }
    }
    return self;
}

- (void)start {
    [super start];
}

- (void)stop {
    [super stop];
}

- (float)getWidth {
    return [self._land getWidth];
}

- (Block*)getHitBlock:(CGPoint)point {
    for (Block *block in self._blocks) {
        if ([block isHit:point]) return block;
    }
    if ([self._land isHit:point]) return self._land;
    return NULL;
}

@end
