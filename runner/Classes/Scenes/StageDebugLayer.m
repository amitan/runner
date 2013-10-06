//
//  StageDebugLayer.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/20.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "StageDebugLayer.h"
#import "GameUtil.h"
#import "PointUtil.h"
#import "CCSpriteButton.h"
#import "LabelUtil.h"
#import "GameDao.h"
#import "GameScene.h"

@implementation StageDebugLayer

- (id)init {
    self = [super init];
	if (self) {
        
        // 背景の追加
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCSprite *black = [CCSprite spriteWithSpriteFrameName:@"black.png"];
        black.scaleY = 1.5;
        black.position = ccp(winSize.width / 2, winSize.height / 2);
        [self addChild:black];
        
        // ベースウィンドウ追加
        CCSprite *popupBaseSprite = [CCSprite spriteWithSpriteFrameName:@"popup_large.png"];
        [PointUtil setTLPosition:popupBaseSprite x:60 y:154];
        [self addChild:popupBaseSprite];

        int buttonProperty = POPUP_PRIORITY - 1;

        // 1行目
        CCSpriteButton *endless1Button = [CCSpriteButton spriteWithSpriteFrameName:@"coin_base.png"];
        CCLabelTTF *coin1Label = [LabelUtil createLabel:@"ENDLESS" fontSize:30];
        [endless1Button addLabel:coin1Label];
        endless1Button.position = [PointUtil getPosition:70 y:670];
        endless1Button.tag = 90101;
        endless1Button.property = buttonProperty;
        [endless1Button addClickListner:self selector:@selector(clickButton:)];
        [popupBaseSprite addChild:endless1Button];
        
        // 2行目
        CCSpriteButton *stage10101Button = [CCSpriteButton spriteWithSpriteFrameName:@"coin_base.png"];
        CCLabelTTF *stage10101Label = [LabelUtil createLabel:@"1-1" fontSize:30];
        [stage10101Button addLabel:stage10101Label];
        stage10101Button.position = [PointUtil getPosition:70 y:590];
        stage10101Button.tag = 10101;
        stage10101Button.property = buttonProperty;
        [stage10101Button addClickListner:self selector:@selector(clickButton:)];
        [popupBaseSprite addChild:stage10101Button];

        CCSpriteButton *stage10102Button = [CCSpriteButton spriteWithSpriteFrameName:@"coin_base.png"];
        CCLabelTTF *stage10102Label = [LabelUtil createLabel:@"1-2" fontSize:30];
        [stage10102Button addLabel:stage10102Label];
        stage10102Button.position = [PointUtil getPosition:210 y:590];
        stage10102Button.tag = 10102;
        stage10102Button.property = buttonProperty;
        [stage10102Button addClickListner:self selector:@selector(clickButton:)];
        [popupBaseSprite addChild:stage10102Button];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)clickButton:(id)sender {
    CCSpriteButton *button = (CCSpriteButton*)sender;
    int stageId = button.tag;
    BOOL isRandom = (stageId > 90100) ? true : false;
    [GameUtil replaceScene:[GameScene createInstance:stageId isRandom:isRandom]];
    [self closeWindow];
}

- (void)onEnter {
    [super onEnter];
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self
                                                              priority:POPUP_PRIORITY
                                                       swallowsTouches:YES];
}

- (void)onExit {
    [super onExit];
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    [self closeWindow];
}

- (void)closeWindow {
    [self removeFromParentAndCleanup:NO];
}

@end
