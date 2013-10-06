//
//  CountController.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CountController : CCNode {
    
}

// 動作を開始/停止する
- (void)setup;
- (void)start;
- (void)stop;
- (void)suspend;
- (void)resume;

// カウント終了後のリスナーを登録する
- (void)addEndListner:(id)target selector:(SEL)selector;

@end
