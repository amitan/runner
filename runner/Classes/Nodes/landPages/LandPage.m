//
//  Page.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/16.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "LandPage.h"
#import "Enemy.h"
#import "Switch.h"
#import "Trampoline.h"
#import "Rail.h"
#import "GameScene.h"
#import "PointUtil.h"

@interface LandPage ()
@property (nonatomic, readwrite)BOOL _finishCoinBonus;
@end

@implementation LandPage
@synthesize isSpeedUp;

- (id)init {
    self = [super init];
	if (self) {
        self.isSpeedUp = false;
        self._finishCoinBonus = false;
    }
    return self;
}

- (void)dealloc {
    self._land = nil;
    self._lastCoin = nil;
    self._blocks = nil;
    self._switches = nil;
    self._trampolines = nil;
    self._rails = nil;
    self._item = nil;
    [super dealloc];
}

- (void)start {
    [super start];
    for (Block *block in self._blocks) {
        [block start];
    }
    for (Switch *sw in self._switches) {
        [sw start];
    }
    for (Trampoline *trampoline in self._trampolines) {
        [trampoline start];
    }
    for (Rail *rail in self._rails) {
        [rail start];
    }
    [self._item start];
}

- (void)stop {
    [super stop];
    for (Block *block in self._blocks) {
        [block stop];
    }
    for (Switch *sw in self._switches) {
        [sw stop];
    }
    for (Trampoline *trampoline in self._trampolines) {
        [trampoline stop];
    }
    for (Rail *rail in self._rails) {
        [rail stop];
    }
    [self._item stop];
}

- (void)reset {
    [super reset];
    self._finishCoinBonus = false;
    for (Block *block in self._blocks) {
        [block reset];
        [block stageOn:self];
    }
    for (Switch *sw in self._switches) {
        [sw reset];
    }
    for (Trampoline *trampoline in self._trampolines) {
        [trampoline reset];
    }
    for (Rail *rail in self._rails) {
        [rail reset];
    }
    [self._item reset];
    [self._item stageOn:self];
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

- (Rail*)getHitRail:(CGRect)rect {
    for (Rail *rail in self._rails) {
        if ([rail isHit:rect]) return rail;
    }
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

- (Item*)takeItemIfCollided:(CGRect)rect {
    if (self._item) {
        if ([self._item takenIfCollided:rect]) {
            return self._item;
        }
    }
    return NULL;
}

- (BOOL)pressSwitchesIfCollided:(CGRect)rect {
    BOOL result = false;
    for (Switch *sw in self._switches) {
        if ([sw pressIfCollided:rect]) {
            result = true;
            int groupId = sw.groupId;
            for (Coin *coin in self._coins) {
                [coin appear:groupId];
            }
        }
    }
    return result;
}

- (BOOL)jumpIfCollided:(CGRect)rect {
    for (Trampoline *trampoline in self._trampolines) {
        if ([trampoline jumpIfCollided:rect]) {
            return true;
        }
    }
    return false;
}

- (Enemy*)attackEnemyIfCollided:(CGPoint)point direction:(DIRECTION)direction {
    for (Enemy *enemy in self._enemies) {
        if ([enemy deadIfCollided:point direction:direction]) return enemy;
    }
    return NULL;
}

- (BOOL)isEnemyHit:(CGPoint)point direction:(DIRECTION)direction {
    for (Enemy *enemy in self._enemies) {
        if ([enemy isEnemyHit:point direction:direction]) return true;
    }
    return false;
}
@end
