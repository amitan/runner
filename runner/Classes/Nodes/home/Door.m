//
//  Door.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/13.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Door.h"
#import "PointUtil.h"
#import "HomeScene.h"
#import "GameUtil.h"
#import "GameScene.h"

@implementation Door

- (id)init {
    self = [super init];
	if (self) {
        self._sprite = [CCSprite spriteWithSpriteFrameName:@"door.png"];
        self._sprite.position = ccp(self._sprite.contentSize.width / 2, - self._sprite.contentSize.height / 2);
        [self addChild:self._sprite];
        [self addClickListner:self selector:@selector(clickButton:)];
    }
    return self;
}

- (void)clickButton:(id)sender {
    [GameUtil replaceScene:[GameScene createInstance:1 areaId:101 stageId:1 isRandom:true]];
}

@end
