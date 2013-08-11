//
//  MapController.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Block.h"
#import "Player.h"

@interface MapController : CCNode {
    
}

// 動作を開始/停止する
- (void)setup:(int)stageId isRandom:(BOOL)isRandom;
- (void)start;
- (void)stop;

// 衝突しているブロック/エネミーを取得する
- (Block*)getHitBlock:(CGPoint)point;
- (Block*)getHitBlockByRect:(CGRect)rect;

// コイン/敵に衝突しているかチェックする
- (void)takeItemsIfCollided:(CGRect)rect;
- (BOOL)attackEnemyIfCollided:(CGPoint)point;
- (BOOL)isHit:(CGPoint)point;
- (BOOL)jumpIfCollided:(CGRect)rect;

// スピードアップするか判定する
- (BOOL)checkSpeedUp:(CGPoint)point;

// マップをスクロールする
- (void)scroll:(float)dx;

@end
