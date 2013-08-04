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
@property (nonatomic, readwrite)int _coinId;
@property (nonatomic, readwrite)BOOL _isStaged;

// 指定したコインを生成する
+ (Coin*)createCoin:(int)coinId;

// コインを指定して初期化する
-(id)initWithCoinId:(int)coinId;

// コインアニメーションを開始/停止する
- (void)start;
- (void)stop;
- (void)reset;

// コインをページに追加する
- (void)stageOn:(CCNode*)page;

// 座標がコインに含まれているか判定する
- (BOOL)takenIfCollided:(CGRect)rect;

// コインを取得済みか
- (BOOL)hasTaken;

// コインを表示する
- (void)appear;

// コインを降らせる
- (void)drop;

// 幅・高さを取得する
- (float)getWidth;
- (float)getHeight;

@end
