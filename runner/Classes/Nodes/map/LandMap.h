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
#import "Enemy.h"

@interface LandMap : Map {
    
}
@property (nonatomic, readwrite)int speed;

// 指定したマップを生成する
+ (LandMap*)createMap:(int)stageId isRandom:(BOOL)isRandom;

// 座標が含まれるブロックを返す
- (Block*)getHitBlock:(CGPoint)point;
- (Rail*)getHitRail:(CGRect)rect;

// 当たり判定をする
- (void)takeCoinsIfCollided:(CGRect)rect magnet:(BOOL)isMagnet;
- (void)takeOthersIfCollided:(CGRect)rect;
- (BOOL)jumpIfCollided:(CGRect)rect;
- (Item*)takeItemIfCollided:(CGRect)rect;
- (Crystal*)takeCrystalIfCollided:(CGRect)rect;
- (Enemy*)attackEnemyIfCollided:(CGPoint)point direction:(DIRECTION)direction isForce:(BOOL)isForce;
- (BOOL)isEnemyHit:(CGPoint)point direction:(DIRECTION)direction;

// すべての敵を攻撃する
- (NSArray*)attackAllEnemies;

// スピードアップを判定する
- (BOOL)checkSpeedUp:(CGPoint)point;

// 大砲を処理する
- (BOOL)checkFire1:(ccTime)dt;
- (BOOL)checkFire2:(ccTime)dt;
- (void)fire1;
- (void)fire2;
- (void)clearBullets;

// 必要に応じてページの追加/削除を行う
- (void)refillIfNeeded;
- (void)restructure;

// プロパティを取得する
- (BOOL)isRandom;

@end
