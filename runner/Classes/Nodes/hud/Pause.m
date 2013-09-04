//
//  Pause.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/23.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Pause.h"
#import "LabelUtil.h"
#import "PointUtil.h"
#import "GameScene.h"

@interface Pause ()
@property (nonatomic, retain)CCLabelTTF *_pauseLabel;
@end

@implementation Pause

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
        self._pauseLabel = [LabelUtil createLabel:@"PAUSE" fontSize:70];
        self._pauseLabel.position = ccp(background.contentSize.width / 2, background.contentSize.height / 2 - [PointUtil getPoint:8]);
        [background addChild:self._pauseLabel];
    }
    return self;
}

- (void)dealloc {
    self._pauseLabel = nil;
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
    if (![self parent]) {
        [[GameScene sharedInstance].backgroundLayer addChild:self];
    }
}

- (void)stageOff {
    [self removeFromParentAndCleanup:false];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    [self stageOff];
    [[GameScene sharedInstance] resume];
    [GameScene sharedInstance].hudController.isPausing = false;
    [[GameScene sharedInstance].hudController sync];
    return YES;
}

@end
