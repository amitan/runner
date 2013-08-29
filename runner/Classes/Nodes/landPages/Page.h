//
//  Page.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/29.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Page : CCNode {
    
}
@property (nonatomic, readwrite)BOOL isPlaying;
@property (nonatomic, readwrite)BOOL isStaged;

// 指定したページを生成する
+ (Page*)create:(int)pageId type:(int)type;

// ページが画面外か
- (BOOL)isOut;

// アニメーションを開始/停止する
- (void)start;
- (void)stop;
- (void)reset;

// ページをマップに配置/解除する
- (void)stageOn:(CCNode*)map;
- (void)stageOff;

// ページサイズ取得
- (float)getWidth;

@end
