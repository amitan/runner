//
//  MapController.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Block.h"

@interface MapController : CCNode {
    
}

// 接触しているか
- (Block*)getCollidedBlock:(CGPoint)position;

// マップをスクロールする
- (void)scroll:(float)dx;

@end
