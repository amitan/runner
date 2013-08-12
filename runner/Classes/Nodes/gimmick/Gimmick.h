//
//  Gimmick.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/12.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Gimmick : CCNode {
    
}

- (void)stageOn:(CCNode*)page;
- (void)start;
- (void)stop;
- (void)reset;

@end
