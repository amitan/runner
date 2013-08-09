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

    }
    return self;
}
@end
