//
//  Enemy.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/20.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Enemy.h"
#import "EnemyAnimation.h"
#import "PointUtil.h"

@interface Enemy ()
@property (nonatomic, readwrite)int _charaId;
@property (nonatomic, readwrite)BOOL _isStaged;
@end

@implementation Enemy

+ (Enemy*)createEnemy:(int)charaId {
    return [Enemy createEnemy:charaId x:0 y:0];
}

+ (Enemy*)createEnemy:(int)charaId x:(float)x y:(float)y {
    Enemy *enemy = [[[self alloc] initWithCharaId:charaId] autorelease];
    enemy.position = [PointUtil getPosition:x y:y];
    return enemy;
}

- (id)initWithCharaId:(int)charaId {
    self = [super init];
	if (self) {

        // 初期値設定
        self._charaId = charaId;
        self._isStaged = false;
        
        // アニメーションの最初のコマを読み込む
        NSString* fileName = [NSString stringWithFormat:@"chara%d_left1.png", self._charaId];
        self._sprite = [CCSprite spriteWithSpriteFrameName:fileName];
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
    [self._sprite runAction:[EnemyAnimation getWalkAction:self._charaId]];
}

- (void)stop {
    [super stop];
    [self._sprite stopAllActions];
}

- (void)reset {
    [super reset];
    self._sprite.position = ccp(0, 0);
}

- (BOOL)isHit:(CGPoint)point {
    if (!self._isStaged) return false;
    
    if (CGRectContainsPoint([self getLayerBasedBox], point)) {
        self._isStaged = false;
        return true;
    }
    return false;
}

- (BOOL)deadIfCollided:(CGPoint)point {
    BOOL result = [self isHit:point];
    if (result) {
        [self._sprite runAction:[EnemyAnimation getDeadAction]];
    }
    return result;
}

@end