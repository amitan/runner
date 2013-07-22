//
//  PlayerController.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "PlayerController.h"
#import "Player.h"
#import "Follower.h"

@interface PlayerController ()
@property (nonatomic, retain)Player *_player;
@property (nonatomic, retain)Follower *_follower1;
@property (nonatomic, retain)Follower *_follower2;
@end

@implementation PlayerController

- (id)init {
    self = [super init];
	if (self) {
        self._player = [Player createPlayer:1]; // TODO:: キャラ指定実装
        self._follower1 = [Follower createFollower:4];
        self._follower2 = [Follower createFollower:5];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)setup {
    [self._player stageOn];
    [self._follower1 stageOn:1];
    [self._follower2 stageOn:2];
}

- (void)start {
    [self._player start];
    [self._follower1 start];
    [self._follower2 start];
}

- (void)stop {
    [self._player stop];
    [self._follower1 stop];
    [self._follower2 stop];
}

- (void)jump {
    [self._player jump];
}

- (void)speedUp {
    [self._player speedUp];
}

- (void)moveFollower:(int)order points:(NSMutableArray*)points {
    switch (order) {
        case 1:
            [self._follower1 setPointArray:points];
            break;
        case 2:
            [self._follower2 setPointArray:points];
            break;
    }
}

- (void)followerUpdate {
    [self._follower1 updatePosition];
    [self._follower2 updatePosition];
}

@end
