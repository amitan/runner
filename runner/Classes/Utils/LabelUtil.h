//
//  LabelUtil.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface LabelUtil : NSObject

+ (CCLabelTTF *)createLabel:(NSString*)labelWithString fontSize:(int)size;
+ (CCLabelTTF *)createLabel:(NSString*)labelWithString fontSize:(int)size dimensions:(CGSize)dimensions alignment:(CCTextAlignment)alignment;
+ (CCLabelTTF *)createLabel:(NSString*)labelWithString fontSize:(int)size dimensions:(CGSize)dimensions hAlignment:(CCTextAlignment)hAlignment vAlignment:(CCVerticalTextAlignment)vAlignment;
@end
