//
//  Map.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/14.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Block.h"
#import "Page.h"

@interface Map : CCNode {
    
}
@property (nonatomic, readwrite)BOOL isPlaying;

// 指定したマップを生成する
+ (Map*)createMap:(int)stageId isRandom:(BOOL)isRandom;

// ステージを指定してマップを初期化する
- (id)initWithStageId:(int)stageId isRandom:(BOOL)isRandom;

// アニメーションを開始/停止する
- (void)start;
- (void)stop;

// マップにページを追加する
- (void)addPage:(Page *)page;
- (void)addPage:(Page *)page interval:(int)interval;

// 座標が含まれるブロックを返す
- (Block*)getHitBlock:(CGPoint)point;

// コインを取得しているかチェックする
- (BOOL)takeCoinsIfCollided:(CGRect)rect;

// 敵チェック
- (BOOL)attackEnemyIfCollided:(CGPoint)point;
- (BOOL)isHit:(CGPoint)point;

// スピードアップするか判定する
- (BOOL)checkSpeedUp:(CGPoint)point;

// 必要に応じてページの追加/削除を行う
- (void)refillIfNeeded;

@end
