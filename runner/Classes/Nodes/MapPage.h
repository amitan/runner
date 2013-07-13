//
//  MapPage.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/10.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface MapPage : CCNode {
    
}

// ポイントの当たり判定
- (BOOL)containsPoint:(CGPoint)point;

@end
