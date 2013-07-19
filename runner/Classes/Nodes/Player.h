//
//  Player.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Player : CCNode {
    
}

// 指定した敵を生成する
+ (Player*)createPlayer:(int)enemyId;

// 敵を指定して初期化する
- (id)initWithEnemyId:(int)enemyId;

// 画面に表示する
- (void)stageOn:(int)order;

// 動作を開始/停止する
- (void)start;
- (void)stop;

// ジャンプ
- (void)jump;

// 座標を取得する
- (CGPoint)getCenterBottomPosition;
- (CGPoint)getCenterRightPosition;
- (CGPoint)getTopLeftPosition;
- (CGPoint)getTopRightPosition;
- (CGPoint)getBottomLeftPosition;
- (CGPoint)getBottomRightPosition;

// 幅・高さを取得する
- (float)getWidth;
- (float)getHeight;

@end
