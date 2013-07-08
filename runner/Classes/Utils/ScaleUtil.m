//
//  ScaleUtil.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "ScaleUtil.h"

@implementation ScaleUtil

const float BASE_WIDTH = 640.0f;
const float BASE_HEIGHT = 960.0f;

+ (float)getScale {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    float width = winSize.width;
    float height = winSize.height;
    if (width > height) {
        width = winSize.height;
        height = winSize.width;
    }
    float scaleX = width / BASE_WIDTH;
    float scaleY = height / BASE_HEIGHT;
    float scale = (scaleX < scaleY) ? scaleX : scaleY;
    return scale * [[UIScreen mainScreen] scale];
}

+ (float)getPoint:(float)point {
    return point / [[UIScreen mainScreen] scale];
}

+ (void)setTLPosition:(CCSprite*)sprite x:(float)x y:(float)y {
    [self setPosition:sprite x:x y:y offsetX:sprite.contentSize.width / 2 offsetY:sprite.contentSize.height / 2];
}

+ (void)setPosition:(CCNode *)node x:(float)x y:(float)y offsetX:(float)offsetX offsetY:(float)offsetY {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    float dx = winSize.width / 2 - [ScaleUtil getPoint:(BASE_WIDTH / 2 - x)] + offsetX;
    float dy = winSize.height / 2 - [ScaleUtil getPoint:(y - BASE_HEIGHT / 2)] - offsetY;
    node.position = ccp(dx, dy);
    
}

@end
