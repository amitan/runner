//
//  PlayerSelectLayer.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/18.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PlayerSelectLayer : CCLayer {
    
}
@property (nonatomic, readwrite)int orderNo;

- (void)addCompleteListner:(id)target selector:(SEL)selector;

@end
