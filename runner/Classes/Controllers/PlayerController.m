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
#import "Plane.h"
#import "GameScene.h"

@interface PlayerController ()
@property (nonatomic, retain)Player *_player;
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
    [super dealloc];
}

- (void)setup {
    
    // 操作キャラ追加
    int playerSequenceId = [UnitDao getUnitSequenceId:1];
    NSMutableDictionary *userPlayer = [UserPlayerDao getUserPlayer:playerSequenceId];
    int playerId = [userPlayer[@"playerId"] intValue];
    self._player = [Player createPlayer:playerId];
    [self._player stageOn];
    
    // 乗り物追加
    self._plane = [Plane node];
    [self._plane stageOn];
}

- (void)changePlayer:(int)crystalId {
    
    [self _changePlayer:crystalId];
    [self._player runChangeEffect:[CCCallBlock actionWithBlock:^{
        [self._player start];
    }]];
}

- (void)_changePlayer:(int)crystalId {
    int newPlayerId = INIT_PLAYER_ID + crystalId;
    Player *newPlayer = [Player createPlayer:newPlayerId isReverse:[self._player isReverse]];
    CGPoint position = self._player.position;
    
    [self._player removeFromParentAndCleanup:YES];
    self._player = newPlayer;
    [self._player stageOn];
    self._player.position = position;    
}

- (void)backToDefaultPlayer {
    [self _changePlayer:0];
    [self._player invisibleStart];
}

- (void)start {
    [self._player start];
}

- (void)stop {
    [self._player stop];
}

- (void)touchBegan {
    if (self._isFlying) {
        [self._plane flyDown];
    } else {
        [self._player touchBegan];
    }
}

- (void)touchEnd {
    if (self._isFlying) {
        [self._plane flyUp];
    } else {
        [self._player touchEnd];
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
    [self._player clearItemEffect];
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

- (BOOL)deadIfBulletCollided:(Bullet*)bullet {
    return [self._player deadIfBulletCollided:bullet];
}

- (CGPoint)getPlayerFootPosition {
    return ccpSub(self._player.position, ccp(0, [self._player getHeight] / 2));
}

- (BOOL)isItemEffecting {
    return [self._player isItemEffecting];
}

@end
