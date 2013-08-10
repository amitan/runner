//
//  Trampoline.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/10.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Trampoline.h"


@implementation Trampoline

+ (Trampoline*)createTrampoline:(int)trampolineId {
    return [[[Trampoline alloc] initWithTrampolineId:trampolineId] autorelease];
}

- (id)initWithTrampolineId:(int)trampolineId {
    self = [super init];
    if (self) {
        
        // 初期設定
        self._trampolineId = trampolineId;
        
        // 画像を読み込む
        self._sprite = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"trampoline%d_1.png", self._trampolineId]];
        [self addChild:self._sprite];
    }
    return self;
}

- (void)stageOn:(CCNode*)page {
    if (![self parent]) {
        [page addChild:self];
    }
}

@end
