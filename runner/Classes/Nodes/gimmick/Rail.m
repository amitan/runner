//
//  Rail.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/12.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Rail.h"
#import "PointUtil.h"

@implementation Rail

+ (Rail*)createRail:(int)railId {
    return [Rail createRail:railId x:0 y:0];
}

+ (Rail*)createRail:(int)railId x:(float)x y:(float)y {
    Rail *rail = [[[Rail alloc] initWithRailId:railId] autorelease];
    rail.position = [PointUtil getPosition:x y:y];
    return rail;
}

- (id)initWithRailId:(int)railId {
    self = [super init];
    if (self) {
        
        // 初期設定
        self._railId = railId;
        
        // 画像を読み込む
        self._sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"rail%d_1.png", self._railId]];
        [self addChild:self._sprite];
    }
    return self;
}

@end
