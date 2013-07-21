//
//  Page.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/16.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Block.h"
#import "Coin.h"

@interface Page : CCNode {
    
}
@property (nonatomic, readonly)BOOL isPlaying;
@property (nonatomic, retain)Block *_land;
@property (nonatomic, retain)Coin *_lastCoin;
@property (nonatomic, retain)NSMutableArray *_blocks;
@property (nonatomic, retain)NSMutableArray *_coins;
@property (nonatomic, retain)NSMutableArray *_enemies;

// アニメーションを開始/停止する
- (void)start;
- (void)stop;

// ページ幅を取得
- (float)getWidth;

// 衝突したブロックを取得する
- (Block*)getHitBlock:(CGPoint)point;

// コインを取得したか判定する
- (BOOL)takeCoinsIfCollided:(CGPoint)point;

// 敵判定
- (BOOL)attackEnemyIfCollided:(CGPoint)point;
- (BOOL)isHit:(CGPoint)point;

// ページが画面外か
- (BOOL)isOut;

@end
