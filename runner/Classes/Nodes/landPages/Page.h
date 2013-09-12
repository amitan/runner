//
//  Page.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/29.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameUtil.h"

@interface Page : CCNode {
    
}
@property (nonatomic, readwrite)BOOL isPlaying;
@property (nonatomic, readwrite)BOOL isStaged;
@property (nonatomic, readwrite)BOOL isSpeedUp;
@property (nonatomic, readwrite)int appearNum;
@property (nonatomic, retain)NSArray *_coins;
@property (nonatomic, retain)NSArray *_enemies;

// ページが画面外か
- (BOOL)isOut;
- (void)resetAppearNum;

// アニメーションを開始/停止する
- (void)start;
- (void)stop;
- (void)reset;
- (void)clear;

// ページをマップに配置/解除する
- (void)stageOn:(CCNode*)map;
- (void)stageOff;

// ページサイズ取得
- (float)getWidth;

@end
