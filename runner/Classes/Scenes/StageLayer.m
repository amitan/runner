//
//  StageLayer.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/13.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "StageLayer.h"
#import "PointUtil.h"
#import "GameUtil.h"

@interface StageLayer ()
@property (nonatomic, readwrite)int _worldId;
@property (nonatomic, readwrite)int _areaId;
@end

@implementation StageLayer

const int INIT_WORLD_ID = 1;
const int INIT_AREA_ID = 101;

+(CCScene *) scene
{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int currentWorldId = [userDefaults integerForKey:@"currentWorldId"];
    if (currentWorldId == 0) {
        currentWorldId = INIT_WORLD_ID;
    }
    int currentAreaId = [userDefaults integerForKey:@"currentAreaId"];
    if (currentAreaId == 0) {
        currentAreaId = INIT_AREA_ID;
    }
    return [self scene:currentWorldId areaId:currentAreaId];
}

+(CCScene *) scene:(int)worldId areaId:(int)areaId
{
    // ワールド・エリアを保存
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setInteger:worldId forKey:@"currentWorldId"];
    [userDefaults setInteger:areaId forKey:@"currentAreaId"];
    
    // シーンを表示
	CCScene *scene = [CCScene node];
	StageLayer *layer = [[[self alloc] initWithArea:worldId areaId:areaId] autorelease];
    layer.scale = [PointUtil getScale];
	[scene addChild:layer];
	return scene;
}

- (id)initWithArea:(int)worldId areaId:(int)areaId {
    self = [super init];
    if (self) {
        
        // 初期値を設定
        self._worldId = worldId;
        self._areaId = areaId;
        
        // 背景の追加
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        NSString *bgName = [GameUtil getBgSpriteName:@"stage_bg" ext:@"png"];
        CCSprite *background = [CCSprite spriteWithFile:bgName];
        background.position = ccp(winSize.width / 2, winSize.height / 2);
        [self addChild:background];

    }
    return self;
}
@end
