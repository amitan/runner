//
//  SkyEnemy.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/31.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "SkyEnemy.h"
#import "PointUtil.h"
#import "EnemyAnimation.h"

@implementation SkyEnemy

+ (SkyEnemy*)createEnemy:(ENEMY_TYPE)enemyId x:(float)x y:(float)y {
    SkyEnemy *enemy = [[[self alloc] initWithEnemyId:enemyId] autorelease];
    enemy.position = [PointUtil getPosition:x y:y];
    return enemy;
}

- (BOOL)isEnemyHit:(CGPoint)point direction:(DIRECTION)direction {
    if (direction == BOTTOM) return false;
    return [self _isHit:point];
}

- (BOOL)deadIfCollided:(CGPoint)point direction:(DIRECTION)direction {
    if (direction != BOTTOM) return false;
    BOOL result = [self _isHit:point];
    if (result) {
        self._isStaged = false;
        [self._sprite runAction:[EnemyAnimation getDeadAction]];
    }
    return result;
}
@end
