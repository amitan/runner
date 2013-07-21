//
//  Coin.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/16.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Coin : CCNode {
    
}

// コインアニメーションを開始/停止する
- (void)start;
- (void)stop;
- (void)reset;

// コインをページに追加する
- (void)stageOn:(CCNode*)page;

// 座標がコインに含まれているか判定する
- (BOOL)takenIfCollided:(CGPoint)point;

// コインを取得済みか
- (BOOL)hasTaken;

@end
