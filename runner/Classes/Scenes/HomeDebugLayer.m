//
//  HomeDebugLayer.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/20.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "HomeDebugLayer.h"
#import "GameUtil.h"
#import "PointUtil.h"
#import "CCSpriteButton.h"
#import "LabelUtil.h"
#import "GameDao.h"

@implementation HomeDebugLayer

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

        // ゴールド設定
        CCSpriteButton *coin1Button = [CCSpriteButton spriteWithSpriteFrameName:@"coin_base.png"];
        CCLabelTTF *coin1Label = [LabelUtil createLabel:@"0G" fontSize:30];
        [coin1Button addLabel:coin1Label];
        coin1Button.position = [PointUtil getPosition:70 y:670];
        coin1Button.tag = 0;
        coin1Button.property = buttonProperty;
        [coin1Button addClickListner:self selector:@selector(clickCoinButton:)];
        [popupBaseSprite addChild:coin1Button];
        
        CCSpriteButton *coin2Button = [CCSpriteButton spriteWithSpriteFrameName:@"coin_base.png"];
        CCLabelTTF *coin2Label = [LabelUtil createLabel:@"1000G" fontSize:30];
        [coin2Button addLabel:coin2Label];
        coin2Button.position = [PointUtil getPosition:210 y:670];
        coin2Button.tag = 1000;
        coin2Button.property = buttonProperty;
        [coin2Button addClickListner:self selector:@selector(clickCoinButton:)];
        [popupBaseSprite addChild:coin2Button];

        CCSpriteButton *coin3Button = [CCSpriteButton spriteWithSpriteFrameName:@"coin_base.png"];
        CCLabelTTF *coin3Label = [LabelUtil createLabel:@"1000000G" fontSize:30];
        [coin3Button addLabel:coin3Label];
        coin3Button.position = [PointUtil getPosition:350 y:670];
        coin3Button.tag = 1000000;
        coin3Button.property = buttonProperty;
        [coin3Button addClickListner:self selector:@selector(clickCoinButton:)];
        [popupBaseSprite addChild:coin3Button];
        
        // 進捗設定
        CCSpriteButton *step1Button = [CCSpriteButton spriteWithSpriteFrameName:@"coin_base.png"];
        CCLabelTTF *step1Label = [LabelUtil createLabel:@"step0" fontSize:30];
        [step1Button addLabel:step1Label];
        step1Button.position = [PointUtil getPosition:70 y:590];
        step1Button.tag = 0;
        step1Button.property = buttonProperty;
        [step1Button addClickListner:self selector:@selector(clickStepButton:)];
        [popupBaseSprite addChild:step1Button];

        CCSpriteButton *step2Button = [CCSpriteButton spriteWithSpriteFrameName:@"coin_base.png"];
        CCLabelTTF *step2Label = [LabelUtil createLabel:@"step1" fontSize:30];
        [step2Button addLabel:step2Label];
        step2Button.position = [PointUtil getPosition:210 y:590];
        step2Button.tag = 1;
        step2Button.property = buttonProperty;
        [step2Button addClickListner:self selector:@selector(clickStepButton:)];
        [popupBaseSprite addChild:step2Button];

        CCSpriteButton *step3Button = [CCSpriteButton spriteWithSpriteFrameName:@"coin_base.png"];
        CCLabelTTF *step3Label = [LabelUtil createLabel:@"step2" fontSize:30];
        [step3Button addLabel:step3Label];
        step3Button.position = [PointUtil getPosition:350 y:590];
        step3Button.tag = 2;
        step3Button.property = buttonProperty;
        [step3Button addClickListner:self selector:@selector(clickStepButton:)];
        [popupBaseSprite addChild:step3Button];

        CCSpriteButton *step4Button = [CCSpriteButton spriteWithSpriteFrameName:@"coin_base.png"];
        CCLabelTTF *step4Label = [LabelUtil createLabel:@"step3" fontSize:30];
        [step4Button addLabel:step4Label];
        step4Button.position = [PointUtil getPosition:70 y:510];
        step4Button.tag = 3;
        step4Button.property = buttonProperty;
        [step4Button addClickListner:self selector:@selector(clickStepButton:)];
        [popupBaseSprite addChild:step4Button];

        CCSpriteButton *step5Button = [CCSpriteButton spriteWithSpriteFrameName:@"coin_base.png"];
        CCLabelTTF *step5Label = [LabelUtil createLabel:@"step4" fontSize:30];
        [step5Button addLabel:step5Label];
        step5Button.position = [PointUtil getPosition:210 y:510];
        step5Button.tag = 4;
        step5Button.property = buttonProperty;
        [step5Button addClickListner:self selector:@selector(clickStepButton:)];
        [popupBaseSprite addChild:step5Button];

    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)clickCoinButton:(id)sender {
    CCSpriteButton *button = (CCSpriteButton*)sender;
    int coin = button.tag;
    [GameDao setGold:coin];
    [self closeWindow];
}

- (void)clickStepButton:(id)sender {
    CCSpriteButton *button = (CCSpriteButton*)sender;
    int step = button.tag;
    [GameDao setHoemStep:step];
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
