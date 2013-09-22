//
//  Gun.m
//  runner
//
//  Created by Ayumi Otomo on 2013/09/01.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Gun.h"
#import "PointUtil.h"
#import "GameScene.h"
#import "CommonAnimation.h"
#import "Bullet.h"

@interface Gun ()
@property (nonatomic, retain)CCSprite *_sprite, *_lineSprite;
@property (nonatomic, retain)Bullet *_bullet1, *_bullet2;
@end

@implementation Gun
const int INIT_GUN_POSITION_X = 940;
const int INIT_GUN_POSITION_Y = 520;

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期値設定
        self.isStaged = false;
        
        // アニメーションの最初のコマを設定
        self._lineSprite = [CCSprite spriteWithSpriteFrameName:@"red_belt.png"];
        self._lineSprite.position = ccp(-self._lineSprite.contentSize.width / 2, -self._lineSprite.contentSize.height / 2);
        [self addChild:self._lineSprite];
        self._sprite = [CCSprite spriteWithSpriteFrameName:@"fire_warning1.png"];
        [self addChild:self._sprite];
        
        // ポジション設定
        self._bullet1 = [Bullet node];
        self._bullet2 = [Bullet node];
        [PointUtil setPosition:self x:INIT_GUN_POSITION_X y:INIT_GUN_POSITION_Y offsetX:0 offsetY:-self._sprite.contentSize.height / 2];
    }
    return self;
}

- (void)stageOn {
    self.isStaged = true;
    [self._bullet1 stageOn:self.position];
    [self._bullet2 stageOn:ccp(self.position.x + [PointUtil getPoint:60], self.position.y)];
    self._lineSprite.visible = false;
    [[GameScene sharedInstance].gameLayer addChild:self];
}

- (void)stageOff {
    [self stop];
    [self reset];
    [self removeFromParentAndCleanup:NO];
    self.isStaged = false;
}

- (BOOL)isReady {
    if (!self.isStaged) {
        if (!self._bullet1.isStaged && !self._bullet2.isStaged) return true;
    }
    return false;
}

- (void)clearBullets {
    [self._bullet1 clear];
    [self._bullet2 clear];
}

- (void)start {
    id fire = [CCCallBlock actionWithBlock:^{
        [self stageOff];
        [self._bullet1 start];
        [self._bullet2 start];
    }];
    [self._sprite runAction:[CommonAnimation getFrameAction:@"fire_warning" frameNum:2 duration:0.15f count:7 func:fire]];
    [self._lineSprite runAction:[CommonAnimation getBlinkAction]];
}

- (void)stop {
    [self._sprite stopAllActions];
    [self._lineSprite stopAllActions];
}

- (void)suspend {
    [self._sprite pauseSchedulerAndActions];
    [self._lineSprite pauseSchedulerAndActions];
    [self._bullet1 pauseSchedulerAndActions];
    [self._bullet2 pauseSchedulerAndActions];
}
- (void)resume {
    [self._sprite resumeSchedulerAndActions];
    [self._lineSprite resumeSchedulerAndActions];
    [self._bullet1 resumeSchedulerAndActions];
    [self._bullet2 resumeSchedulerAndActions];
}

- (void)reset {
    int y = INIT_GUN_POSITION_Y - floor(CCRANDOM_0_1()*200);
    [PointUtil setPosition:self x:INIT_GUN_POSITION_X y:y offsetX:0 offsetY:-self._sprite.contentSize.height / 2];
}

@end
