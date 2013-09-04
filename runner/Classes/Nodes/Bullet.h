//
//  Bullet.h
//  runner
//
//  Created by Ayumi Otomo on 2013/09/01.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Bullet : CCNode {
    
}
@property (nonatomic, readwrite)BOOL isStaged;

- (void)start;
- (void)stop;
- (void)reset;
- (void)stageOn:(CGPoint)position;

@end
