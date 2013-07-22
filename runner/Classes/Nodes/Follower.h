//
//  Follower.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/22.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Follower : CCNode {
    
}
extern const int FOLLOWER_DX;

// 指定したモンスターを生成する
+ (Follower*)createFollower:(int)monsterId;

// モンスターを指定して初期化する
- (id)initWithMonsterId:(int)monsterId;

// 画面に表示する
- (void)stageOn:(int)order;

// 動作を開始/停止する
- (void)start;
- (void)stop;

// 座標を更新する
- (void)setPointArray:(NSMutableArray *)points;
- (void)updatePosition;

@end
