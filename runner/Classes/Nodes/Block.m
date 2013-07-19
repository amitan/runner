//
//  Block.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/09.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Block.h"
#import "PointUtil.h"
#import "GameScene.h"

@interface Block ()
@property (nonatomic, retain)CCSprite *_sprite;
@end

@implementation Block

+ (Block*)createBlock:(int)blockId {
    return [[[self alloc] initWithBlockId:blockId] autorelease];
}

- (id)initWithBlockId:(int)blockId {
    self = [super init];
	if (self) {

        // 画像を追加
        self._sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"block%d.png", blockId]];
        [self addChild:self._sprite];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (float)getWidth {
    return self._sprite.contentSize.width;
}

- (float)getHeight {
    return self._sprite.contentSize.height;
}

- (BOOL)isHit:(CGPoint)point {
    if (CGRectContainsPoint([self _getLayerBasedBox], point)) {
        return true;
    }
    return false;
}

- (CGRect)_getLayerBasedBox {
    return CGRectMake(self.position.x + [self parent].position.x - [self getWidth] / 2,
                      self.position.y + [self parent].position.y - [self getHeight] / 2,
                      [self getWidth], [self getHeight]);
}

- (float)getLandPoint {
    return self.position.y + [self parent].position.y + [[self parent] parent].position.y + [self getHeight] / 2;
}

- (float)getLeftPoint {
    return self.position.x + [self parent].position.x + [[self parent] parent].position.x - [self getWidth] / 2;
}

@end
