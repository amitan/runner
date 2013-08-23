//
//  UserPlayerDao.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/18.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "UserPlayerDao.h"

@implementation UserPlayerDao

+ (NSMutableDictionary*)createUserPlayer:(int)playerId sequenceId:(int)sequenceId {
    NSMutableDictionary *userPlayer = [NSMutableDictionary dictionary];
    [userPlayer setObject:[NSNumber numberWithInt:sequenceId] forKey:@"sequenceId"];
    [userPlayer setObject:[NSNumber numberWithInt:1] forKey:@"level"];
    [userPlayer setObject:[NSNumber numberWithInt:playerId] forKey:@"playerId"];
    return userPlayer;
}

+ (void)registerUserPlayers:(NSMutableArray *)userPlayers {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *classData = [NSKeyedArchiver archivedDataWithRootObject:userPlayers];
    [userDefaults setObject:classData forKey:@"userPlayers"];
}

+ (NSMutableArray*)getUserPlayers {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSData *classData = [userDefaults objectForKey:@"userPlayers"];
    return [NSKeyedUnarchiver unarchiveObjectWithData:classData];
}

+ (NSMutableDictionary*)getUserPlayer:(int)sequenceId {
    NSMutableArray *array = [UserPlayerDao getUserPlayers];
    
    for (NSMutableDictionary *userPlayer in array) {
        int targetId = [[userPlayer objectForKey:@"sequenceId"] intValue];
        if (sequenceId == targetId) {
            return userPlayer;
        }
    }
    return nil;
}

+ (void)updateUserPlayer:(NSMutableDictionary*)userPlayer {
    int sequenceId = [[userPlayer objectForKey:@"sequenceId"] intValue];
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSMutableArray *array = [UserPlayerDao getUserPlayers];
    
    NSMutableArray *newArray = [NSMutableArray arrayWithCapacity:array.count];
    for (int i = 0; i < array.count; i++) {
        NSMutableDictionary *target = [array objectAtIndex:i];
        int targetId = [[userPlayer objectForKey:@"sequenceId"] intValue];
        if (targetId == sequenceId) {
            [newArray addObject:userPlayer];
        } else {
            [newArray addObject:target];
        }
    }
    [UserPlayerDao registerUserPlayers:newArray];
    [userDefaults synchronize];
}

@end
