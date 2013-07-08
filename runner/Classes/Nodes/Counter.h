//
//  Counter.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Counter : CCNode {
    
}

- (void)stageOn;
- (void)stageOff;

- (BOOL)isEnd;
- (void)next;

@end
