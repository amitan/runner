//
//  StandardCoin.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/31.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "StandardCoin.h"


@implementation StandardCoin

- (id)initWithCoinId:(int)coinId groupId:(int)groupId {
    self = [super initWithCoinId:coinId groupId:groupId];
    if (self) {
        switch (self._coinId) {
            case 5:
                self._value = 100;
                break;
        }
    }
    return self;
}

@end
