//
//  SkyPage.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/29.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Page.h"

@interface SkyPage : Page {
    
}

// 衝突判定
- (BOOL)takeCoinsIfCollided:(CGPoint)center radius:(float)radius;
- (BOOL)isEnemyHit:(CGPoint)center radius:(float)radius;

@end
