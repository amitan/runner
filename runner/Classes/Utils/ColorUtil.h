//
//  ColorUtil.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ColorUtil : NSObject

// デフォルトの色を返す
+ (ccColor3B)getDefaultColor;

// タッチ時の色を返す
+ (ccColor3B)getTouchedColor;

// エフェクトの色を返す
+ (ccColor3B)getEffectOrangeColor;

// 警告時の色を返す
+ (ccColor3B)getWarningRedColor;

@end
