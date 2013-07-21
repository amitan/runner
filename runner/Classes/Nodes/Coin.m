//
//  Coin.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/16.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Coin.h"
#import "CommonAnimation.h"
#import "GameScene.h"

@interface Coin ()
@property (nonatomic, retain)CCSprite *_coinSprite;
@property (nonatomic, readwrite)BOOL _isStaged;
@end

@implementation Coin

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期設定
        self._isStaged = false;
        
        // アニメーションの最初のコマを読み込む
        self._coinSprite = [CCSprite spriteWithSpriteFrameName:@"coin1.png"];
        [self addChild:self._coinSprite];
    }
    return self;
}

- (void)start {
    [self._coinSprite runAction:[CommonAnimation getFrameRepeatAction:@"coin" frameNum:2]];
}

- (void)stop {
    [self stopAllActions];
}

- (void)stageOn:(CCNode*)page {
    self._isStaged = true;
    if (![self parent]) {
        [page addChild:self];
    }
}

- (CGRect)_getLayerBasedBox {
    return CGRectMake(self.position.x + [self parent].position.x - self._coinSprite.contentSize.width / 2,
                      self.position.y + [self parent].position.y - self._coinSprite.contentSize.height / 2,
                      self._coinSprite.contentSize.width, self._coinSprite.contentSize.height);
}

- (BOOL)takenIfCollided:(CGPoint)point {
    
    // コインがステージ上にない場合はfalse
    if (!self._isStaged) return false;
    
    // 当たり判定チェック
    if (CGRectContainsPoint([self _getLayerBasedBox], point)) {
        self._isStaged = false;
        [self removeFromParentAndCleanup:NO];
        
        HeaderController *header = [GameScene sharedInstance].headerController;
        [header addCoin:1];
        return true;
    }
    return false;
}

- (BOOL)hasTaken {
    return !self._isStaged;
}

@end
