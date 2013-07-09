//
//  MapController.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "MapController.h"
#import "GameScene.h"
#import "ScaleUtil.h"
#import "Block.h"

@interface MapController ()
@property (nonatomic, retain)Block *_block;
@property (nonatomic, retain)Block *_block2;
@end

@implementation MapController

- (id)init {
    self = [super init];
	if (self) {
        
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)onEnter {
    [super onEnter];

    // TODO:: マップの実装
    self._block = [Block node];
    [ScaleUtil setPosition:self._block x:0 y:BASE_HEIGHT offsetX:[self._block getWidth] / 2 offsetY:-[self._block getHeight] / 2];
    [[GameScene sharedInstance].gameLayer addChild:self._block];

    self._block2 = [Block node];
    [ScaleUtil setPosition:self._block2 x:0 y:BASE_HEIGHT offsetX:[self._block2 getWidth] offsetY:-[self._block getHeight]];
    [[GameScene sharedInstance].gameLayer addChild:self._block2];

}

- (Block*)getCollidedBlock:(CGPoint)point {

    // 境界線は含むことにする
    if (CGRectContainsPoint([self._block getBox], ccpAdd(point, ccp(1, 1)))) {
        return self._block;
    } else if (CGRectContainsPoint([self._block getBox], ccpAdd(point, ccp(-1, -1)))) {
        return self._block;
    } else if (CGRectContainsPoint([self._block2 getBox], ccpAdd(point, ccp(1, 1)))) {
        return self._block2;
    } else if (CGRectContainsPoint([self._block2 getBox], ccpAdd(point, ccp(-1, -1)))) {
        return self._block2;
    }
    return NULL;
}

- (void)scroll:(float)dx {
    self._block2.position = ccp(self._block2.position.x - dx, self._block2.position.y);
}

@end
