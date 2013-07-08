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

@end
