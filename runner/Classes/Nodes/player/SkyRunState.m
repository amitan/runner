//
//  SkyRunState.m
//  runner
//
//  Created by Ayumi Otomo on 2013/09/20.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "SkyRunState.h"
#import "PointUtil.h"
#import "GameUtil.h"
#import "CommonAnimation.h"

@interface SkyRunState ()
@property (nonatomic, readwrite)BOOL _isEffecting;
@property (nonatomic, retain)CCSprite *_sprite;
@end

@implementation SkyRunState

- (id)initWithCrystalId:(int)playerId crystalId:(int)crystalId {
    self = [super initWithCrystalId:playerId crystalId:crystalId];
	if (self) {
        self._isEffecting = false;
    }
    return self;
}

- (float)jump:(CCSprite *)sprite num:(float)num vy:(float)vy onGroud:(BOOL)onGround {
    
    if (num == 0 && onGround) { // 初回ジャンプ
        return self._jumpSpeed;
    }
    return vy;
}

- (float)calcGravity:(CCSprite*)sprite vy:(float)vy touch:(BOOL)isTouching {
    if (isTouching && vy < 0) {
        if (!self._isEffecting) {
            self._isEffecting = true;
            self._sprite = [CCSprite spriteWithSpriteFrameName:@"none.png"];
            self._sprite.position = ccp(sprite.contentSize.width / 2, 0);
            [sprite addChild:self._sprite z:-1];
            [self._sprite runAction:[CommonAnimation getFrameRepeatAction:@"skyrun1_" frameNum:3 duration:0.15f]];
        }
        return -[PointUtil getPoint:GRAVITY];
    } else {
        if (self._isEffecting) {
            [self._sprite stopAllActions];
            [self._sprite removeFromParentAndCleanup:YES];
            self._isEffecting = false;
        }
    }
    return vy - [PointUtil getPoint:GRAVITY];
}

@end
