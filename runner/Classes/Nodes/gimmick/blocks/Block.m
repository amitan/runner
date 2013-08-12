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
#import "StandardBlock.h"
#import "LeftReverseBlock.h"
#import "RightReverseBlock.h"
#import "HatenaBlock.h"

@interface Block ()
@end

@implementation Block

+ (Block*)createBlock:(int)blockId {
    return [Block createBlock:blockId x:0 y:0];
}

+ (Block*)createBlock:(int)blockId x:(float)x y:(float)y {
    Block *block;
    switch (blockId) {
        case 301:
        case 303:
            block = [[[LeftReverseBlock alloc] initWithBlockId:blockId] autorelease];
            break;
        case 302:
        case 304:
            block = [[[RightReverseBlock alloc] initWithBlockId:blockId] autorelease];
            break;
        case 401:
            block = [[[HatenaBlock alloc] initWithBlockId:blockId] autorelease];
            break;
        default:
            block = [[[StandardBlock alloc] initWithBlockId:blockId] autorelease];
    }
    block.position = [PointUtil getPosition:x y:y];
    return block;
}

- (id)initWithBlockId:(int)blockId {
    self = [super init];
	if (self) {
        self._sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"block%d.png", blockId]];
        [self addChild:self._sprite];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (BOOL)isHit:(CGPoint)point {
    if (CGRectContainsPoint([self getLayerBasedBox], point)) {
        return true;
    }
    return false;
}

- (BOOL)isHitByRect:(CGRect)rect {
    if (CGRectIntersectsRect([self getLayerBasedBox], rect)) {
        return true;
    }
    return false;
}

- (float)getLandPoint {
    return self.position.y + [self parent].position.y + [[self parent] parent].position.y + [self getHeight] / 2;
}

- (float)getBottomPoint {
    return self.position.y + [self parent].position.y + [[self parent] parent].position.y - [self getHeight] / 2;
}

- (float)getLeftPoint {
    return self.position.x + [self parent].position.x + [[self parent] parent].position.x - [self getWidth] / 2;
}

- (float)getRightPoint {
    return self.position.x + [self parent].position.x + [[self parent] parent].position.x + [self getWidth] / 2;
}

- (BOOL)isLeftReverse {
    return false;
}

- (BOOL)isRightReverse {
    return false;
}

@end
