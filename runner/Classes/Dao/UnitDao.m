//
//  UnitDao.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/21.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "UnitDao.h"

@implementation UnitDao


+ (BOOL)isUnit:(int)sequenceId {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    for (int i = 0; i < 3; i++) {
        NSString *keyName = [NSString stringWithFormat:@"player%d", i + 1];
        int currentSequenceId = [[userDefaults objectForKey:keyName] intValue];
        if (sequenceId == currentSequenceId) {
            return true;
        }
    }
    return false;
}

+ (int)getUnitSequenceId:(int)order {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [[userDefaults objectForKey:[NSString stringWithFormat:@"player%d", order]] intValue];
}

@end
