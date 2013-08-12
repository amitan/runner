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
#import "PointUtil.h"

@implementation Coin

+ (Coin*)createCoin:(int)coinId {
    return [Coin createCoin:coinId groupId:0];
}

+ (Coin*)createCoin:(int)coinId groupId:(int)groupId {
    return [Coin createCoin:coinId groupId:groupId x:0 y:0];
}

+ (Coin*)createCoin:(int)coinId x:(float)x y:(float)y {
    return [Coin createCoin:coinId groupId:0 x:x y:y];
}

+ (Coin*)createCoin:(int)coinId groupId:(int)groupId x:(float)x y:(float)y {
    Coin *coin;
    switch (coinId) {
        case 1:
            coin = [[[StandardCoin alloc] initWithCoinId:coinId groupId:groupId] autorelease];
            break;
        case 2:
            coin = [[[BigCoin alloc] initWithCoinId:coinId groupId:groupId] autorelease];
            break;
        case 3:
            coin = [[[DroppingCoin alloc] initWithCoinId:coinId groupId:groupId] autorelease];
            break;
        case 4:
            coin = [[[SwitchCoin alloc] initWithCoinId:coinId groupId:groupId] autorelease];
            break;
        default:
            coin = [[[StandardCoin alloc] initWithCoinId:coinId groupId:groupId] autorelease];
    }
    coin.position = [PointUtil getPosition:x y:y];
    return coin;
}

- (id)initWithCoinId:(int)coinId groupId:(int)groupId {
    self = [super init];
    if (self) {
        
        // 初期設定
        self._isStaged = false;
        self._coinId = coinId;
        self._groupId = groupId;
        self._value = 1;
        
        // アニメーションの最初のコマを読み込む
        self._sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"coin%d_1.png", self._coinId]];
        [self addChild:self._sprite];
    }
    return self;
}

- (void)start {
    [super start];
    [self._sprite runAction:[CommonAnimation getFrameRepeatAction:[NSString stringWithFormat:@"coin%d_", self._coinId] frameNum:2]];
}

- (void)stop {
    [super stop];
    [self._sprite stopAllActions];
}

- (void)stageOn:(CCNode*)page {
    [super stageOn:page];
    self._isStaged = true;
}

- (BOOL)takenIfCollided:(CGRect)rect {
    
    // コインがステージ上にない場合はfalse
    if (!self._isStaged) return false;
    
    // 当たり判定チェック
    if (CGRectIntersectsRect([self getLayerBasedBox], rect)) {
        self._isStaged = false;
        [self removeFromParentAndCleanup:NO];
        
        HudController *header = [GameScene sharedInstance].hudController;
        [header addCoin:self._value];
        return true;
    }
    return false;
}

- (BOOL)hasTaken {
    return !self._isStaged;
}

- (void)drop {
}

- (void)appear:(int)groupId {
}

@end