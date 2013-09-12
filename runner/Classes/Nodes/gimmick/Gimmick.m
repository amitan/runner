//
//  Gimmick.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/12.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Gimmick.h"


@implementation Gimmick

- (void)dealloc {
    self._sprite = nil;
    [super dealloc];
}

- (void)stageOn:(CCNode*)page {
    if (![self parent]) {
        [page addChild:self];
    }
}

- (void)stageOff {
    [self removeFromParentAndCleanup:NO];
}

- (CGRect)getLayerBasedBox {
    return CGRectMake(self.position.x + [self parent].position.x - [self getWidth] / 2,
                      self.position.y + [self parent].position.y - [self getHeight] / 2,
                      [self getWidth], [self getHeight]);
}

- (CGRect)getLayerBasedBox:(CCSprite*)sprite {
    return CGRectMake(self.position.x + [self parent].position.x + sprite.position.x - sprite.contentSize.width / 2,
                      self.position.y + [self parent].position.y + sprite.position.y - sprite.contentSize.height / 2,
                      sprite.contentSize.width, sprite.contentSize.height);
}

- (CGPoint)getLayerBasedPosition {
    return ccp(self.position.x + [self parent].position.x,
               self.position.y + [self parent].position.y);
}

- (float)getWidth {
    return self._sprite.contentSize.width;
}

- (float)getHeight {
    return self._sprite.contentSize.height;
}

- (void)start {
}

- (void)stop {
}

- (void)reset {
}

@end
