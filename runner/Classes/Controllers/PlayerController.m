//
//  PlayerController.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "PlayerController.h"
#import "Player.h"

@interface PlayerController ()
@property (nonatomic, retain)Player *_player;
@end

@implementation PlayerController

- (id)init {
    self = [super init];
	if (self) {
        self._player = [Player createPlayer:1]; // TODO:: キャラ指定実装
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)setup {
    [self._player stageOn];
}

- (void)start {
    [self._player start];
}

- (void)stop {
    [self._player stop];
}

- (void)jump {
    [self._player jump];
}

- (void)speedUp {
    [self._player speedUp];
}

@end
