//
//  CCNodeButton.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/13.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCNodeButton : CCNode<CCTouchOneByOneDelegate> {
    BOOL isTouch;
    BOOL isEnabled;
    NSInvocation* listener;
    int property;
}
@property (nonatomic, readwrite)BOOL isEnabled;
@property (nonatomic, readwrite)int property;
@property (nonatomic, retain)CCSprite *_sprite;

- (void)addClickListner:(id)target selector:(SEL)selector;
@end
