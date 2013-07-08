//
//  CommonAnimation.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/09.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "CommonAnimation.h"

@implementation CommonAnimation

+ (CCAnimation*)getFrameAnimation:(NSString*)name frameNum:(int)num {
    return [self getFrameAnimation:name frameNum:num duration:0.5f];
}

+ (CCAnimation*)getFrameAnimation:(NSString*)name frameNum:(int)num duration:(float)duration {
    NSMutableArray *frames = [NSMutableArray arrayWithCapacity:num];
    for (int i = 0; i < num; i++) {
        NSString *fileName = [NSString stringWithFormat:@"%@%d.png", name, i + 1];
        CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:fileName];
        [frames addObject:frame];
    }
    return [CCAnimation animationWithSpriteFrames:frames delay:duration];
}

@end
