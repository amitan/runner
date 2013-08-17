//
//  ConversationLayer.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/13.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface ConversationLayer : CCLayer {
    
}

- (void)setTexts:(NSArray *)texts;
- (void)addCompleteListner:(id)target selector:(SEL)selector;

@end
