//
//  Switch.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/04.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Gimmick.h"

@interface Switch : Gimmick {
    
}
@property (nonatomic, retain)CCSprite *_sprite;
@property (nonatomic, retain)CCSprite *_spriteOn;
@property (nonatomic, readwrite)BOOL _isPressed;
@property (nonatomic, readwrite)int _switchId;
@property (nonatomic, readwrite)int groupId;

// 指定したスイッチを生成する
+ (Switch*)createSwitch:(int)switchId;
+ (Switch*)createSwitch:(int)switchId groupId:(int)groupId;
+ (Switch*)createSwitch:(int)switchId x:(float)x y:(float)y;
+ (Switch*)createSwitch:(int)switchId groupId:(int)groupId x:(float)x y:(float)y;

// スイッチを指定して初期化する
-(id)initWithSwitchId:(int)switchId groupId:(int)groupId;

// 座標がスイッチに含まれているか判定する
- (BOOL)pressIfCollided:(CGRect)rect;

@end
