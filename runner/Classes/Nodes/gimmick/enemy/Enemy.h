//
//  Enemy.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/20.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Gimmick.h"
#import "GameUtil.h"

@interface Enemy : Gimmick {
    
}
@property (nonatomic, readwrite)BOOL _isStaged;

typedef enum {
    E_KINOKO = 1,
    E_SLYME = 2,
    E_NEEDLE_HALF = 200,
    E_NEEDLE = 201,
} ENEMY_TYPE;


// 指定した敵を生成する
+ (Enemy*)createEnemy:(ENEMY_TYPE)enemyId;
+ (Enemy*)createEnemy:(ENEMY_TYPE)enemyId x:(float)x y:(float)y;

// EXPを取得する
- (int)getExp;

// キャラを指定して初期化する
- (id)initWithEnemyId:(int)enemyId;

// 座標が敵に含まれているか判定する
- (BOOL)isEnemyHit:(CGPoint)point direction:(DIRECTION)direction;
- (BOOL)isEnemyHit:(CGPoint)center radius:(float)radius;
- (BOOL)deadIfCollided:(CGPoint)point direction:(DIRECTION)direction;
- (BOOL)_isHit:(CGPoint)point;

@end
