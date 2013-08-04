//
//  SwitchCoin.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/04.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "SwitchCoin.h"


@implementation SwitchCoin

- (id)initWithCoinId:(int)coinId {
    self = [super initWithCoinId:coinId];
    if (self) {
        self.visible = NO;
    }
    return self;
}

- (BOOL)takenIfCollided:(CGRect)rect {
    if (self.visible) {
        return [super takenIfCollided:rect];
    }
    return false;
}

- (void)appear {
    [super appear];
    self.visible = YES;
}

- (void)reset {
    [super reset];
    self.visible = NO;
}

@end
