//
//  ThunderState.m
//  runner
//
//  Created by Ayumi Otomo on 2013/09/21.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "ThunderState.h"
#import "GameScene.h"
#import "CommonAnimation.h"
#import "PointUtil.h"
#import "Enemy.h"

@interface ThunderState ()
@property (nonatomic, retain)CCSprite *_effectSprite, *_backSprite;
@end

@implementation ThunderState

- (id)initWithCrystalId:(int)playerId crystalId:(int)crystalId {
    self = [super initWithCrystalId:playerId crystalId:crystalId];
	if (self) {
        self._backSprite = [CCSprite spriteWithSpriteFrameName:@"black_belt.png"];
        self._backSprite.scaleY = 7;
        [PointUtil setPosition:self._backSprite x:480 y:320 offsetX:0 offsetY:0];
        self._effectSprite = [CCSprite spriteWithSpriteFrameName:@"thunder1_1.png"];
        [PointUtil setPosition:self._effectSprite x:480 y:320 offsetX:0 offsetY:0];
    }
    return self;
}

- (float)jump:(CCSprite *)sprite num:(float)num vy:(float)vy onGroud:(BOOL)onGround {
    
    if (num == 0 && onGround) { // 初回ジャンプ
        return self._jumpSpeed;
        
    } else if (num == 1 && !onGround) { // 全体攻撃
        if (![self._backSprite parent]) {
            [[GameScene sharedInstance].effectLayer addChild:self._backSprite];
        }
        if (![self._effectSprite parent]) {
            [[GameScene sharedInstance].effectLayer addChild:self._effectSprite];
        }
        
        id endFunc = [CCCallBlock actionWithBlock:^{
            [self._effectSprite removeFromParentAndCleanup:NO];
            [self._backSprite removeFromParentAndCleanup:NO];
        }];
        [self._effectSprite runAction:[CommonAnimation getFrameAction:@"thunder1_" frameNum:5 duration:0.1f count:1 func:endFunc]];
        NSArray *array = [[GameScene sharedInstance].mapController.landMap attackAllEnemies];
        for (Enemy *enemy in array) {
            BOOL result = [[GameScene sharedInstance].hudController addExp:[enemy getExp]];
            if (result) break;
        }
    }
    
    return vy;
}

@end
