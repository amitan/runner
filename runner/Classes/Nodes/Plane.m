//
//  Plane.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/28.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Plane.h"
#import "PointUtil.h"
#import "GameScene.h"

@interface Plane ()
@property (nonatomic, retain)CCSprite *_sprite;
@property (nonatomic, readwrite)float _vx, _vy;
@property (nonatomic, readwrite)BOOL _isUp;
@end

@implementation Plane
const int INIT_FLYING_SPEED = 700;
const int UPDOWN_SPEED = 500;

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期値設定
        self._vx = [PointUtil getPoint:INIT_FLYING_SPEED];
        self._vy = [PointUtil getPoint:UPDOWN_SPEED];
        self._isUp = true;
        
        // 画像設定
        self._sprite = [CCSprite spriteWithSpriteFrameName:@"plane.png"];
        [self addChild:self._sprite];
    }
    return self;
}

- (void)stageOn {
    [PointUtil setPosition:self x:-150 y:520 offsetX:0 offsetY:-self._sprite.contentSize.height / 2];
    [[GameScene sharedInstance].gameLayer addChild:self];
}

- (void)takeOff:(id)func {
    CGPoint destination = [[GameScene sharedInstance].playerController getPlayerFootPosition];
    id moveTo = [CCMoveTo actionWithDuration:0.5f position:destination];
    [self runAction:[CCSequence actions:moveTo, func, nil]];
}

- (void)rotateUp {
    [self runAction:[CCRotateTo actionWithDuration:0.3f angle:-15]];
}

- (void)rotateDown {
    [self runAction:[CCRotateTo actionWithDuration:0.3f angle:15]];    
}

- (void)start {
    [self scheduleUpdate];
}

- (void)stop {
    [self unscheduleUpdate];
}

- (void)flyDown {
    if (self._isUp) {
        self._isUp = false;
        [self rotateDown];
    }
}

- (void)flyUp {
    if (!self._isUp) {
        self._isUp = true;
        [self rotateUp];
    }
}

- (void)update:(ccTime)dt {

    ///////////////////////////////////////////////////////////////
    // 横軸判定
    ///////////////////////////////////////////////////////////////
    float dx = self._vx * dt;
    [[GameScene sharedInstance].mapController skyScroll:dx];
    
    ///////////////////////////////////////////////////////////////
    // 縦軸判定
    ///////////////////////////////////////////////////////////////
    float dy;
    if (![self _isUpLimit] && ![self _isDownLimit]) {
        dy = (self._isUp) ? self._vy * dt : - self._vy * dt;
    }
    
    ///////////////////////////////////////////////////////////////
    // 位置更新
    ///////////////////////////////////////////////////////////////
    self.position = ccp(self.position.x, self.position.y + dy);    
}

- (BOOL)_isUpLimit {
    return self._isUp && self.position.y > BASE_HEIGHT - 2 * self._sprite.contentSize.height;
}

- (BOOL)_isDownLimit {
    return !self._isUp && self.position.y < - self._sprite.contentSize.height;
}

@end
