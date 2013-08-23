//
//  Rail.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/12.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Rail.h"
#import "PointUtil.h"
#import "GameUtil.h"

@interface Rail ()
@property (nonatomic, retain)CCSprite *_ropeSprite;
@property (nonatomic, readwrite)float _totalDx;
@end

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
        self.isSwitched = false;
        
        // 画像を読み込む
        self._sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"rail%d_1.png", self._railId]];
        self._sprite.rotation = rotation;
        
        self._ropeSprite = [CCSprite spriteWithSpriteFrameName:@"rope.png"];
        self._ropeSprite.position = ccp(self._ropeSprite.contentSize.width / 2 - [self _getRailWidth] / 2,
                                        -self._ropeSprite.contentSize.height / 2 + [self _getCenterYByDh:[self getWidth] / 2]);

        [self addChild:self._ropeSprite];
        [self addChild:self._sprite];
    }
    return self;
}

- (void)dealloc {
    self._ropeSprite = nil;
    [super dealloc];
}

- (BOOL)isHit:(CGRect)rect {
    
    if (CGRectIntersectsRect([self getLayerBasedBox:self._ropeSprite], rect)) {
        self.isSwitched = true;
        return true;
    }
    return false;
}

- (CGPoint)_getWorldPoint {
    return ccpAdd(ccpAdd(self.position, [self parent].position), [[self parent] parent].position);
}

- (float)_getCenterYByDx:(float)dx {
    return dx * tan(M_PI/180.0f * self._sprite.rotation);
}

- (float)_getCenterYByDh:(float)dh {
    return dh * sin(M_PI/180.0f * self._sprite.rotation);
}

- (float)_getRailWidth {
    return [self getWidth] / 2 * cos(M_PI/180.0f * self._sprite.rotation) * 2;
}

- (BOOL)isRopeMovable {
    return (self._totalDx < [self _getRailWidth] - 3 * self._ropeSprite.contentSize.width / 2);
}

- (CGPoint)moveRope:(float)dx {
    if (!self.isSwitched) return ccp(0, 0);
    self._totalDx += dx;
    float dy = -[self _getCenterYByDx:dx];
    self._ropeSprite.position = ccpAdd(self._ropeSprite.position, ccp(dx, dy));
    return ccp(dx, dy);
}

- (void)reset {
    [super reset];
    self._ropeSprite.position = ccp(self._ropeSprite.contentSize.width / 2 - [self _getRailWidth] / 2,
                                    -self._ropeSprite.contentSize.height / 2 + [self _getCenterYByDh:[self getWidth] / 2]);
    self.isSwitched = false;
    self._totalDx = 0;
}
@end
