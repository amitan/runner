//
//  SharpDownState.m
//  runner
//
//  Created by Ayumi Otomo on 2013/09/19.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "SharpDownState.h"
#import "PointUtil.h"
#import "GameUtil.h"
#import "CommonAnimation.h"
#import "GameScene.h"

@interface SharpDownState ()
@property (nonatomic, readwrite)BOOL _isDowning, _isInvincibility;
@property (nonatomic, retain)CCSprite *_sprite, *_underSprite;
@end

@implementation SharpDownState

- (id)initWithCrystalId:(int)playerId crystalId:(int)crystalId {
    self = [super initWithCrystalId:playerId crystalId:crystalId];
	if (self) {
        self._sprite = [CCSprite spriteWithSpriteFrameName:@"skydown1_0.png"];
        self._underSprite = [CCSprite spriteWithSpriteFrameName:@"none.png"];
        self._isDowning = false;
        self._isInvincibility = false;
    }
    return self;
}

- (void)reset:(CCSprite*)sprite {
    [self._sprite removeFromParentAndCleanup:NO];
}

- (float)jump:(CCSprite *)sprite num:(float)num vy:(float)vy onGroud:(BOOL)onGround {
    
    if (num == 0 && onGround) { // 初回ジャンプ
        return self._jumpSpeed;
        
    } else if (!onGround) { // 空中急降下
        if (![self._sprite parent]) {
            self._sprite.position = ccp(sprite.contentSize.width / 2, 0);
            [sprite addChild:self._sprite];
        }
        self._isDowning = true;
        self._isInvincibility = true;
        return vy - [PointUtil getPoint:2000];
    }
    
    return vy;
}

- (void)gotDown:(CCSprite*)sprite {
    if (self._isDowning) {
        self._isDowning = false;
        [self._sprite removeFromParentAndCleanup:NO];
        if (![self._underSprite parent]) {
            self._underSprite.position = ccp(sprite.contentSize.width / 2, sprite.contentSize.height / 2);
            [sprite addChild:self._underSprite z:-1];
        }
        
        NSArray *array = [[GameScene sharedInstance].mapController.landMap attackAllEnemies];
        for (Enemy *enemy in array) {
            BOOL result = [[GameScene sharedInstance].hudController addExp:[enemy getExp]];
            if (result) break;
        }
        [self._underSprite runAction:[CommonAnimation getFrameAction:@"skydown1_" frameNum:7 duration:0.05f count:1 func:[CCCallBlock actionWithBlock:^{
            self._isInvincibility = false;
        }]]];
    }
}

- (BOOL)ignoreEnemyJump {
    return self._isDowning;
}

- (BOOL)ignoreEnemy {
    return self._isInvincibility;
}

- (BOOL)isForce {
    return self._isInvincibility;
}

@end
