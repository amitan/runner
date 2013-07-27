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
@property (nonatomic, retain)Map *_map;
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

- (void)setup:(int)stageId isRandom:(BOOL)isRandom {
    self._map = [Map createMap:stageId isRandom:isRandom];
    [PointUtil setTLPosition:self._map x:0 y:0];
    [[GameScene sharedInstance].gameLayer addChild:self._map];
}

- (void)start {
    [self._map start];
}

- (void)stop {
    [self._map stop];
}

- (Block*)getHitBlock:(CGPoint)point {

    // 境界線は含む
    Block *block = [self._map getHitBlock:ccpAdd(point, ccp(1, 1))];
    if (block) return block;

    block = [self._map getHitBlock:ccpAdd(point, ccp(-1, -1))];
    return block;
}

- (BOOL)takeCoinsIfCollided:(CGRect)rect {
    return [self._map takeCoinsIfCollided:rect];
}

- (BOOL)attackEnemyIfCollided:(CGPoint)point {
    return [self._map attackEnemyIfCollided:point];
}

- (BOOL)isHit:(CGPoint)point {
    return [self._map isHit:point];
}

- (BOOL)checkSpeedUp:(CGPoint)point {
    return [self._map checkSpeedUp:point];
}

- (void)scroll:(float)dx {
    self._map.position = ccp(self._map.position.x - dx, self._map.position.y);
    [[GameScene sharedInstance].hudController addDistance:dx];
    [self._map refillIfNeeded];
}

@end
