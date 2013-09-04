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
    enemy.position = [PointUtil getPosition:x y:y];
    return enemy;
}

- (BOOL)isEnemyHit:(CGPoint)point direction:(DIRECTION)direction {
    if (direction == TOP) return false;
    return [self _isHit:point];
}

- (BOOL)deadIfCollided:(CGPoint)point direction:(DIRECTION)direction {
    if (direction != TOP) return false;
    BOOL result = [self _isHit:point];
    if (result) {
        self._isStaged = false;
        [self._sprite runAction:[EnemyAnimation getDeadAction]];
    }
    return result;
}


@end
