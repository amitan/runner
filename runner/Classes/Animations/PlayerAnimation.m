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

+ (id)getWalkAnimation:(int)enemyId {
    CCAnimation *animation = [CommonAnimation getFrameAnimation:[NSString stringWithFormat:@"enemy%d_right", enemyId] frameNum:3];
    return [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation]];
}

@end
