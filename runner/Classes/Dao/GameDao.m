//
//  GameDao.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/21.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "GameDao.h"

@implementation GameDao

+ (int)getGold {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [[userDefaults objectForKey:@"gold"] intValue];
}

+ (void)addGold:(int)gold {
    int currentGold = [GameDao getGold];
    currentGold += gold;
    [GameDao setGold:currentGold];
}

+ (void)useGold:(int)gold {
    int currentGold = [GameDao getGold];
    currentGold -= gold;
    [GameDao setGold:currentGold];
}

+ (void)setGold:(int)gold {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithInt:gold] forKey:@"gold"];
    [userDefaults synchronize];
}

+ (int)getHomeStep {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [[userDefaults objectForKey:@"homeStep"] intValue];
}

+ (void)setHoemStep:(int)homeStep {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:[NSNumber numberWithInt:homeStep] forKey:@"homeStep"];
    [userDefaults synchronize];
}

+ (void)incrementHoemStep {
    int homeStep = [GameDao getHomeStep];
    homeStep++;
    [GameDao setHoemStep:homeStep];
}

@end
