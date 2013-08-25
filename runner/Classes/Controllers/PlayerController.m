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

@interface PlayerController ()
@property (nonatomic, retain)Player *_player;
@property (nonatomic, retain)Follower *_follower1, *_follower2;
@end

@implementation PlayerController

- (id)init {
    self = [super init];
	if (self) {
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
}

- (void)start {
    [self._player start];
    [self._follower1 start];
}

- (void)stop {
    [self._player stop];
    [self._follower1 stop];
}

- (void)jump {
    [self._player jump];
}

- (void)trampoline {
    [self._player trampoline];
}

- (void)speedUp {
    [self._player speedUp];
}

@end
