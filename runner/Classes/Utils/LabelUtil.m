//
//  LabelUtil.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "LabelUtil.h"
#import "ColorUtil.h"
#import "PointUtil.h"

@implementation LabelUtil

+ (CCLabelTTF *)createLabel:(NSString*)labelWithString fontSize:(int)size {
    return [LabelUtil _createLabel:labelWithString fontSize:size color:[ColorUtil getDefaultFontColor]];
}

+ (CCLabelTTF *)_createLabel:(NSString*)labelWithString fontSize:(int)size color:(ccColor3B)color {
    int fontSize = size / [[UIScreen mainScreen] scale];
    CCLabelTTF *label = [CCLabelTTF labelWithString:labelWithString fontName:@"MisakiGothic" fontSize:fontSize];
    label.color = color;
    return label;
}

+ (CCLabelTTF *)createLabel:(NSString*)labelWithString fontSize:(int)size dimensions:(CGSize)dimensions alignment:(CCTextAlignment)alignment {
    return [LabelUtil createLabel:labelWithString fontSize:size dimensions:dimensions hAlignment:alignment vAlignment:kCCVerticalTextAlignmentCenter];
}

+ (CCLabelTTF *)createLabel:(NSString*)labelWithString fontSize:(int)size dimensions:(CGSize)dimensions hAlignment:(CCTextAlignment)hAlignment vAlignment:(CCVerticalTextAlignment)vAlignment {
    int fontSize = size / [[UIScreen mainScreen] scale];
    CGSize newDimensions = CGSizeMake([PointUtil getPoint:dimensions.width], [PointUtil getPoint:dimensions.height]);
    CCLabelTTF *label = [CCLabelTTF labelWithString:labelWithString fontName:@"MisakiGothic" fontSize:fontSize
                                         dimensions:newDimensions hAlignment:hAlignment vAlignment:vAlignment];
    label.color = [ColorUtil getDefaultFontColor];
    return label;
}

@end
