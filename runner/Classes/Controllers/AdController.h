//
//  AdController.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/13.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "NADView.h"

@interface AdController : CCNode <NADViewDelegate> {
    
}

// 広告リフレッシュの停止/再開
- (void)pause;
- (void)resume;

@end
