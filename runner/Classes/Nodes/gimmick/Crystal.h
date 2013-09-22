//
//  Crystal.h
//  runner
//
//  Created by Ayumi Otomo on 2013/09/16.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Gimmick.h"

@interface Crystal : Gimmick {
    
}

typedef enum {
    CRYSTAL_BLUE = 1,
    CRYSTAL_YELLOW = 2,
    CRYSTAL_RED = 3,
    CRYSTAL_BLACK = 4,
} CRYSTAL_TYPE;


// 指定したアイテムを生成する
+ (Crystal*)createCrystal:(float)x y:(float)y;

- (BOOL)takenIfCollided:(CGRect)rect;
- (int)getCrystalId;

@end
