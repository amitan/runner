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

@interface Enemy : Gimmick {
    
}

// 指定した敵を生成する
+ (Enemy*)createEnemy:(int)charaId;
+ (Enemy*)createEnemy:(int)charaId x:(float)x y:(float)y;

// キャラを指定して初期化する
- (id)initWithCharaId:(int)charaId;

// 座標が敵に含まれているか判定する
- (BOOL)isHit:(CGPoint)point;
- (BOOL)deadIfCollided:(CGPoint)point;

@end
