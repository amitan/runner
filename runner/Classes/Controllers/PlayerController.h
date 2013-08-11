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
- (void)jump;
- (void)trampoline;

// スピードアップ
- (void)speedUp;

@end
