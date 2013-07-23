//
//  Pause.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/23.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Pause : CCNode<CCTouchOneByOneDelegate> {
    
}
- (void)stageOn;
- (void)stageOff;

@end
