//
//  Page.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/16.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page.h"
#import "Enemy.h"
#import "Switch.h"
#import "Trampoline.h"
#import "Rail.h"
#import "GameScene.h"
#import "PointUtil.h"
#import "Page0.h"
#import "Page1.h"
#import "Page2.h"
#import "Page3.h"
#import "Page4.h"
#import "Page5.h"
#import "Page6.h"
#import "Page7.h"
#import "Page8.h"
#import "Page9.h"
#import "Page10.h"
#import "Page11.h"
#import "Page12.h"
#import "Page13.h"
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
        case 5: return [Page5 node];
        case 6: return [Page6 node];
        case 7: return [Page7 node];
        case 8: return [Page8 node];
        case 9: return [Page9 node];
        case 10: return [Page10 node];
        case 11: return [Page11 node];
        case 12: return [Page12 node];
        case 13: return [Page13 node];
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
    for (Switch *sw in self._switches) {
        [sw start];
    }
    for (Trampoline *trampoline in self._trampolines) {
        [trampoline start];
    }
    for (Rail *rail in self._rails) {
        [rail start];
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
    for (Switch *sw in self._switches) {
        [sw stop];
    }
    for (Trampoline *trampoline in self._trampolines) {
        [trampoline stop];
    }
    for (Rail *rail in self._rails) {
        [rail stop];
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
    for (Switch *sw in self._switches) {
        [sw reset];
    }
    for (Trampoline *trampoline in self._trampolines) {
        [trampoline reset];
    }
    for (Rail *rail in self._rails) {
        [rail reset];
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
