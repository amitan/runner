//
//  Follower.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/26.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Follower : CCNode {
    
}

// 指定したモンスターを生成する
+ (Follower*)createFollower:(int)monsterId orderNo:(int)orderNo;

// モンスターを指定して初期化する
- (id)initWithMonsterId:(int)monsterId orderNo:(int)orderNo;

// 画面に表示する
- (void)stageOn;

// 動作を開始/停止する
- (void)start;
- (void)stop;

@end
