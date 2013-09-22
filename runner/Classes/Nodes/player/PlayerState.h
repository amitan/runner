//
//  PlayerState.h
//  runner
//
//  Created by Ayumi Otomo on 2013/09/19.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PlayerState : NSObject
@property (nonatomic, readwrite)int _jumpNum, _jumpSpeed, _crystalId, _playerId;

+ (PlayerState*)create:(int)playerId crystalId:(int)crystalId;

- (id)initWithCrystalId:(int)playerId crystalId:(int)crystalId;
- (void)reset:(CCSprite*)sprite;

// アクション
- (float)jump:(CCSprite *)sprite num:(float)num vy:(float)vy onGroud:(BOOL)onGround; // ジャンプ
- (float)calcGravity:(CCSprite*)sprite vy:(float)vy touch:(BOOL)isTouching; // 空中での重力取得
- (void)gotDown:(CCSprite*)sprite; // 着地する
- (BOOL)ignoreEnemyJump;
- (BOOL)ignoreEnemy;
- (BOOL)isForce;
- (float)touchEnd:(CCSprite*)sprite vy:(float)vy onGround:(BOOL)onGround isReverse:(BOOL)isReverse isRunning:(BOOL)isRunning;

@end
