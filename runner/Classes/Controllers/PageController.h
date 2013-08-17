//
//  PageController.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/21.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Page.h"

@interface PageController : CCNode {
    
}

// ページを取得する
- (Page*)getPage;
- (Page*)getPageBy:(int)pageId;

@end
