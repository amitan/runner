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

+ (id)getWalkAction:(int)monsterId {
    return [CommonAnimation getFrameRepeatAction:[NSString stringWithFormat:@"monster%d_right", monsterId] frameNum:2];
}

+ (CCParticleSystem*)getDeadParticle {
    CCParticleSystem *emitter = [CCParticleSystemQuad particleWithFile:@"dead.plist"];
    emitter.duration = 0.5f;
    emitter.autoRemoveOnFinish = YES;
    return emitter;
}

@end
