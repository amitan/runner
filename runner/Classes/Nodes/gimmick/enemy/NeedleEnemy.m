//
//  NeedleEnemy.m
//  runner
//
//  Created by Ayumi Otomo on 2013/09/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "NeedleEnemy.h"
#import "PointUtil.h"

@implementation NeedleEnemy

+ (NeedleEnemy*)createEnemy:(ENEMY_TYPE)enemyId x:(float)x y:(float)y {
    NeedleEnemy *enemy = [[[self alloc] initWithEnemyId:enemyId] autorelease];
    return enemy;
}

- (BOOL)isEnemyHit:(CGPoint)point radius:(float)radius {
    if (!self._isStaged) return false;
    CGPoint currentPosition = [self getLayerBasedPosition];
    float dx = abs(point.x - currentPosition.x);
    float dy = abs(point.y + radius / 5 - currentPosition.y - [self getHeight] / 2);
    float r = [self getHeight] / 2 + radius / 3;
    if (pow(dx, 2) + pow(dy, 2) <= pow(r, 2)) {
        return true;
    }
    return false;
}

- (BOOL)deadIfCollided:(CGPoint)point direction:(DIRECTION)direction isForce:(BOOL)isForce {
    return false;
}
@end
