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
#import "StandardCoin.h"
#import "BigCoin.h"
#import "DroppingCoin.h"
#import "SwitchCoin.h"

@interface Coin ()
@property (nonatomic, retain)CCSprite *_coinSprite;
@end

@implementation Coin

+ (Coin*)createCoin:(int)coinId {
    switch (coinId) {
        case 1:
            return [[[StandardCoin alloc] initWithCoinId:coinId] autorelease];
        case 2:
            return [[[BigCoin alloc] initWithCoinId:coinId] autorelease];
        case 3:
            return [[[DroppingCoin alloc] initWithCoinId:coinId] autorelease];
        case 4:
            return [[[SwitchCoin alloc] initWithCoinId:coinId] autorelease];
        default:
            return [[[StandardCoin alloc] initWithCoinId:coinId] autorelease];
    }
}

- (id)initWithCoinId:(int)coinId {
    self = [super init];
    if (self) {
        
        // 初期設定
        self._isStaged = false;
        self._coinId = coinId;
        
        // アニメーションの最初のコマを読み込む
        self._coinSprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"coin%d_1.png", self._coinId]];
        [self addChild:self._coinSprite];
    }
    return self;
}

- (void)start {
    [self._coinSprite runAction:[CommonAnimation getFrameRepeatAction:[NSString stringWithFormat:@"coin%d_", self._coinId] frameNum:2]];
}

- (void)stop {
    [self._coinSprite stopAllActions];
}

- (void)reset {
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

- (BOOL)takenIfCollided:(CGRect)rect {
    
    // コインがステージ上にない場合はfalse
    if (!self._isStaged) return false;
    
    // 当たり判定チェック
    if (CGRectIntersectsRect([self _getLayerBasedBox], rect)) {
        self._isStaged = false;
        [self removeFromParentAndCleanup:NO];
        
        HudController *header = [GameScene sharedInstance].hudController;
        [header addCoin:1];
        return true;
    }
    return false;
}

- (BOOL)hasTaken {
    return !self._isStaged;
}

- (void)drop {
}

- (void)appear {
}

- (float)getWidth {
    return self._coinSprite.contentSize.width;
}

- (float)getHeight {
    return self._coinSprite.contentSize.height;
}

@end
