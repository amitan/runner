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
- (void)setup;
- (void)start;
- (void)stop;

// 衝突しているブロック/エネミーを取得する
- (Block*)getHitBlock:(CGPoint)point;

// コイン/敵に衝突しているかチェックする
- (BOOL)takeCoinsIfCollided:(CGPoint)point;
- (BOOL)attackEnemyIfCollided:(CGPoint)point;
- (BOOL)isHit:(CGPoint)point;

// マップをスクロールする
- (void)scroll:(float)dx;

@end
