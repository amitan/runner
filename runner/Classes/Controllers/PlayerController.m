//
//  PlayerController.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "PlayerController.h"
#import "Player.h"
#import "UnitDao.h"
#import "UserPlayerDao.h"
#import "PlayerMaster.h"
#import "Follower.h"
#import "Plane.h"
#import "GameScene.h"

@interface PlayerController ()
@property (nonatomic, retain)Player *_player;
@property (nonatomic, retain)Follower *_follower1, *_follower2;
@property (nonatomic, retain)Plane *_plane;
@property (nonatomic, readwrite)BOOL _isFlying;
@end

@implementation PlayerController

- (id)init {
    self = [super init];
	if (self) {
        self._isFlying = false;
    }
    return self;
}

- (void)dealloc {
    self._player = nil;
    self._follower1 = nil;
    self._follower2 = nil;
    [super dealloc];
}

- (void)setup {
    
    // 操作キャラ追加
    int playerSequenceId = [UnitDao getUnitSequenceId:1];
    NSMutableDictionary *userPlayer = [UserPlayerDao getUserPlayer:playerSequenceId];
    int playerId = [userPlayer[@"playerId"] intValue];
    self._player = [Player createPlayer:playerId];
    self._player.frameNum = [[PlayerMaster getInstance] getFrameNum:playerId];
    [self._player stageOn];
    
    // 乗り物追加
    self._plane = [Plane node];
    [self._plane stageOn];
}

- (void)start {
    [self._player start];
    [self._follower1 start];
}

- (void)stop {
    [self._player stop];
    [self._follower1 stop];
}

- (void)touchBegan {
    if (self._isFlying) {
        [self._plane flyDown];
    } else {
        [self._player jump];
    }
}

- (void)touchEnd {
    if (self._isFlying) {
        [self._plane flyUp];
    }
}

- (void)trampoline {
    [self._player trampoline];
}

- (void)speedUp {
    [self._player speedUp];
}

- (void)ride {
    [self._player stop];
    [self._follower1 stop];
    [self._plane takeOff:[CCCallBlock actionWithBlock:^{
        [self._player stageOff];
        self._player.position = ccp(0, [self._player getHeight] / 2);
        [self._plane addChild:self._player];
        [self._plane climbout];
        [[GameScene sharedInstance].mapController flyUp];
    }]];
}

- (void)getOff:(CGPoint)position {
    [self._player getOff:position func:[CCCallBlock actionWithBlock:^{
        [[GameScene sharedInstance].mapController flyDown];
        [self._player goDown:[CCCallBlock actionWithBlock:^{
            self._isFlying = false;
            [self._player start];
        }]];
    }]];
}

- (void)fly {
    self._isFlying = true;
    [self._plane start];
}

- (BOOL)deadIfBulletCollided:(CGPoint)position {
    return [self._player deadIfBulletCollided:position];
}

- (CGPoint)getPlayerFootPosition {
    return ccpSub(self._player.position, ccp(0, [self._player getHeight] / 2));
}

@end
