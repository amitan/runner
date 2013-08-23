//
//  PlayerMaster.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/18.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PlayerMaster : NSObject

+ (PlayerMaster *)getInstance;

- (NSString*)getName:(int)playerId;
- (int)getMaxLevel:(int)playerId;
- (int)getNextGold:(int)playerId currentLevel:(int)level;
- (int)getGoldBonus:(int)playerId currentLevel:(int)level;

@end
