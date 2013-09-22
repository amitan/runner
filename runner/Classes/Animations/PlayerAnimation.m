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

+ (id)getWalkAction:(int)monsterId isReverse:(BOOL)isReverse frameNum:(int)frameNum {
    NSString *direction = isReverse ? @"left" : @"right";
    return [CommonAnimation getFrameRepeatAction:[NSString stringWithFormat:@"player%d_%@", monsterId, direction] frameNum:frameNum duration:0.15f];
}

+ (CCParticleSystem*)getDeadParticle {
    CCParticleSystem *emitter = [CCParticleSystemQuad particleWithFile:@"dead.plist"];
    emitter.duration = 0.5f;
    emitter.autoRemoveOnFinish = YES;
    return emitter;
}

+ (id)getRotateAction {
    id rotate = [CCRotateBy actionWithDuration:0.3f angle:360];
    return [CCRepeatForever actionWithAction:rotate];
}

+ (id)getDamagedAction {
    id tint = [CCTintTo actionWithDuration:0.3f red:255 green:0 blue:0];
    id reset = [CCTintTo actionWithDuration:0 red:255 green:255 blue:255];
    return [CCSequence actions:tint, reset, tint, reset, tint ,reset, nil];
}

@end
