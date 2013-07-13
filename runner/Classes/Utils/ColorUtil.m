//
//  ColorUtil.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "ColorUtil.h"

@implementation ColorUtil

+ (ccColor3B)getDefaultFontColor {
    return ccc3(255, 255, 255);
}

+ (ccColor3B)getTouchedFontColor {
    return ccc3(255, 255, 0);
}

@end
