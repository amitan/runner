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

+ (id)getFrameRepeatAction:(NSString *)name frameNum:(int)num {
    return [self getFrameRepeatAction:name frameNum:num duration:0.5f];
}

+ (id)getFrameRepeatAction:(NSString *)name frameNum:(int)num duration:(float)duration {
    CCAnimation *animation = [self getFrameAnimation:name frameNum:num duration:duration];
    return [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]];
}

+ (id)getBlinkAction {
    id blink = [CCBlink actionWithDuration:1.0f blinks:1];
    return [CCRepeatForever actionWithAction:blink];
}

@end
