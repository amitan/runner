//
//  PlayerAnimation.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/09.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "PlayerAnimation.h"
#import "CommonAnimation.h"

@implementation PlayerAnimation

+ (id)getWalkAction:(int)monsterId isReverse:(BOOL)isReverse {
    NSString *direction = isReverse ? @"left" : @"right";
    return [CommonAnimation getFrameRepeatAction:[NSString stringWithFormat:@"monster%d_%@", monsterId, direction] frameNum:2 duration:0.2f];
}

+ (id)getAttackAction:(int)monsterId isReverse:(BOOL)isReverse func:(id)func {
    NSString *direction = isReverse ? @"left" : @"right";
    NSString *file = [NSString stringWithFormat:@"monster%d_%@_attack", monsterId, direction];
    id animation1 = [CCAnimate actionWithAnimation:[CommonAnimation getSingleFrameAnimation:file frame:1 duration:0.05f]];
    id animation2 = [CCAnimate actionWithAnimation:[CommonAnimation getSingleFrameAnimation:file frame:2 duration:0.05f]];
    id animation3 = [CCAnimate actionWithAnimation:[CommonAnimation getSingleFrameAnimation:file frame:3 duration:0.2f]];
    return [CCSequence actions:animation1, animation2, animation3, func, nil];
}

+ (CCParticleSystem*)getDeadParticle {
    CCParticleSystem *emitter = [CCParticleSystemQuad particleWithFile:@"dead.plist"];
    emitter.duration = 0.5f;
    emitter.autoRemoveOnFinish = YES;
    return emitter;
}

@end
