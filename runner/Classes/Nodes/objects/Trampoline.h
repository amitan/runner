//
//  Trampoline.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/10.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Trampoline : CCNode {
    
}
@property (nonatomic, retain)CCSprite *_sprite;
@property (nonatomic, readwrite)int _trampolineId;


// 指定したトランポリンを生成する
+ (Trampoline*)createTrampoline:(int)trampoilneId;

// トランポリンを指定して初期化する
-(id)initWithTrampolineId:(int)trampolineId;

// ページに追加する
- (void)stageOn:(CCNode*)page;

@end
