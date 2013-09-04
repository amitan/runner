//
//  EnemyAnimation.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/20.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "EnemyAnimation.h"
#import "CommonAnimation.h"
#import "PointUtil.h"

@implementation EnemyAnimation

+ (id)getWalkAction:(int)charaId {
    return [CommonAnimation getFrameRepeatAction:[NSString stringWithFormat:@"enemy%d_left", charaId] frameNum:3];
}

+ (id)getDeadAction {
    id rotate = [CCRotateTo actionWithDuration:0.5f angle:180];
    id move = [CCMoveBy actionWithDuration:0.5f position:[PointUtil getPosition:150 y:-300]];
    id resetRotate = [CCRotateTo actionWithDuration:0 angle:0];
    return [CCSequence actions:[CCSpawn actions:rotate, move, nil], resetRotate, nil];
}

@end
