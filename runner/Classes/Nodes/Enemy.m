//
//  Enemy.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/20.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Enemy.h"
#import "EnemyAnimation.h"

@interface Enemy ()
@property (nonatomic, readwrite)int _charaId;
@property (nonatomic, retain)CCSprite *_enemySprite;
@property (nonatomic, readwrite)BOOL _isStaged;
@end

@implementation Enemy

+ (Enemy*)createEnemy:(int)charaId {
    return [[[self alloc] initWithCharaId:charaId] autorelease];
}

- (id)initWithCharaId:(int)charaId {
    self = [super init];
	if (self) {

        // 初期値設定
        self._charaId = charaId;
        self._isStaged = false;
        
        // アニメーションの最初のコマを読み込む
        NSString* fileName = [NSString stringWithFormat:@"chara%d_left1.png", self._charaId];
        self._enemySprite = [CCSprite spriteWithSpriteFrameName:fileName];
        [self addChild:self._enemySprite];

    }
    return self;
}

- (void)stageOn:(CCNode*)page {
    self._isStaged = true;
    if (![self parent]) {
        [page addChild:self];
    }
}

- (void)start {
    [self._enemySprite runAction:[EnemyAnimation getWalkAction:self._charaId]];
}

- (void)stop {
    [self._enemySprite stopAllActions];
}

- (void)reset {
    self._enemySprite.position = ccp(0, 0);
}

- (BOOL)isHit:(CGPoint)point {
    if (!self._isStaged) return false;
    
    if (CGRectContainsPoint([self _getLayerBasedBox], point)) {
        self._isStaged = false;
        return true;
    }
    return false;
}

- (BOOL)deadIfCollided:(CGPoint)point {
    BOOL result = [self isHit:point];
    if (result) {
        [self._enemySprite runAction:[EnemyAnimation getDeadAction]];
    }
    return result;
}

- (CGRect)_getLayerBasedBox {
    return CGRectMake(self.position.x + [self parent].position.x - [self getWidth] / 2,
                      self.position.y + [self parent].position.y - [self getHeight] / 2,
                      [self getWidth], [self getHeight]);
}

- (float)getWidth {
    return self._enemySprite.contentSize.width;
}

- (float)getHeight {
    return self._enemySprite.contentSize.height;
}

@end
