//
//  PlayerController.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PlayerController : CCNode {
    
}

// 動作を開始/停止する
- (void)setup;
- (void)start;
- (void)stop;

// アクション
- (void)touchBegan;
- (void)touchEnd;
- (void)trampoline;
- (void)ride;
- (void)speedUp;
- (void)fly;

// 取得
- (CGPoint)getPlayerFootPosition;

@end
