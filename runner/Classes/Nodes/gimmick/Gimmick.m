//
//  Gimmick.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/12.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Gimmick.h"


@implementation Gimmick

- (void)stageOn:(CCNode*)page {
    if (![self parent]) {
        [page addChild:self];
    }
}

- (void)start {
}

- (void)stop {
}

- (void)reset {
}

@end
