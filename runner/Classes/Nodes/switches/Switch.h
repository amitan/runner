//
//  Switch.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/04.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Switch : CCNode {
    
}
@property (nonatomic, retain)CCSprite *_sprite;
@property (nonatomic, retain)CCSprite *_spriteOn;
@property (nonatomic, readwrite)BOOL _isPressed;
@property (nonatomic, readwrite)int _switchId;

// 指定したスイッチを生成する
+ (Switch*)createSwitch:(int)switchId;

// スイッチを指定して初期化する
-(id)initWithSwitchId:(int)switchId;

// ページに追加する
- (void)stageOn:(CCNode*)page;

// 座標がスイッチに含まれているか判定する
- (BOOL)pressIfCollided:(CGRect)rect;

// アニメーションを開始/停止する
- (void)start;
- (void)stop;
- (void)reset;

@end
