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

@interface MapController ()
@property (nonatomic, readwrite)CGPoint _tempPosition;
@property (nonatomic, readwrite)BOOL _isFlying;
@end

@implementation MapController

- (id)init {
    self = [super init];
	if (self) {
        self._isFlying = false;
    }
    return self;
}

- (void)dealloc {
    self.landMap = nil;
    [super dealloc];
}

- (void)setup:(int)stageId {
    self.landMap = [LandMap createMap:stageId];
    [PointUtil setTLPosition:self.landMap x:0 y:0];
    [[GameScene sharedInstance].gameLayer addChild:self.landMap];
}

- (void)start {
    [self.landMap start];
}

- (void)stop {
    [self.landMap stop];
}

- (Block*)getHitBlock:(CGPoint)point {

    // 境界線は含む
    Block *block = [self.landMap getHitBlock:ccpAdd(point, ccp(1, 1))];
    if (block) return block;

    block = [self.landMap getHitBlock:ccpAdd(point, ccp(-1, -1))];
    return block;
}

- (void)scroll:(float)dx {
    self.landMap.position = ccp(self.landMap.position.x - dx, self.landMap.position.y);
    [[GameScene sharedInstance].hudController addDistance:dx];
    [self.landMap refillIfNeeded];
}

- (void)skyScroll:(float)dx {
    [[GameScene sharedInstance].hudController addDistance:dx];
}

- (void)flyUp {
    self._tempPosition = self.landMap.position;
    self._isFlying = true;
    [self scheduleUpdate];
}

- (void)update:(ccTime)dt {
    if (self._isFlying) {
        if (self.landMap.position.y < self._tempPosition.y - BASE_HEIGHT) {
            self._isFlying = false;
            [[GameScene sharedInstance].playerController fly];
            [self unscheduleUpdate];
        } else {
            float dx = [PointUtil getPoint:10];
            float dy = [PointUtil getPoint:10];
            self.landMap.position = ccp(self.landMap.position.x - dx, self.landMap.position.y - dy);
            [[GameScene sharedInstance].hudController addDistance:dx];
        }
    } else {
        [self unscheduleUpdate];
    }
}

@end
