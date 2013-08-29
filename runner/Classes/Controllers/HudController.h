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

// 動作を開始/停止する
- (void)setup;
- (void)start;
- (void)stop;

// コインを加算する
- (void)addCoin:(int)num;
- (void)addCoin:(int)num playerNo:(int)no;

// コインボーナスを加算する
- (void)addCoinBonus:(int)num;
- (void)addCoinBonus:(int)num playerNo:(int)no;

// 距離を加算/取得する
- (void)addDistance:(float)num;
- (int)getDistance;

// コイン数を取得する
- (int)getPlayer1Coin;
- (int)getPlayer2Coin;
- (int)getPlayer3Coin;

// EXPを加算/取得する
- (void)addExp:(int)num;
- (void)fever;

// 演出を表示する
- (void)showSpeedUpEffect;

@end
