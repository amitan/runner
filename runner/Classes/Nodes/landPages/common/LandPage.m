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

- (id)init {
    self = [super init];
	if (self) {
        self._finishCoinBonus = false;
    }
    return self;
}

- (void)dealloc {
    self._lands = nil;
    self._lastCoin = nil;
    self._blocks = nil;
    self._switches = nil;
    self._trampolines = nil;
    self._rails = nil;
    self._item = nil;
    self._crystal = nil;
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
    [self._crystal start];
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
    [self._crystal stop];
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
    [self._crystal reset];
    [self._crystal stageOn:self];
}

- (float)getWidth {
    if (self._lands.count == 1) {
        return [[self._lands objectAtIndex:0] getWidth];
    } else if (self._lands.count > 1) {
        Block *first = [self._lands objectAtIndex:0];
        Block *last = [self._lands objectAtIndex:self._lands.count - 1];
        return last.position.x + [last getWidth] / 2 - first.position.x + [first getWidth] / 2;
    }
    return 0;
}

- (CGPoint)getLandPosition:(Block*)block {
    return ccpAdd(ccp([block getWidth] / 2, [block getHeight] / 2), [PointUtil getPosition:0 y:-BASE_HEIGHT]);
}

- (Block*)getHitBlock:(CGPoint)point {
    for (Block *block in self._blocks) {
        if ([block isHit:point]) return block;
    }
    for (Block *land in self._lands) {
        if ([land isHit:point]) return land;
    }
    return NULL;
}

- (Rail*)getHitRail:(CGRect)rect {
    for (Rail *rail in self._rails) {
        if ([rail isHit:rect]) return rail;
    }
    return NULL;
}


- (BOOL)takeCoinsIfCollided:(CGRect)rect magnet:(BOOL)isMagnet {
    
    // コイン取得チェック
    BOOL result = false;
    for (Coin *coin in self._coins) {
        if ([coin takenIfCollided:rect magnet:isMagnet]) result = true;
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

- (Crystal*)takeCrystalIfCollided:(CGRect)rect {
    if (self._crystal) {
        if ([self._crystal takenIfCollided:rect]) {
            return self._crystal;
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

- (Enemy*)attackEnemyIfCollided:(CGPoint)point direction:(DIRECTION)direction isForce:(BOOL)isForce {
    for (Enemy *enemy in self._enemies) {
        if ([enemy deadIfCollided:point direction:direction isForce:isForce]) return enemy;
    }
    return NULL;
}

- (NSArray*)attackEnemiesBetween:(CGPoint)point end:(CGPoint)endPoint {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:1];
    for (Enemy *enemy in self._enemies) {
        if ([enemy deadBetween:point end:(CGPoint)endPoint]) {
            [array addObject:enemy];
        }
    }
    return array;
}

- (BOOL)isEnemyHit:(CGPoint)point direction:(DIRECTION)direction {
    for (Enemy *enemy in self._enemies) {
        if ([enemy isEnemyHit:point direction:direction]) return true;
    }
    return false;
}

- (float)getCoinBx:(float)baseBx index:(int)index {
    return baseBx + 0.75 * index;
}

@end