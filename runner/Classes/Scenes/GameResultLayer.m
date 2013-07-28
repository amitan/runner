//
//  GameResultLayer.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/29.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "GameResultLayer.h"
#import "CCSpriteButton.h"
#import "GameUtil.h"
#import "TitleLayer.h"

@interface GameResultLayer ()
@property (nonatomic, retain)CCSprite* _baseSprite;
@end

@implementation GameResultLayer

- (id)init {
    self = [super init];
	if (self) {

        // 背景の追加
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCSprite *black = [CCSprite spriteWithSpriteFrameName:@"black.png"];
        black.scaleY = 1.5;
        black.position = ccp(winSize.width / 2, winSize.height / 2);
        [self addChild:black];

        // 次へボタン追加
        CCSpriteButton *backButton = [CCSpriteButton spriteWithSpriteFrameName:@"btn_next.png"];
        [backButton addClickListner:self selector:@selector(clickRetryButton:)];
        backButton.position = ccp(winSize.width / 2, winSize.height / 2);
        [self addChild:backButton];

    }
    return self;
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

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)clickRetryButton:(id)sender {
    [self removeFromParentAndCleanup:YES];
    [GameUtil replaceScene:[TitleLayer scene]];
}

@end
