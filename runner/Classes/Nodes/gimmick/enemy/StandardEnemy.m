//
//  StandardEnemy.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/31.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "StandardEnemy.h"
#import "PointUtil.h"
#import "EnemyAnimation.h"

@implementation StandardEnemy

+ (StandardEnemy*)createEnemy:(ENEMY_TYPE)enemyId x:(float)x y:(float)y {
    StandardEnemy *enemy = [[[self alloc] initWithEnemyId:enemyId] autorelease];
    return enemy;
}

- (BOOL)isEnemyHit:(CGPoint)point direction:(DIRECTION)direction {
    if (direction == TOP) return false;
    return [self _isHit:point];
}

- (BOOL)deadIfCollided:(CGPoint)point direction:(DIRECTION)direction isForce:(BOOL)isForce {
    if (direction != TOP) return false;
    BOOL result = [self _isHit:point];
    if (result) {
        self._isStaged = false;
        [self._sprite runAction:[EnemyAnimation getDeadAction]];
    }
    return result;
}

- (BOOL)deadBetween:(CGPoint)point end:(CGPoint)endPoint {
    if (!self._isStaged) return false;
    CGPoint enemyPosition = [self getLayerBasedPosition];
    if (point.x <= enemyPosition.x && enemyPosition.x <= endPoint.x) {
        self._isStaged = false;
        [self._sprite runAction:[EnemyAnimation getDeadAction]];
        return true;
    }
    return false;
}


@end
