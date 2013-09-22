//
//  ScrewState.m
//  runner
//
//  Created by Ayumi Otomo on 2013/09/22.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "ScrewState.h"
#import "PlayerAnimation.h"

@interface ScrewState ()
@property (nonatomic, readwrite)int _playerId;
@property (nonatomic, readwrite)BOOL _isTouching;
@end

@implementation ScrewState

- (id)initWithCrystalId:(int)playerId crystalId:(int)crystalId {
    self = [super initWithCrystalId:playerId crystalId:crystalId];
	if (self) {
        self._isTouching = false;
    }
    return self;
}

- (float)jump:(CCSprite *)sprite num:(float)num vy:(float)vy onGroud:(BOOL)onGround {
    if (!self._isTouching) {
        self._isTouching = true;
        [sprite stopAllActions];
        [sprite runAction:[PlayerAnimation getRotateAction]];
    }
    return vy;
}

- (float)touchEnd:(CCSprite *)sprite vy:(float)vy onGround:(BOOL)onGround isReverse:(BOOL)isReverse isRunning:(BOOL)isRunning {
    
    if (self._isTouching) {
        self._isTouching = false;
        [sprite stopAllActions];
        [sprite runAction:[CCRotateTo actionWithDuration:0.1f angle:0]];
        if (isRunning) {
            [sprite runAction:[PlayerAnimation getWalkAction:self._playerId isReverse:isReverse frameNum:3]];
        }
    }
    if (onGround) {
        return self._jumpSpeed;
    }
    return vy;
}

- (void)reset:(CCSprite *)sprite {
    [sprite runAction:[CCRotateTo actionWithDuration:0.1f angle:0]];
}

- (BOOL)ignoreEnemy {
    return self._isTouching;
}
- (BOOL)ignoreEnemyJump {
    return self._isTouching;
}
- (BOOL)isForce {
    return self._isTouching;
}

@end
