//
//  GameUtil.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "GameUtil.h"

@implementation GameUtil
const int INIT_PLAYER_X = 250;

+ (NSString*) getBgSpriteName:(NSString *)fileName ext:(NSString *)ext {
    if ([GameUtil is4inchDevice]) {
        return [NSString stringWithFormat:@"%@-568h@2x.%@", fileName, ext];
    } else {
        return [NSString stringWithFormat:@"%@.%@", fileName, ext];
    }
}

+ (BOOL)is4inchDevice {
    CGRect frame = [[UIScreen mainScreen] applicationFrame];
    if (frame.size.height == 568.0) { // iPhone 4inch (568 - 20 px)
        return YES;
    } else {
        return NO;
    }
}

+ (void)replaceScene:(CCScene *)scene {
    CCScene *transition = [CCTransitionFade transitionWithDuration:1.0 scene:scene withColor:ccc3(255, 255, 255)];
    [[CCDirector sharedDirector] replaceScene:transition];
}

@end
