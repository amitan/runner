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
#import "Page.h"
#import "GameUtil.h"
#import "Enemy.h"
#import "Item.h"
#import "Crystal.h"

@interface LandPage : Page {
    
}
@property (nonatomic, retain)Block *_land;
@property (nonatomic, retain)Coin *_lastCoin;
@property (nonatomic, retain)NSArray *_blocks;
@property (nonatomic, retain)NSArray *_switches;
@property (nonatomic, retain)NSArray *_trampolines;
@property (nonatomic, retain)NSArray *_rails;
@property (nonatomic, retain)Item *_item;
@property (nonatomic, retain)Crystal *_crystal;

// ページ幅を取得
- (CGPoint)getLandPosition:(Block*)block;

// 衝突したブロックを取得する
- (Block*)getHitBlock:(CGPoint)point;
- (Rail*)getHitRail:(CGRect)rect;

// ギミック衝突判定
- (BOOL)takeCoinsIfCollided:(CGRect)rect magnet:(BOOL)isMagnet;
- (BOOL)pressSwitchesIfCollided:(CGRect)rect;
- (BOOL)jumpIfCollided:(CGRect)rect;
- (Item*)takeItemIfCollided:(CGRect)rect;
- (Crystal*)takeCrystalIfCollided:(CGRect)rect;

// 敵判定
- (Enemy*)attackEnemyIfCollided:(CGPoint)point direction:(DIRECTION)direction isForce:(BOOL)isForce;
- (NSArray*)attackEnemiesBetween:(CGPoint)point end:(CGPoint)endPoint;
- (BOOL)isEnemyHit:(CGPoint)point direction:(DIRECTION)direction;

@end
