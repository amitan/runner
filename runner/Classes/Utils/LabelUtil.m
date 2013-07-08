//
//  LabelUtil.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "LabelUtil.h"
#import "ColorUtil.h"

@implementation LabelUtil

+ (CCLabelTTF *)createLabel:(NSString*)labelWithString fontSize:(int)size {
    return [LabelUtil _createLabel:labelWithString fontSize:size color:[ColorUtil getDefaultFontColor]];
}

+ (CCLabelTTF *)_createLabel:(NSString*)labelWithString fontSize:(int)size color:(ccColor3B)color {
    int fontSize = size / [[UIScreen mainScreen] scale];
    CCLabelTTF *label = [CCLabelTTF labelWithString:labelWithString fontName:@"Helvetica-Bold" fontSize:fontSize];
    label.color = color;
    return label;
}

@end
