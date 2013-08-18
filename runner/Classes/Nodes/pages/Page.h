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
#import "Switch.h"
#import "Rail.h"

@interface Page : CCNode {
    
}
@property (nonatomic, readwrite)BOOL isPlaying;
@property (nonatomic, readwrite)BOOL isSpeedUp;
@property (nonatomic, retain)Block *_land;
@property (nonatomic, retain)Coin *_lastCoin;
@property (nonatomic, retain)NSArray *_blocks;
@property (nonatomic, retain)NSArray *_coins;
@property (nonatomic, retain)NSArray *_enemies;
@property (nonatomic, retain)NSArray *_switches;
@property (nonatomic, retain)NSArray *_trampolines;
@property (nonatomic, retain)NSArray *_rails;

// 指定したページを生成する
+ (Page*)create:(int)pageId;

// アニメーションを開始/停止する
- (void)start;
- (void)stop;
- (void)reset;

// ページをマップに配置/解除する
- (void)stageOn:(CCNode*)map;
- (void)stageOff;

// ページ幅を取得
- (float)getWidth;
- (CGPoint)getLandPosition:(Block*)block;

// 衝突したブロックを取得する
- (Block*)getHitBlock:(CGPoint)point;
- (Rail*)getHitRail:(CGRect)rect;

// ギミック衝突判定
- (BOOL)takeCoinsIfCollided:(CGRect)rect;
- (BOOL)pressSwitchesIfCollided:(CGRect)rect;
- (BOOL)jumpIfCollided:(CGRect)rect;

// 敵判定
- (BOOL)attackEnemyIfCollided:(CGPoint)point;
- (BOOL)isHit:(CGPoint)point;

// ページが画面外か
- (BOOL)isOut;

// ページを配置済みか
- (BOOL)isStaged;

@end
