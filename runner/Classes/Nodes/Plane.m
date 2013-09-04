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
const int UPDOWN_SPEED = 300;

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

- (void)climbout {
    [self runAction:[CCRotateTo actionWithDuration:0.3f angle:-30]];
}

- (void)start {
    [self runAction:[CCRotateTo actionWithDuration:0.2f angle:-5]];
    [self scheduleUpdate];
}

- (void)stop {
    [self unscheduleUpdate];
}

- (void)flyDown {
    if (self._isUp) {
        self._isUp = false;
        [self runAction:[CCRotateTo actionWithDuration:0.3f angle:5]];
    }
}

- (void)flyUp {
    if (!self._isUp) {
        self._isUp = true;
        [self runAction:[CCRotateTo actionWithDuration:0.3f angle:-5]];
    }
}

- (void)update:(ccTime)dt {

    ///////////////////////////////////////////////////////////////
    // 取得判定
    ///////////////////////////////////////////////////////////////
    MapController *mapController = [GameScene sharedInstance].mapController;
    [mapController.skyMap takeItemsIfCollided:self.position radius:self._sprite.contentSize.width / 2];

    ///////////////////////////////////////////////////////////////
    // 横軸判定
    ///////////////////////////////////////////////////////////////
    float dx = self._vx * dt;
    [[GameScene sharedInstance].mapController skyScroll:dx];
    
    ///////////////////////////////////////////////////////////////
    // 縦軸判定
    ///////////////////////////////////////////////////////////////
    float dy;
    if (!([self _isUpLimit] || [self _isDownLimit])) {
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
    CCLOG(@"%f, %f", self.position.y, -self._sprite.contentSize.height);
    return !self._isUp && self.position.y < - self._sprite.contentSize.height / 2;
}

- (CGRect)getRect {
    CGRect rect = CGRectMake(self.position.x - self.contentSize.width / 2,
                      self.position.y - self.contentSize.height / 2,
                      self.contentSize.width, self.contentSize.height);
    return rect;
}
@end
