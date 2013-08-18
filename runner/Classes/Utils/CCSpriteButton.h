//
//  CCSpriteButton.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/12.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface CCSpriteButton : CCSprite<CCTouchOneByOneDelegate> {
    BOOL isTouch;
    BOOL isEnabled;
    NSInvocation* listener;
    int property;
}
@property (nonatomic, readwrite)BOOL isEnabled;
@property (nonatomic, readwrite)BOOL changeColor;
@property (nonatomic, readwrite)int property;

- (void)addClickListner:(id)target selector:(SEL)selector;
- (void)addLabel:(CCLabelTTF *)label;
- (void)addLabel:(CCLabelTTF *)label offsetX:(int)x offsetY:(int)y;
@end
