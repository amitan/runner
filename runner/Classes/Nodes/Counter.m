//
//  Counter.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Counter.h"
#import "GameScene.h"
#import "LabelUtil.h"
#import "PointUtil.h"

@interface Counter ()
@property (nonatomic, readwrite)int _count;
@property (nonatomic, retain)CCLabelTTF *_countLabel;
@end

@implementation Counter

const int MAX_COUNT = 3; // カウント最大値

- (id)init {
    self = [super init];
	if (self) {

        // 初期値を追加
        CGSize winSize = [[CCDirector sharedDirector] winSize];

        // 背景を追加
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"black_belt.png"];
        background.position = ccp(winSize.width / 2, winSize.height / 2);
        [self addChild:background];
        
        // ラベルを追加
        self._countLabel = [LabelUtil createLabel:@"" fontSize:70];
        self._countLabel.position = ccp(background.contentSize.width / 2, background.contentSize.height / 2 - [PointUtil getPoint:8]);
        [background addChild:self._countLabel];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)onEnter {
    [super onEnter];
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self
                                                              priority:0
                                                       swallowsTouches:YES];
}

- (void)onExit {
    [super onExit];
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}

- (void)stageOn {
    self._count = MAX_COUNT;
    if (![self parent]) {
        [[GameScene sharedInstance].backgroundLayer addChild:self];
    }
}

- (void)stageOff {
    [self removeFromParentAndCleanup:false];
}

- (BOOL)isEnd {
    if (self._count <= 0) {
        return true;
    }
    [self sync];
    return false;
}

- (void)next {
    self._count--;
}

- (void)sync {
    [self._countLabel setString:[NSString stringWithFormat:@"%d", self._count]];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}
@end
