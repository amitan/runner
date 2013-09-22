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

// 指定したモンスターを生成する
+ (Player*)createPlayer:(int)monsterId;
+ (Player*)createPlayer:(int)monsterId isReverse:(BOOL)isReverse;

// モンスターを指定して初期化する
- (id)initWithMonsterId:(int)monsterId isReverse:(BOOL)isReverse;

// 画面に表示する
- (void)stageOn;
- (void)stageOff;

// 動作を開始/停止する
- (void)start;
- (void)stop;
- (void)invisibleStart;
- (void)touchBegan;
- (void)touchEnd;

// プレイヤーアクション
- (void)jump;
- (void)trampoline;
- (BOOL)deadIfBulletCollided:(CGPoint)position;
- (void)getOff:(CGPoint)position func:(id)func;
- (void)goDown:(id)func;

// スピードアップ
- (void)speedUp;

// 座標を取得する
- (CGPoint)getCenterBottomPosition;
- (CGPoint)getCenterTopPosition;
- (CGPoint)getCenterRightPosition;
- (CGPoint)getCenterLeftPosition;
- (CGPoint)getTopLeftPosition;
- (CGPoint)getTopRightPosition;
- (CGPoint)getBottomLeftPosition;
- (CGPoint)getBottomRightPosition;

// 幅・高さを取得する
- (float)getWidth;
- (float)getHeight;
- (BOOL)isReverse;

// 死亡する
- (void)dead:(BOOL)isForce;

// エフェクトを発動する
- (void)runChangeEffect:(id)func;

@end
