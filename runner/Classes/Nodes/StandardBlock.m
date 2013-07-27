//
//  StandardBlock.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/25.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "StandardBlock.h"


@implementation StandardBlock

- (id)initWithBlockId:(int)blockId {
    self = [super init];
	if (self) {
        
        // 画像を追加
        self._sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"block%d.png", blockId]];
        [self addChild:self._sprite];
    }
    return self;
}

@end
