//
//  EnemyAnimation.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/20.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EnemyAnimation : NSObject

// 歩行アニメーションを取得
+ (id)getWalkAction:(int)charaId;

// 死亡アニメーション
+ (id)getDeadAction;

@end
