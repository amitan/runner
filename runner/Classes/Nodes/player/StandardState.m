//
//  StandardState.m
//  runner
//
//  Created by Ayumi Otomo on 2013/09/19.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "StandardState.h"
#import "PointUtil.h"
#import "GameUtil.h"

@implementation StandardState

- (float)jump:(CCSprite *)sprite num:(float)num vy:(float)vy onGroud:(BOOL)onGround {
    
    if (num == 0 && onGround) { // 初回ジャンプ
        return self._jumpSpeed;
        
    } else if (num != 0 && num < self._jumpNum) { // 空中ジャンプ
        [sprite runAction:[CCRotateBy actionWithDuration:0.2f angle:360]];
        return self._jumpSpeed;
    }
    
    return vy;
}

@end
