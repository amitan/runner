//
//  StandardEnemy.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/31.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Enemy.h"

@interface StandardEnemy : Enemy {
    
}
+ (Enemy*)createEnemy:(ENEMY_TYPE)enemyId x:(float)x y:(float)y;

@end
