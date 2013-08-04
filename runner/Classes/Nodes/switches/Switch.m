//
//  Switch.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/04.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Switch.h"
#import "CoinSwitch.h"

@implementation Switch

+ (Switch*)createSwitch:(int)switchId {
    switch (switchId) {
        default:
            return [[[CoinSwitch alloc] initWithSwitchId:switchId] autorelease];
    }
}

- (id)initWithSwitchId:(int)switchId {
    self = [super init];
    if (self) {
        
        // 初期設定
        self._isPressed = false;
        self._switchId = switchId;
        
        // 画像を読み込む
        self._sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"switch%d_1.png", self._switchId]];
        self._spriteOn = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"switch%d_2.png", self._switchId]];
        [self addChild:self._sprite];
        [self addChild:self._spriteOn];
        [self sync];
    }
    return self;
}

- (void)stageOn:(CCNode*)page {
    if (![self parent]) {
        [page addChild:self];
    }
}

- (void)start {
}

- (void)stop {
}

- (void)reset {
    self._isPressed = false;
    [self sync];
}

- (void)sync {
    if (!self._isPressed) {
        self._sprite.visible = YES;
        self._spriteOn.visible = NO;
    } else {
        self._sprite.visible = NO;
        self._spriteOn.visible = YES;
    }
}

- (BOOL)pressIfCollided:(CGRect)rect {
    
    // 既にスイッチが押されている場合はfalse
    if (self._isPressed) return false;
    
    // 当たり判定チェック
    if (CGRectIntersectsRect([self _getLayerBasedBox], rect)) {
        self._isPressed = true;
        [self sync];
        return true;
    }
    return false;
}

- (CGRect)_getLayerBasedBox {
    return CGRectMake(self.position.x + [self parent].position.x - self._sprite.contentSize.width / 2,
                      self.position.y + [self parent].position.y - self._sprite.contentSize.height / 2,
                      self._sprite.contentSize.width, self._sprite.contentSize.height);
}

@end
