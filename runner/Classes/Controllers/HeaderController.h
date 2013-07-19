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
@property (nonatomic, readwrite)int coinNum;

// 動作を開始/停止する
- (void)setup;
- (void)start;
- (void)stop;

// プロパティを表示に反映する
- (void)sync;

@end
