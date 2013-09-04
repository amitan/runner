//
//  Gun.h
//  runner
//
//  Created by Ayumi Otomo on 2013/09/01.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Gun : CCNode {
    
}
@property (nonatomic, readwrite)BOOL isStaged;

// 画面に表示する
- (void)stageOn;
- (void)stageOff;

- (void)start;
- (void)stop;
- (void)reset;
- (void)suspend;
- (void)resume;
- (BOOL)isReady;

@end
