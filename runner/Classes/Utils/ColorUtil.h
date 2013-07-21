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

// デフォルトの文字色を返す
+ (ccColor3B)getDefaultFontColor;

// タッチ時の文字色を返す
+ (ccColor3B)getTouchedFontColor;

// エフェクトの文字色を返す
+ (ccColor3B)getEffectOrangeFontColor;

@end
