//
//  UserPlayer.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/18.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "UserPlayer.h"

@implementation UserPlayer

+ (NSMutableDictionary*)createUserPlayer:(int)playerId sequenceId:(int)sequenceId {
    NSMutableDictionary *userPlayer = [NSMutableDictionary dictionary];
    [userPlayer setObject:[NSNumber numberWithInt:sequenceId] forKey:@"sequenceId"];
    [userPlayer setObject:[NSNumber numberWithInt:1] forKey:@"level"];
    [userPlayer setObject:[NSNumber numberWithInt:playerId] forKey:@"playerId"];
    return userPlayer;
}

+ (NSMutableDictionary*)getUserPlayer:(int)sequenceId {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSArray *array = [userDefaults objectForKey:@"userPlayers"];
    for (NSMutableDictionary *userPlayer in array) {
        int targetId = [[userPlayer objectForKey:@"sequenceId"] intValue];
        if (sequenceId == targetId) {
            return userPlayer;
        }
    }
    return nil;
}
@end
