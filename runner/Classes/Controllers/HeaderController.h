//
//  HeaderController.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/17.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface HeaderController : CCNode {
    
}

// 動作を開始/停止する
- (void)setup;
- (void)start;
- (void)stop;

// コインを加算する
- (void)addCoin:(int)num;

// コインボーナスを加算する
- (void)addCoinBonus:(int)num;

// 距離を加算する
- (void)addDistance:(float)num;
@end
