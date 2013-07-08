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

@interface MapController ()
@property (nonatomic, retain)CCSprite *_sprite; // TODO:: 仮実装

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
    self._sprite = [CCSprite spriteWithSpriteFrameName:@"land1.png"];
    [ScaleUtil setTLPosition:self._sprite x:0 y:BASE_HEIGHT - self._sprite.contentSize.height];
    [[GameScene sharedInstance].mapLayer addChild:self._sprite];
}

@end
