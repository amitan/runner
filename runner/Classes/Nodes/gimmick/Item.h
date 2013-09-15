//
//  Item.h
//  runner
//
//  Created by Ayumi Otomo on 2013/09/14.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Gimmick.h"

@interface Item : Gimmick {
    
}
@property (nonatomic, readwrite)int _itemId;
@property (nonatomic, readwrite)BOOL _isStaged;

// 指定したアイテムを生成する
+ (Item*)createItem:(float)x y:(float)y;

- (BOOL)takenIfCollided:(CGRect)rect;

@end
