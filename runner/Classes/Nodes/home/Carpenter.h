//
//  Carpenter.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/13.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCNodeButton.h"

@interface Carpenter : CCNodeButton {
    
}

+ (Carpenter*)create:(int)_nodeId;
- (id)initWithNodeId:(int)_nodeId;

// 動作を開始/停止する
- (void)start;
- (void)stop;

@end