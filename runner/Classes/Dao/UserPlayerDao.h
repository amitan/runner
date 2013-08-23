//
//  UserPlayerDao.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/18.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserPlayerDao : NSObject

// 所持キャラの操作
+ (NSMutableDictionary*)createUserPlayer:(int)playerId sequenceId:(int)sequenceId;
+ (void)registerUserPlayers:(NSMutableArray*)userPlayers;
+ (NSMutableDictionary*)getUserPlayer:(int)sequenceId;
+ (NSMutableArray*)getUserPlayers;
+ (void)updateUserPlayer:(NSMutableDictionary*)userPlayer;

@end
