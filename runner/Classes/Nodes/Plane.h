//
//  Plane.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/28.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Plane : CCNode {

}

// 画面に表示する
- (void)stageOn;

// 動作を開始/停止する
- (void)start;
- (void)stop;

// アクション
- (void)takeOff:(id)func;
- (void)flyUp;
- (void)flyDown;
- (void)climbout;

@end
