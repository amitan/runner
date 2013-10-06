//
//  HudController.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/17.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HudController : CCNode {
    
}
@property (nonatomic, readwrite)BOOL isPausing;

// 動作を開始/停止する
- (void)setup;
- (void)start;
- (void)stop;
- (void)suspend;
- (void)resume;

// コインを加算する
- (void)addCoin:(int)num;

// 距離を加算/取得する
- (void)addDistance:(float)dx;
- (void)addSkyDistance:(float)dx;
- (void)addLandDistance:(float)dx;
- (int)getDistance;
- (int)getSkyDistance;
- (int)getLandDistance;
- (void)resetSkyDistance;

// EXPを加算/取得する
- (BOOL)addExp:(int)num;
- (void)resetExp;
- (void)fever;
- (void)stopFever;
- (int)getTotalCoin;

// 演出を表示する
- (void)showSpeedUpEffect;

// 同期する
- (void)sync;

@end
