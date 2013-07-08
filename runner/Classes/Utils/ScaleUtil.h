//
//  ScaleUtil.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ScaleUtil : NSObject

extern const float BASE_WIDTH;
extern const float BASE_HEIGHT;

// 640 x 960を基準としたスケール値を取得する
+ (float)getScale;

// スケール値を考慮した座標点を取得する
+ (float)getPoint:(float)point;

// スケール値を考慮した座標を設定する
+ (void)setTLPosition:(CCSprite*)sprite x:(float)x y:(float)y; // 画像左上基準
+ (void)setPosition:(CCNode*)node x:(float)x y:(float)y offsetX:(float)offsetX offsetY:(float)offsetY;

@end
