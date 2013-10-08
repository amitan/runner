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
#import "SwitchCoin.h"
#import "PointUtil.h"

@interface Coin ()
@property (nonatomic, readwrite)CGPoint _initPosition;
@property (nonatomic, readwrite)float _moveDistance;
@end

@implementation Coin
const int MAGNET_FACTOR = 12;

+ (Coin*)createCoin:(int)coinId {
    return [Coin createCoin:coinId groupId:0];
}

+ (Coin*)createCoin:(int)coinId groupId:(int)groupId {
    return [Coin createCoin:coinId groupId:groupId x:0 y:0];
}

+ (Coin*)createCoin:(int)coinId x:(float)x y:(float)y {
    return [Coin createCoin:coinId groupId:0 x:x y:y];
}

+ (NSArray*)createCoins:(int)coinId bx:(float)bx by:(float)by num:(int)num {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:num];
    for (int i = 0; i < num; i++) {
        
    }
    return array;
}

+ (Coin*)createCoin:(int)coinId bx:(float)bx by:(float)by {
    float x = (bx - 1) * 50;
    float y = by * 50 - 640;
    return [Coin createCoin:coinId groupId:0 x:x y:y];
}

+ (Coin*)createCoin:(int)coinId groupId:(int)groupId x:(float)x y:(float)y {
    Coin *coin;
    switch (coinId) {
        case 1:
            coin = [[[StandardCoin alloc] initWithCoinId:coinId groupId:groupId] autorelease];
            break;
        case 4:
            coin = [[[SwitchCoin alloc] initWithCoinId:coinId groupId:groupId] autorelease];
            break;
        default:
            coin = [[[StandardCoin alloc] initWithCoinId:coinId groupId:groupId] autorelease];
    }
    coin.position = ccpAdd([PointUtil getPosition:x y:y], ccp([coin getWidth] / 2, -[coin getHeight] / 2));
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
        self._moveDistance = [PointUtil getPoint:15];
        
        // アニメーションの最初のコマを読み込む
        self._sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"coin%d_1.png", self._coinId]];
        [self addChild:self._sprite];
    }
    return self;
}

- (void)stageOn:(CCNode*)page {
    [super stageOn:page];
    self._initPosition = self.position;
    self._isStaged = true;
}

- (BOOL)takenIfCollided:(CGRect)rect magnet:(BOOL)isMagnet {
    
    // コインがステージ上にない場合はfalse
    if (!self._isStaged) return false;
    
    CGRect playerRect = rect;
    if (isMagnet) {
        playerRect = CGRectMake(rect.origin.x - rect.size.width * MAGNET_FACTOR / 2, rect.origin.y - rect.size.height * MAGNET_FACTOR / 2,
                                MAGNET_FACTOR * rect.size.width, MAGNET_FACTOR * rect.size.height);
    }
    
    // 当たり判定チェック
    if (CGRectIntersectsRect([self getLayerBasedBox], playerRect)) {
        isMagnet ? [self _moveCoin:rect] : [self _takeCoin];
        return true;
    }
    return false;
}

- (BOOL)takenIfCollided:(CGPoint)point radius:(float)radius {
    
    // コインがステージ上にない場合はfalse
    if (!self._isStaged) return false;
    
    // 当たり判定チェック
    CGRect rect = [self getLayerBasedBox];
    float dx = rect.origin.x - point.x;
    float dy = rect.origin.y - point.y;
    if (pow(dx, 2) + pow(dy, 2) <= pow(radius, 2)) {
        [self _takeCoin];
        return true;
    }
    return false;
}

- (void)_moveCoin:(CGRect)rect {
    CGPoint diff = ccpSub([self getLayerBasedPosition], ccp(CGRectGetMidX(rect), CGRectGetMidY(rect)));
    float dx = diff.x >= 0 ? - self._moveDistance : self._moveDistance;
    float dy = diff.y >= 0 ? - self._moveDistance : self._moveDistance;
    self.position = ccpAdd(self.position, ccp(dx, dy));
    
    if (CGRectIntersectsRect([self getLayerBasedBox], rect)) {
        [self _takeCoin];
        self.position = self._initPosition;
    }
}

- (void)reset {
    [super reset];
    self.position = self._initPosition;
}

- (void)_takeCoin {
    self._isStaged = false;
    [self removeFromParentAndCleanup:NO];
    HudController *header = [GameScene sharedInstance].hudController;
    [header addCoin:self._value];
}

- (BOOL)hasTaken {
    return !self._isStaged;
}

- (void)drop {
}

- (void)appear:(int)groupId {
}

@end
