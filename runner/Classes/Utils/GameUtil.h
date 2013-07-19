//
//  GameUtil.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameUtil : NSObject

// タッチ優先度
typedef enum {
    BUTTON_PRIORITY = -1,
    POPUP_PRIORITY = -10,
} TOUCH_PRIORITY;

// ファイル名をもとに端末に応じた画像名を返す
+ (NSString*) getBgSpriteName:(NSString *)fileName ext:(NSString *)ext ;

// 4インチの端末かどうか
+ (BOOL)is4inchDevice;

// 指定した画面に遷移する
+ (void)replaceScene:(CCScene*)scene;

@end
