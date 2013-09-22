//
//  Bullet.m
//  runner
//
//  Created by Ayumi Otomo on 2013/09/01.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Bullet.h"
#import "PointUtil.h"
#import "GameScene.h"

@interface Bullet ()
@property (nonatomic, retain)CCSprite *_sprite;
@property (nonatomic, readwrite)CGPoint _initPosition;
@end
@implementation Bullet
const int BULLET_SPEED = 18;
const int BULLET_DISAPPEAR_X = -200;

- (id)init {
    self = [super init];
	if (self) {
        self.isStaged = false;
        self._sprite = [CCSprite spriteWithSpriteFrameName:@"fire.png"];
        [self addChild:self._sprite];
    }
    return self;
}

- (void)stageOn:(CGPoint)position {
    self.isStaged = true;
    self.position = position;
    [[GameScene sharedInstance].gameLayer addChild:self];
}

- (void)start {
    self._initPosition = self.position;
    [self scheduleUpdate];
}

- (void)stop {
    [self unscheduleUpdate];
}

- (void)reset {
    self.position = self._initPosition;
}

- (void)clear {
    [self stop];
    [self reset];
    [self removeFromParentAndCleanup:NO];
    self.isStaged = false;
}

- (void)update:(ccTime)dt {
    float dx = [PointUtil getPoint:BULLET_SPEED];
    self.position = ccp(self.position.x - dx, self.position.y);
    
    // 画面外に出た場合
    if (self.position.x < [PointUtil getPoint:BULLET_DISAPPEAR_X]) {
        [self clear];
    } else {
        [[GameScene sharedInstance].playerController deadIfBulletCollided:self];
    }
}

@end
