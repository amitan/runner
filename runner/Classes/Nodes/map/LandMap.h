//
//  LandMap.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/14.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Map.h"
#import "Block.h"
#import "Rail.h"

@interface LandMap : Map {
    
}
@property (nonatomic, readwrite)int speed;

// 指定したマップを生成する
+ (LandMap*)createMap:(int)stageId;

// ステージを指定してマップを初期化する
- (id)initWithStageId:(int)stageId;

// 座標が含まれるブロックを返す
- (Block*)getHitBlock:(CGPoint)point;
- (Rail*)getHitRail:(CGRect)rect;

// コインを取得しているかチェックする
- (void)takeItemsIfCollided:(CGRect)rect;
- (BOOL)jumpIfCollided:(CGRect)rect;

// 敵チェック
- (BOOL)attackEnemyIfCollided:(CGPoint)point;
- (BOOL)isHit:(CGPoint)point;

// スピードアップするか判定する
- (BOOL)checkSpeedUp:(CGPoint)point;

// 必要に応じてページの追加/削除を行う
- (void)refillIfNeeded;

@end
