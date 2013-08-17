//
//  MapController.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "MapController.h"
#import "GameScene.h"
#import "PointUtil.h"
#import "Block.h"
#import "Map.h"
#import "Page1.h"
#import "Page2.h"
#import "Page3.h"
#import "Page4.h"

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

- (void)setup:(int)stageId {
    self.map = [Map createMap:stageId];
    [PointUtil setTLPosition:self.map x:0 y:0];
    [[GameScene sharedInstance].gameLayer addChild:self.map];
}

- (void)start {
    [self.map start];
}

- (void)stop {
    [self.map stop];
}

- (Block*)getHitBlock:(CGPoint)point {

    // 境界線は含む
    Block *block = [self.map getHitBlock:ccpAdd(point, ccp(1, 1))];
    if (block) return block;

    block = [self.map getHitBlock:ccpAdd(point, ccp(-1, -1))];
    return block;
}

- (void)scroll:(float)dx {
    self.map.position = ccp(self.map.position.x - dx, self.map.position.y);
    [[GameScene sharedInstance].hudController addDistance:dx];
    [self.map refillIfNeeded];
}

@end
