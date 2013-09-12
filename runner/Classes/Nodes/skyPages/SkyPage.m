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
#import "Enemy.h"

@implementation SkyPage

- (BOOL)takeCoinsIfCollided:(CGPoint)center radius:(float)radius {
    
    // コイン取得チェック
    for (Coin *coin in self._coins) {
        if ([coin takenIfCollided:center radius:radius]) return true;
    }
    return false;
}

- (BOOL)isEnemyHit:(CGPoint)center radius:(float)radius {
    for (Enemy *enemy in self._enemies) {
        if ([enemy isEnemyHit:center radius:radius]) return true;
    }
    return false;
}

- (float)getWidth {
    return [PointUtil getPoint:950];
}

@end
