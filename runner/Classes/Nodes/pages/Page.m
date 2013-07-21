//
//  Page.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/16.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page.h"
#import "Coin.h"
#import "Enemy.h"
#import "GameScene.h"
#import "PointUtil.h"
#import "Page1.h"
#import "Page2.h"
#import "Page3.h"
#import "Page4.h"

@interface Page ()
@property (nonatomic, readwrite)BOOL _finishCoinBonus;
@property (nonatomic, readwrite)BOOL _isStaged;
@end

@implementation Page
@synthesize isPlaying;

- (id)init {
    self = [super init];
	if (self) {
        isPlaying = false;
        self._finishCoinBonus = false;
        self._isStaged = false;
    }
    return self;
}

+ (Page*)create:(int)pageId {
    switch (pageId) {
        case 1:
            return [Page1 node];
        case 2:
            return [Page2 node];
        case 3:
            return [Page3 node];
        case 4:
            return [Page4 node];
        default:
            return [Page1 node];
    }
}

- (void)stageOn:(CCNode*)map {
    self._isStaged = true;
    [map addChild:self];
}

- (void)stageOff {
    self._isStaged = false;
    [self stop];
    [self reset];
    [self removeFromParentAndCleanup:NO];
}

- (void)start {
    isPlaying = true;
    for (Coin *coin in self._coins) {
        [coin start];
    }
    for (Enemy *enemy in self._enemies) {
        [enemy start];
    }
}

- (void)stop {
    isPlaying = false;
    for (Coin *coin in self._coins) {
        [coin stop];
    }
    for (Enemy *enemy in self._enemies) {
        [enemy stop];
    }
}

- (void)reset {
    self._finishCoinBonus = false;
    for (Coin *coin in self._coins) {
        [coin reset];
        [coin stageOn:self];
    }
    for (Enemy *enemy in self._enemies) {
        [enemy reset];
        [enemy stageOn:self];
    }
}

- (float)getWidth {
    return [self._land getWidth];
}

- (Block*)getHitBlock:(CGPoint)point {
    for (Block *block in self._blocks) {
        if ([block isHit:point]) return block;
    }
    if ([self._land isHit:point]) return self._land;
    return NULL;
}

- (BOOL)takeCoinsIfCollided:(CGPoint)point {
    
    // コイン取得チェック
    BOOL result = false;
    for (Coin *coin in self._coins) {
        if ([coin takenIfCollided:point]) result = true;
    }
    // コインボーナスチェック
    if (!self._finishCoinBonus && self._lastCoin && [self._lastCoin hasTaken]) {
        self._finishCoinBonus = true;
        BOOL bonus = true;
        for (Coin *coin in self._coins) {
            if (![coin hasTaken]) bonus = false;
        }
        if (bonus) {
            [[GameScene sharedInstance].headerController addCoinBonus:self._coins.count];
        }
    }
    return result;
}

- (BOOL)attackEnemyIfCollided:(CGPoint)point {
    for (Enemy *enemy in self._enemies) {
        if ([enemy deadIfCollided:point]) return true;
    }
    return false;
}

- (BOOL)isHit:(CGPoint)point {
    for (Enemy *enemy in self._enemies) {
        if ([enemy isHit:point]) return true;
    }
    return false;    
}

- (BOOL)isOut {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    float limitX = winSize.width / 2 - [PointUtil getPoint:BASE_WIDTH / 2];
    float currentRightX = self.position.x + [self parent].position.x + [self getWidth];
    if (currentRightX < limitX) {
        return true;
    }
    return false;
}

- (BOOL)isStaged {
    return self._isStaged;
}

@end
