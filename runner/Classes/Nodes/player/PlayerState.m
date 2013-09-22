//
//  PlayerState.m
//  runner
//
//  Created by Ayumi Otomo on 2013/09/19.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "PlayerState.h"
#import "PointUtil.h"
#import "PlayerMaster.h"
#import "StandardState.h"
#import "SharpDownState.h"
#import "SkyRunState.h"
#import "GameUtil.h"
#import "ThunderState.h"
#import "ScrewState.h"
#import "Crystal.h"

@implementation PlayerState

+ (PlayerState*)create:(int)playerId crystalId:(int)crystalId {
    int specialType = [[PlayerMaster getInstance] getSpecialType:playerId];
    if (specialType == 2) {
        return [[[ScrewState alloc] initWithCrystalId:playerId crystalId:crystalId] autorelease];
    } else if (specialType == 3) {
        return [[[SkyRunState alloc] initWithCrystalId:playerId crystalId:crystalId] autorelease];
    } else if (specialType == 4) {
        return [[[SharpDownState alloc] initWithCrystalId:playerId crystalId:crystalId] autorelease];
    } else if (specialType == 5) {
        return [[[ThunderState alloc] initWithCrystalId:playerId crystalId:crystalId] autorelease];
    }
    return [[[StandardState alloc] initWithCrystalId:playerId crystalId:crystalId] autorelease];
}

- (id)initWithCrystalId:(int)playerId crystalId:(int)crystalId {
    self = [super init];
	if (self) {
        self._playerId = playerId;
        self._crystalId = crystalId;
        self._jumpSpeed = [PointUtil getPoint:[[PlayerMaster getInstance] getJumpSpeed:playerId]];
        self._jumpNum = [[PlayerMaster getInstance] getJumpNum:playerId];
    }
    return self;
}

- (void)reset:(CCSprite*)sprite {
}

- (float)jump:(CCSprite *)sprite num:(float)num vy:(float)vy onGroud:(BOOL)onGround {
    return vy;
}

- (BOOL)ignoreEnemyJump {
    return false;
}
- (BOOL)ignoreEnemy {
    return false;
}

- (float)calcGravity:(CCSprite*)sprite vy:(float)vy touch:(BOOL)isTouching {
    return vy - [PointUtil getPoint:GRAVITY];
}

- (void)gotDown:(CCSprite *)sprite {
}
- (BOOL)isForce {
    return false;
}
- (float)touchEnd:(CCSprite *)sprite vy:(float)vy onGround:(BOOL)onGround isReverse:(BOOL)isReverse isRunning:(BOOL)isRunning {
    return vy;
}

@end
