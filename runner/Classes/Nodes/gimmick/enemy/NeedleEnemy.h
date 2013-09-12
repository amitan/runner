//
//  NeedleEnemy.h
//  runner
//
//  Created by Ayumi Otomo on 2013/09/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Enemy.h"

@interface NeedleEnemy : Enemy {
    
}
+ (NeedleEnemy*)createEnemy:(ENEMY_TYPE)enemyId x:(float)x y:(float)y;

@end
