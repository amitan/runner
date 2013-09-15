//
//  Item.m
//  runner
//
//  Created by Ayumi Otomo on 2013/09/14.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Item.h"
#import "PointUtil.h"

@interface Item ()
@property (nonatomic, retain)CCSprite *_item;
@end

@implementation Item

+ (Item*)createItem:(float)x y:(float)y {
    Item *item = [[[Item alloc] init] autorelease];
    item.position = [PointUtil getPosition:x y:y];
    return item;
}

- (id)init {
    self = [super init];
    if (self) {

        // 初期設定
        self._isStaged = false;

        // ベース画像を読み込む
        self._sprite = [CCSprite spriteWithSpriteFrameName:@"item_base.png"];
        [self addChild:self._sprite z:10];

        // アイテムを設定
        [self addItem];
    }
    return self;
}

- (void)stageOn:(CCNode*)page {
    [super stageOn:page];
    self._isStaged = true;
}

- (void)addItem {
    self._item = [CCSprite spriteWithSpriteFrameName:@"item_magnet.png"];
    [self addChild:self._item z:0];    
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
