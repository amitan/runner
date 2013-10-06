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

@interface MapController ()
@property (nonatomic, readwrite)CGPoint _tempPosition;
@property (nonatomic, readwrite)BOOL _isFlyingUp, _isFlyingDown;
@end

@implementation MapController

- (id)init {
    self = [super init];
	if (self) {
        self._isFlyingUp = false;
        self._isFlyingDown = false;
    }
    return self;
}

- (void)dealloc {
    self.landMap = nil;
    [super dealloc];
}

- (void)setup:(int)stageId isRandom:(BOOL)isRandom {
    self.landMap = [LandMap createMap:stageId isRandom:isRandom];
    [PointUtil setTLPosition:self.landMap x:0 y:0];
    [[GameScene sharedInstance].gameLayer addChild:self.landMap];
    
    // 空マップがあるのはエンドレスステージのみ
    if (isRandom) {
        self.skyMap = [SkyMap createMap:stageId];
        [PointUtil setTLPosition:self.skyMap x:0 y:-BASE_HEIGHT];
        [[GameScene sharedInstance].gameLayer addChild:self.skyMap];
    }
}

- (void)start {
    [self.landMap start];
}

- (void)stop {
    [self.landMap stop];
}

- (void)suspend {
    [self.landMap suspend];
}

- (void)resume {
    [self.landMap resume];
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
    [[GameScene sharedInstance].hudController addLandDistance:dx];
    [self.landMap refillIfNeeded];
}

////////////////////////////////////////////////////////////////////////////////////////
// 空マップ
////////////////////////////////////////////////////////////////////////////////////////
- (void)skyScroll:(float)dx {
    if (!self.skyMap) return;
    self.skyMap.position = ccp(self.skyMap.position.x - dx, self.skyMap.position.y);
    [[GameScene sharedInstance].hudController addSkyDistance:dx];
    [self.skyMap refillIfNeeded];
}

- (void)flyUp {
    if (!self.skyMap) return;
    self._tempPosition = self.landMap.position;
    self._isFlyingUp = true;
    [self.skyMap start];
    [self.landMap restructure];
    [self scheduleUpdate];
}

- (void)flyDown {
    if (!self.skyMap) return;
    self._isFlyingDown = true;
    [self scheduleUpdate];
}

- (void)update:(ccTime)dt {
    if (self._isFlyingUp) {
        if (self.landMap.position.y < self._tempPosition.y - [PointUtil getPoint:BASE_HEIGHT]) {
            self._isFlyingUp = false;
            [self.landMap stop];
            [[GameScene sharedInstance].playerController fly];
            [self unscheduleUpdate];
        } else {
            float dx = [PointUtil getPoint:10];
            float dy = [PointUtil getPoint:10];
            self.landMap.position = ccpAdd(self.landMap.position, ccp(-dx, -dy));
            self.skyMap.position = ccpAdd(self.skyMap.position, ccp(-dx, -dy));
            [[GameScene sharedInstance].hudController addDistance:dx];
        }
    } else if (self._isFlyingDown) {
        if (self.landMap.position.y >= self._tempPosition.y) {
            self._isFlyingDown = false;
            self.landMap.position = ccp(self.landMap.position.x, self._tempPosition.y);
            [self.skyMap restructure];
            [self unscheduleUpdate];
        } else {
            float dy = [PointUtil getPoint:10];
            self.landMap.position = ccpAdd(self.landMap.position, ccp(0, dy));
            self.skyMap.position = ccpAdd(self.skyMap.position, ccp(0, dy));
        }
        
    } else {
        [self unscheduleUpdate];
    }
}

@end
