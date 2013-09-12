//
//  HalfNeedleEnemy.m
//  runner
//
//  Created by Ayumi Otomo on 2013/09/01.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "HalfNeedleEnemy.h"
#import "PointUtil.h"

@implementation HalfNeedleEnemy

+ (HalfNeedleEnemy*)createEnemy:(ENEMY_TYPE)enemyId x:(float)x y:(float)y {
    HalfNeedleEnemy *enemy = [[[self alloc] initWithEnemyId:enemyId] autorelease];
    enemy.position = [PointUtil getPosition:x y:y];
    return enemy;
}

- (BOOL)isEnemyHit:(CGPoint)point direction:(DIRECTION)direction {
    return [self _isHit:point];
}

- (BOOL)deadIfCollided:(CGPoint)point direction:(DIRECTION)direction {
    return false;
}
@end
