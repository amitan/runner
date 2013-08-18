//
//  ColorUtil.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "ColorUtil.h"

@implementation ColorUtil

+ (ccColor3B)getDefaultColor {
    return ccc3(255, 255, 255);
}

+ (ccColor3B)getTouchedColor {
    return ccc3(255, 255, 0);
}

+ (ccColor3B)getEffectOrangeColor {
    return ccc3(255, 140, 0);
}

+ (ccColor3B)getWarningRedColor {
    return ccc3(255, 0, 0);
}

@end
