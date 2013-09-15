//
//  PointUtil.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "PointUtil.h"

@implementation PointUtil

const float BASE_WIDTH = 960.0f;
const float BASE_HEIGHT = 640.0f;

+ (float)getScale {
    float scale = [PointUtil getScaleWithoutRetina];
    return scale * [[UIScreen mainScreen] scale];
}

+ (float)getScaleWithoutRetina {
    CGSize size = [self getScreenSize];
    float scaleX = size.width / BASE_WIDTH;
    float scaleY = size.height / BASE_HEIGHT;
    return (scaleX < scaleY) ? scaleX : scaleY;
}

+ (CGSize)getScreenSize {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    float width = winSize.width;
    float height = winSize.height;
    if (width < height) {
        width = winSize.height;
        height = winSize.width;
    }
    return CGSizeMake(width, height);
}

+ (float)getPoint:(float)point {
    return point / [[UIScreen mainScreen] scale];
}

+ (CGPoint)getPosition:(float)x y:(float)y {
    return ccp([self getPoint:x], [self getPoint:y]);
}

+ (void)setCenterPosition:(CCNode*)sprite x:(float)x y:(float)y {
    [self setPosition:sprite x:x y:y offsetX:0 offsetY:0];
}

+ (void)setTLPosition:(CCNode*)sprite x:(float)x y:(float)y {
    [self setPosition:sprite x:x y:y offsetX:sprite.contentSize.width / 2 offsetY:sprite.contentSize.height / 2];
}

+ (void)setPosition:(CCNode *)node x:(float)x y:(float)y offsetX:(float)offsetX offsetY:(float)offsetY {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    float dx = winSize.width / 2 - [PointUtil getPoint:(BASE_WIDTH / 2 - x)] + offsetX;
    float dy = winSize.height / 2 - [PointUtil getPoint:(y - BASE_HEIGHT / 2)] - offsetY;
    node.position = ccp(dx, dy);
    
}

@end
