//
//  UserPlayer.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/18.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserPlayer : NSObject

+ (NSMutableDictionary*)createUserPlayer:(int)playerId sequenceId:(int)sequenceId;
+ (NSMutableDictionary*)getUserPlayer:(int)sequenceId;

@end
