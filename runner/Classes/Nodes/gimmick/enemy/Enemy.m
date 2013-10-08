//
//  Enemy.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/20.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Enemy.h"
#import "PointUtil.h"
#import "StandardEnemy.h"
#import "HalfNeedleEnemy.h"
#import "NeedleEnemy.h"
#import "EnemyAnimation.h"

@interface Enemy ()
@property (nonatomic, readwrite)int _enemyId;
@end

@implementation Enemy

+ (Enemy*)createEnemy:(ENEMY_TYPE)enemyId {
    return [Enemy createEnemy:enemyId x:0 y:0];
}

+ (Enemy*)createEnemy:(ENEMY_TYPE)enemyId bx:(float)bx by:(float)by {
    float x = bx * 50;
    float y = (by - 1) * 50 - 640;
    return [Enemy createEnemy:enemyId x:x y:y];
}

+ (Enemy*)createEnemy:(ENEMY_TYPE)enemyId x:(float)x y:(float)y {
    Enemy *enemy;
    if (enemyId == 200) {
        enemy = [HalfNeedleEnemy createEnemy:enemyId x:x y:y];
    } else if (enemyId == 201) {
        enemy = [NeedleEnemy createEnemy:enemyId x:x y:y];
    } else {
        enemy = [StandardEnemy createEnemy:enemyId x:x y:y];
    }
    enemy.position = [PointUtil getPosition:x y:y];
    return enemy;
}

- (int)getExp {
    switch (self._enemyId) {
        case E_KINOKO:
            return 10;
        case E_SLYME:
            return 7;
        case E_NEEDLE_HALF:
            return 20;
        default:
            return 0;
    }
}

- (id)initWithEnemyId:(int)enemyId {
    self = [super init];
	if (self) {

        // 初期値設定
        self._enemyId = enemyId;
        self._isStaged = false;
        
        // アニメーションの最初のコマを読み込む
        NSString* fileName = [NSString stringWithFormat:@"enemy%d_left1.png", self._enemyId];
        self._sprite = [CCSprite spriteWithSpriteFrameName:fileName];
        self._sprite.anchorPoint = ccp(0.5, 0);
        [self addChild:self._sprite];

    }
    return self;
}

- (void)stageOn:(CCNode*)page {
    [super stageOn:page];
    self._isStaged = true;
}

- (void)start {
    [super start];
    [self._sprite runAction:[EnemyAnimation getWalkAction:self._enemyId]];
}

- (void)stop {
    [super stop];
    [self._sprite stopAllActions];
}

- (void)reset {
    [super reset];
    self._sprite.position = ccp(0, 0);
}

- (BOOL)isEnemyHit:(CGPoint)point direction:(DIRECTION)direction {
    return true;
}

- (BOOL)isEnemyHit:(CGPoint)point radius:(float)radius {
    return true;
}

- (BOOL)_isHit:(CGPoint)point {
    if (!self._isStaged) return false;
    CGRect bottomRect = [self getLayerBasedBox];
    CGRect centerRect = CGRectMake(bottomRect.origin.x, bottomRect.origin.y + [self getHeight] / 2 ,
                                   bottomRect.size.width, bottomRect.size.height);
    if (CGRectContainsPoint(centerRect, point)) {
        return true;
    }
    return false;
}

- (BOOL)deadIfCollided:(CGPoint)point direction:(DIRECTION)direction isForce:(BOOL)isForce {
    return false;
}
- (BOOL)deadBetween:(CGPoint)point end:(CGPoint)endPoint {
    return false;
}


@end
