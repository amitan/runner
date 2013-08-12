//
//  Trampoline.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/10.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Trampoline.h"
#import "PointUtil.h"
#import "GameScene.h"

@implementation Trampoline
const float TRAMPOLINE_SCALE = 2.0;

+ (Trampoline*)createTrampoline:(int)trampolineId {
    return [Trampoline createTrampoline:trampolineId x:0 y:0];
}

+ (Trampoline*)createTrampoline:(int)trampolineId x:(float)x y:(float)y {
    Trampoline *trampoline = [[[Trampoline alloc] initWithTrampolineId:trampolineId] autorelease];
    trampoline.position = [PointUtil getPosition:x y:y];
    return trampoline;
}

- (id)initWithTrampolineId:(int)trampolineId {
    self = [super init];
    if (self) {
        
        // 初期設定
        self._trampolineId = trampolineId;
        
        // 画像を読み込む
        self._sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"trampoline%d_1.png", self._trampolineId]];
        self._spriteOn = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"trampoline%d_2.png", self._trampolineId]];
        [self addChild:self._sprite];
        [self addChild:self._spriteOn];
        [self sync];
    }
    return self;
}

- (BOOL)jumpIfCollided:(CGRect)rect {
    
    // ジャンプ済の場合はfalse
    if (self._isJumped) return false;
    
    // 当たり判定チェック
    if (CGRectContainsPoint(rect, [self _getLayerPoint])) {
        self._isJumped = true;
        [[GameScene sharedInstance].playerController trampoline];
        self._isScaled = true;
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

- (CGPoint)_getLayerPoint {
    return ccp(self.position.x + [self parent].position.x, self.position.y + [self parent].position.y);
}

- (void)reset {
    [super reset];
    self._isJumped = false;
    self._isScaled = false;
    [self sync];
}

- (void)sync {
    if (!self._isScaled) {
        self._sprite.visible = YES;
        self._spriteOn.visible = NO;
    } else {
        self._sprite.visible = NO;
        self._spriteOn.visible = YES;
    }
}

@end
