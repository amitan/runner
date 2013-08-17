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
    return [CommonAnimation getFrameRepeatAction:[NSString stringWithFormat:@"player%d_%@", monsterId, direction] frameNum:2 duration:0.2f];
}

+ (CCParticleSystem*)getDeadParticle {
    CCParticleSystem *emitter = [CCParticleSystemQuad particleWithFile:@"dead.plist"];
    emitter.duration = 0.5f;
    emitter.autoRemoveOnFinish = YES;
    return emitter;
}

@end
