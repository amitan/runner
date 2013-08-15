//
//  Trampoline.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/10.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Gimmick.h"

@interface Trampoline : Gimmick {
    
}
@property (nonatomic, retain)CCSprite *_spriteOn;
@property (nonatomic, readwrite)int _trampolineId;
@property (nonatomic, readwrite)BOOL _isJumped;
@property (nonatomic, readwrite)BOOL _isScaled;

// 指定したトランポリンを生成する
+ (Trampoline*)createTrampoline:(int)trampoilneId;
+ (Trampoline*)createTrampoline:(int)trampoilneId x:(float)x y:(float)y;

// トランポリンを指定して初期化する
-(id)initWithTrampolineId:(int)trampolineId;

// 衝突判定
- (BOOL)jumpIfCollided:(CGRect)rect;

@end
