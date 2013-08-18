//
//  HomeController.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/13.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "ConversationLayer.h"

@interface HomeController : CCNode {
    
}

// 動作を開始/停止する
- (void)setup;
- (void)start;
- (void)stop;
- (void)suspend;
- (void)resume;

// 会話レイヤーを取得する
- (ConversationLayer*)getConversationLayer;
@end
