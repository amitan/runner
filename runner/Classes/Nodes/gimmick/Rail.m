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

+ (Rail*)createRail:(int)railId rotation:(float)rotation {
    return [Rail createRail:railId rotation:rotation x:0 y:0];
}

+ (Rail*)createRail:(int)railId rotation:(float)rotation x:(float)x y:(float)y {
    Rail *rail = [[[Rail alloc] initWithRailId:railId rotation:rotation] autorelease];
    rail.position = [PointUtil getPosition:x y:y];
    return rail;
}

- (id)initWithRailId:(int)railId rotation:(float)rotation {
    self = [super init];
    if (self) {
        
        // 初期設定
        self._railId = railId;
        
        // 画像を読み込む
        self._sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"rail%d_1.png", self._railId]];
        self._sprite.rotation = rotation;
        [self addChild:self._sprite];
    }
    return self;
}

- (BOOL)isHit:(CGPoint)point {
    
    float x = point.x + [[self parent] parent].position.x;
    float y = point.y + [[self parent] parent].position.y;
    CGPoint worldPoint = [self _getWorldPoint];
    if (worldPoint.x - [self getWidth] / 2 > x || worldPoint.x + [self getWidth] / 2 < x) {
        return false;
    }
    float railY = [self _getCenterY:x];
    if (railY - [self getHeight] <= y && railY + [self getHeight] / 2 >= y) {
        return true;
    }
    return false;
}

- (float)getLandPoint:(float)x {
    return [self _getCenterY:x];
}

- (CGPoint)_getWorldPoint {
    return ccpAdd(ccpAdd(self.position, [self parent].position), [[self parent] parent].position);
}

- (float)_getCenterY:(float)x {
    CGPoint worldPoint = [self _getWorldPoint];
    return worldPoint.y + (worldPoint.x - x) * tan(M_PI/180.0f * self._sprite.rotation);
}

@end
