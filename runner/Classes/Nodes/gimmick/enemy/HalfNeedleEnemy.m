//
//  HalfNeedleEnemy.m
//  runner
//
//  Created by Ayumi Otomo on 2013/09/01.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "HalfNeedleEnemy.h"
#import "PointUtil.h"
#import "EnemyAnimation.h"

@implementation HalfNeedleEnemy

+ (HalfNeedleEnemy*)createEnemy:(ENEMY_TYPE)enemyId x:(float)x y:(float)y {
    HalfNeedleEnemy *enemy = [[[self alloc] initWithEnemyId:enemyId] autorelease];
    return enemy;
}

- (BOOL)isEnemyHit:(CGPoint)point direction:(DIRECTION)direction {
    return [self _isHit:point];
}

- (BOOL)deadIfCollided:(CGPoint)point direction:(DIRECTION)direction isForce:(BOOL)isForce {
    if (direction != TOP) return false;
    if (!isForce) return false;
    BOOL result = [self _isHit:point];
    if (result) {
        self._isStaged = false;
        [self._sprite runAction:[EnemyAnimation getDeadAction]];
    }
    return result;
}
@end
