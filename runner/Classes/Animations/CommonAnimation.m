//
//  CommonAnimation.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/09.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "CommonAnimation.h"
#import "PointUtil.h"

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

+ (id)getFrameAction:(NSString*)name frameNum:(int)num duration:(float)duration count:(int)count func:(id)func {
    NSMutableArray *array = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        id action = [CCAnimate actionWithAnimation:[CommonAnimation getFrameAnimation:name frameNum:num duration:duration]];
        [array addObject:action];
    }
    [array addObject:func];
    return [CCSequence actionWithArray:array];
}

+ (CCAnimation*)getSingleFrameAnimation:(NSString*)name frame:(int)frameNo duration:(float)duration {
    NSMutableArray *frames = [NSMutableArray arrayWithCapacity:1];
    NSString *fileName = [NSString stringWithFormat:@"%@%d.png", name, frameNo];
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:fileName];
    [frames addObject:frame];
    return [CCAnimation animationWithSpriteFrames:frames delay:duration];
}

+ (id)getSingleFrameAction:(NSString *)name{
    NSMutableArray *frames = [NSMutableArray arrayWithCapacity:1];
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:name];
    [frames addObject:frame];
    return [CCAnimate actionWithAnimation:[CCAnimation animationWithSpriteFrames:frames delay:0]];
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

+ (id)getTopDownAction {
    float dy = [PointUtil getPoint:15];
    id moveTop = [CCMoveBy actionWithDuration:0.3f position:ccp(0, dy)];
    id moveDown = [CCMoveBy actionWithDuration:0.3f position:ccp(0, -dy)];
    id seq = [CCSequence actions:moveTop, moveDown, moveDown, moveTop, nil];
    return [CCRepeatForever actionWithAction:seq];
}

+ (id)getEffectAppearAction:(float)dx {
    id fadeIn = [CCFadeIn actionWithDuration:0];
    id moveTo = [CCMoveBy actionWithDuration:0.5f position:[PointUtil getPosition:dx y:0]];
    id delay = [CCDelayTime actionWithDuration:0.3f];
    id fadeOut = [CCFadeOut actionWithDuration:0.2f];
    id reset = [CCMoveBy actionWithDuration:0 position:[PointUtil getPosition:-dx y:0]];
    return [CCSequence actions:fadeIn, moveTo, delay, fadeOut, reset, nil];
}

+ (id)getNotificationAction {
    id scale1 = [CCScaleTo actionWithDuration:0 scale:1];
    id blink = [CCBlink actionWithDuration:2.0f blinks:2];
    id scale2 = [CCScaleTo actionWithDuration:0 scale:0];
    return [CCSequence actions:scale1, blink, scale2, nil];
}

+ (id)getShakeAction {
    id shake = [CCWaves3D actionWithDuration:0.5f];
//    id shake = [CCShaky3D actionWithRange:4 shakeZ:NO grid:ccg(12, 12) duration:0.5];
    return [CCSequence actions:shake, nil];
}

@end
