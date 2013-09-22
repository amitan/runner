//
//  Crystal.m
//  runner
//
//  Created by Ayumi Otomo on 2013/09/16.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Crystal.h"
#import "PointUtil.h"
#import "CommonAnimation.h"

@interface Crystal ()
@property (nonatomic, readwrite)int _crystalId;
@property (nonatomic, readwrite)BOOL _isStaged;
@property (nonatomic, readwrite)CGPoint _initPosition;
@end

@implementation Crystal

+ (Crystal*)createCrystal:(float)x y:(float)y {
    Crystal *crystal = [[[Crystal alloc] init] autorelease];
    crystal.position = [PointUtil getPosition:x y:y];
    return crystal;
}

- (id)init {
    self = [super init];
    if (self) {
        
        // 初期設定
        self._isStaged = false;
        self._crystalId = 0;
        
        // アイテムを設定
        [self _addCrystal];
    }
    return self;
}

- (int)getCrystalId {
    return self._crystalId;
}

- (void)start {
    [super start];
    self._initPosition = self._sprite.position;
    [self._sprite runAction:[CommonAnimation getTopDownAction]];
}

- (void)stop {
    [super stop];
    [self._sprite stopAllActions];
    self._sprite.position = self._initPosition;
}

- (void)reset {
    [super reset];
    [self._sprite removeFromParentAndCleanup:YES];
    [self _addCrystal];
}

- (void)stageOn:(CCNode*)page {
    [super stageOn:page];
    self._isStaged = true;
}

- (void)_addCrystal {
    // TODO:back
    self._crystalId = CRYSTAL_BLACK;
//    self._crystalId = floor(CCRANDOM_0_1()*4) + 1;
    if (![self._sprite parent]) {
        self._sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"crystal%d_1.png", self._crystalId]];
        [self addChild:self._sprite];
    }
}
- (BOOL)takenIfCollided:(CGRect)rect {
    
    // コインがステージ上にない場合はfalse
    if (!self._isStaged) return false;
    
    // 当たり判定チェック
    if (CGRectIntersectsRect([self getLayerBasedBox], rect)) {
        self._isStaged = false;
        [self removeFromParentAndCleanup:NO];
        return true;
    }
    return false;
}
@end
