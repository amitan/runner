//
//  SkyPage.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/29.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "SkyPage.h"
#import "PointUtil.h"
#import "Coin.h"
#import "Page1000.h"
#import "Page1001.h"

@implementation SkyPage

- (BOOL)takeCoinsIfCollided:(CGRect)rect {
    
    // コイン取得チェック
    BOOL result = false;
    for (Coin *coin in self._coins) {
        if ([coin takenIfCollided:rect]) result = true;
    }
    return result;
}

- (float)getWidth {
    return [PointUtil getPoint:960];
}

@end
