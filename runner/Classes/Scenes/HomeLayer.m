//
//  HomeLayer.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/13.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "HomeLayer.h"
#import "PointUtil.h"
#import "GameUtil.h"
#import "CCSpriteButton.h"
#import "GameScene.h"

@implementation HomeLayer

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	HomeLayer *layer = [HomeLayer node];
    layer.scale = [PointUtil getScale];
	[scene addChild:layer];
	return scene;
}

- (id)init {
    self = [super init];
	if (self) {

        // 背景の追加
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        NSString *bgName = [GameUtil getBgSpriteName:@"home_bg" ext:@"png"];
        CCSprite *background = [CCSprite spriteWithFile:bgName];
        background.position = ccp(winSize.width / 2, winSize.height / 2);
        [self addChild:background];
        
        // ボタンの追加
        CCSpriteButton *doorButton = [CCSpriteButton spriteWithSpriteFrameName:@"door.png"];
        [PointUtil setTLPosition:doorButton x:450 y:184];
        [doorButton addClickListner:self selector:@selector(clickDoorButton:)];
        [self addChild:doorButton];

    }
    return self;
}

- (void)clickDoorButton:(id)sender {
    [GameUtil replaceScene:[GameScene createInstance:1 areaId:101 stageId:1 isRandom:true]];
}

@end
