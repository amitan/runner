//
//  Enemy.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/20.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Enemy : CCNode {
    
}

// 指定した敵を生成する
+ (Enemy*)createEnemy:(int)charaId;
+ (Enemy*)createEnemy:(int)charaId x:(float)x y:(float)y;

// キャラを指定して初期化する
- (id)initWithCharaId:(int)charaId;

// 敵をページに追加する
- (void)stageOn:(CCNode*)page;

// アニメーションを開始/停止する
- (void)start;
- (void)stop;
- (void)reset;

// 座標が敵に含まれているか判定する
- (BOOL)isHit:(CGPoint)point;
- (BOOL)deadIfCollided:(CGPoint)point;

@end
