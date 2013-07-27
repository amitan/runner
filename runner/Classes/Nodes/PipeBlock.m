//
//  PipeBlock.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/25.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "PipeBlock.h"


@implementation PipeBlock

- (id)initWithBlockId:(int)blockId {
    self = [super init];
	if (self) {
        
        // 画像を追加
        self._sprite = [CCSprite spriteWithSpriteFrameName:@"pipe1.png"];
        [self addChild:self._sprite];
    }
    return self;
}


@end
