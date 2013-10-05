//
//  CommonAnimation.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/09.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CommonAnimation : NSObject

// フレームアニメーションを取得
+ (CCAnimation*)getFrameAnimation:(NSString*)name frameNum:(int)num;
+ (CCAnimation*)getFrameAnimation:(NSString*)name frameNum:(int)num duration:(float)duration;
+ (CCAnimation*)getSingleFrameAnimation:(NSString*)name frame:(int)frameNo duration:(float)duration;
+ (id)getFrameRepeatAction:(NSString*)name frameNum:(int)num;
+ (id)getFrameRepeatAction:(NSString*)name frameNum:(int)num duration:(float)duration;
+ (id)getFrameAction:(NSString*)name frameNum:(int)num duration:(float)duration count:(int)count func:(id)func;
+ (id)getSingleFrameAction:(NSString*)name;


// 点滅アニメーションを取得
+ (id)getBlinkAction;

// エフェクト出現アニメーションを取得
+ (id)getEffectAppearAction:(float)dx;

// 通知アニメーションを取得
+ (id)getNotificationAction;

+ (id)getTopDownAction;
+ (id)getShakeAction;

@end
