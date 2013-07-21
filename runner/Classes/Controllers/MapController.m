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

- (void)setup {
    self._map = [Map node];
    [PointUtil setTLPosition:self._map x:0 y:0];
    [[GameScene sharedInstance].gameLayer addChild:self._map];

    // 初期ページを追加
    PageController *pageController = [GameScene sharedInstance].pageController;
    [self._map addPage:[pageController getPage:1]];
    [self._map addPage:[pageController getPage:2]];
    [self._map addPage:[pageController getPage:3]];
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

- (BOOL)takeCoinsIfCollided:(CGPoint)point {
    return [self._map takeCoinsIfCollided:point];
}

- (BOOL)attackEnemyIfCollided:(CGPoint)point {
    return [self._map attackEnemyIfCollided:point];
}

- (BOOL)isHit:(CGPoint)point {
    return [self._map isHit:point];
}

- (void)scroll:(float)dx {
    self._map.position = ccp(self._map.position.x - dx, self._map.position.y);
    [[GameScene sharedInstance].headerController addDistance:dx];
    [self._map refillIfNeeded];
}

@end
