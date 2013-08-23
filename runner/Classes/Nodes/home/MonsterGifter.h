//
//  MonsterGifter.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/22.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCNodeButton.h"

@interface MonsterGifter : CCNodeButton {
    
}

+ (MonsterGifter*)create:(int)_nodeId;
- (id)initWithNodeId:(int)_nodeId;

// 動作を開始/停止する
- (void)start;
- (void)stop;

@end
