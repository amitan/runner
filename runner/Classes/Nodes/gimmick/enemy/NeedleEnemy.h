//
//  NeedleEnemy.h
//  runner
//
//  Created by Ayumi Otomo on 2013/09/01.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Enemy.h"

@interface NeedleEnemy : Enemy {
    
}
+ (Enemy*)createEnemy:(ENEMY_TYPE)enemyId x:(float)x y:(float)y;

@end
