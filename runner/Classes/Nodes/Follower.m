//
//  Follower.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/26.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Follower.h"
#import "PointUtil.h"
#import "GameScene.h"
#import "GameUtil.h"

@interface Follower ()
@property (nonatomic, readwrite)int _monsterId, _orderNo;
@property (nonatomic, retain)CCSprite *_sprite;
@property (nonatomic, readwrite)BOOL _isUP, _isRight;
@property (nonatomic, readwrite)float _minX, _maxX, _maxY, _minY;
@end

@implementation Follower

+ (Follower*)createFollower:(int)monsterId orderNo:(int)orderNo {
    return [[[self alloc] initWithMonsterId:monsterId orderNo:orderNo] autorelease];
}

- (id)initWithMonsterId:(int)monsterId orderNo:(int)orderNo {
    self = [super init];
	if (self) {
        
        // 初期値設定
        self._monsterId = monsterId;
        self._orderNo = orderNo;
        self._isUP = true;
        self._isRight = true;

        // 画像の設定
        NSString* fileName = [NSString stringWithFormat:@"player%d_small.png", self._monsterId];
        self._sprite = [CCSprite spriteWithSpriteFrameName:fileName];
        [self addChild:self._sprite];
        CCSprite *bubbleSprite = [CCSprite spriteWithSpriteFrameName:@"bubble.png"];
        bubbleSprite.position = ccp(self._sprite.contentSize.width / 2, self._sprite.contentSize.height / 2);
        [self._sprite addChild:bubbleSprite];
    }
    return self;
}

- (void)dealloc {
    self._sprite = nil;
    [super dealloc];
}

- (void)stageOn {
    [PointUtil setPosition:self x:50 y:660 offsetX:0 offsetY:-self._sprite.contentSize.height / 2];
    [[GameScene sharedInstance].gameLayer addChild:self z:INIT_PLAYER_Z - self._orderNo];
    self._minX = self.position.x - [PointUtil getPoint:15];
    self._maxX = self.position.x + [PointUtil getPoint:15];
    self._minY = self.position.y - [PointUtil getPoint:100];
    self._maxY = self.position.y + [PointUtil getPoint:100];
}

- (void)start {
    [self scheduleUpdate];
}

- (void)stop {
    [self unscheduleUpdate];
}

- (void)update:(ccTime)dt {
    float x = self.position.x;
    float y = self.position.y;
    if (y > self._maxY) self._isUP = false;
    if (y < self._minY) self._isUP = true;
    if (x > self._maxX) self._isRight = false;
    if (x < self._minX) self._isRight = true;
    float dx = [PointUtil getPoint:0.05];
    float dy = [PointUtil getPoint:0.1];
    x = (self._isRight) ? x + dx : x - dx;
    y = (self._isUP) ? y + dy : y - dy;
    self.position = ccp(x, y);
}

@end
