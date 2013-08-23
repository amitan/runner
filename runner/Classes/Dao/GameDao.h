//
//  GameDao.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/21.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameDao : NSObject

+ (int)getGold;
+ (void)addGold:(int)gold;
+ (void)useGold:(int)gold;
+ (void)setGold:(int)gold;

+ (int)getHomeStep;
+ (void)setHoemStep:(int)homeStep;
+ (void)incrementHoemStep;

@end
