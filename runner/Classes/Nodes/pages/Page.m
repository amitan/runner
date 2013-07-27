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
#import "Page0.h"
#import "Page101.h"
#import "Page102.h"
#import "Page103.h"

#import "Page1.h"
#import "Page2.h"
#import "Page3.h"
#import "Page4.h"
#import "Page900.h"

@interface Page ()
@property (nonatomic, readwrite)BOOL _finishCoinBonus;
@property (nonatomic, readwrite)BOOL _isStaged;
@end

@implementation Page
@synthesize isPlaying, isSpeedUp;

- (id)init {
    self = [super init];
	if (self) {
        self.isPlaying = false;
        self.isSpeedUp = false;
        self._finishCoinBonus = false;
        self._isStaged = false;
    }
    return self;
}

+ (Page*)create:(int)pageId {
    switch (pageId) {
        case 1: return [Page1 node];
        case 2: return [Page2 node];
        case 3: return [Page3 node];
        case 4: return [Page4 node];
        case 101: return [Page101 node];
        case 102: return [Page102 node];
        case 103: return [Page103 node];
        case 900: return [Page900 node];
        default: return [Page0 node];
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
    self.isPlaying = true;
    for (Block *block in self._blocks) {
        [block start];
    }
    for (Coin *coin in self._coins) {
        [coin start];
    }
    for (Enemy *enemy in self._enemies) {
        [enemy start];
    }
}

- (void)stop {
    self.isPlaying = false;
    for (Block *block in self._blocks) {
        [block stop];
    }
    for (Coin *coin in self._coins) {
        [coin stop];
    }
    for (Enemy *enemy in self._enemies) {
        [enemy stop];
    }
}

- (void)reset {
    self._finishCoinBonus = false;
    for (Block *block in self._blocks) {
        [block reset];
        [block stageOn:self];
    }
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

- (CGPoint)getLandPosition:(Block*)block {
    return ccpAdd(ccp([block getWidth] / 2, [block getHeight] / 2), [PointUtil getPosition:0 y:-BASE_HEIGHT]);
}

- (Block*)getHitBlock:(CGPoint)point {
    for (Block *block in self._blocks) {
        if ([block isHit:point]) return block;
    }
    if ([self._land isHit:point]) return self._land;
    return NULL;
}

- (BOOL)takeCoinsIfCollided:(CGRect)rect {
    
    // コイン取得チェック
    BOOL result = false;
    for (Coin *coin in self._coins) {
        if ([coin takenIfCollided:rect]) result = true;
    }
    // コインボーナスチェック
    if (!self._finishCoinBonus && self._lastCoin && [self._lastCoin hasTaken]) {
        self._finishCoinBonus = true;
        BOOL bonus = true;
        for (Coin *coin in self._coins) {
            if (![coin hasTaken]) bonus = false;
        }
        if (bonus) {
            [[GameScene sharedInstance].hudController addCoinBonus:self._coins.count];
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
