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
    CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:@"land1.png"];
    [ScaleUtil setTLPosition:sprite x:0 y:BASE_HEIGHT - sprite.contentSize.height];
    [[GameScene sharedInstance].mapLayer addChild:sprite];
}

@end
