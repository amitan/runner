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

@interface Block ()
@end

@implementation Block

+ (Block*)createBlock:(int)blockId {
    return [[[StandardBlock alloc] initWithBlockId:blockId] autorelease];
}

- (id) initWithBlockId:(int)blockId {
    self = [super init];
    if (self) {
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)start {
}

- (void)stop {
}

- (void)reset {
}

- (float)getWidth {
    return self._sprite.contentSize.width;
}

- (float)getHeight {
    return self._sprite.contentSize.height;
}

- (void)stageOn:(CCNode*)page {
    if (![self parent]) {
        [page addChild:self];
    }
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
