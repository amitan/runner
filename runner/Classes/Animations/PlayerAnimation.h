//
//  PlayerAnimation.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/09.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PlayerAnimation : NSObject

// 歩行アニメーションを取得
+ (id)getWalkAction:(int)monsterId;

// 死亡演出を取得
+ (CCParticleSystem*)getDeadParticle;

@end
