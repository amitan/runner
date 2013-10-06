//
//  TitleLayer.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/11.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "TitleLayer.h"
#import "PointUtil.h"
#import "LabelUtil.h"
#import "CCSpriteButton.h"
#import "CommonAnimation.h"
#import "GameUtil.h"
#import "GameScene.h"
#import "StageDebugLayer.h"

@implementation TitleLayer

+(CCScene *) scene {
	CCScene *scene = [CCScene node];
	TitleLayer *layer = [TitleLayer node];
    layer.scale = [PointUtil getScale];
	[scene addChild:layer];
	return scene;
}

- (id)init {
    self = [super init];
	if (self) {
        
        // 背景の追加
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCSprite *background = [CCSprite spriteWithFile:@"title_bg.png"];
        background.position = ccp(winSize.width / 2, winSize.height / 2);
        [self addChild:background];
        
        // ボタンの追加
        CCSpriteButton *playButton = [CCSpriteButton spriteWithSpriteFrameName:@"title_btn.png"];
        [PointUtil setTLPosition:playButton x:46 y:150];
        CCLabelTTF *playLabel = [LabelUtil createLabel:@"ぼうけんをする" fontSize:30 dimensions:CGSizeMake(320, 88) alignment:kCCTextAlignmentLeft];
        [playButton addLabel:playLabel offsetX:50 offsetY:0];
        [playButton addClickListner:self selector:@selector(clickPlayButton:)];
        [self addChild:playButton];
        
        CCSpriteButton *configButton = [CCSpriteButton spriteWithSpriteFrameName:@"title_btn.png"];
        [PointUtil setTLPosition:configButton x:46 y:238];
        CCLabelTTF *configLabel = [LabelUtil createLabel:@"せっていをかえる" fontSize:30 dimensions:CGSizeMake(320, 88) alignment:kCCTextAlignmentLeft];
        [configButton addLabel:configLabel offsetX:50 offsetY:0];
        [configButton addClickListner:self selector:@selector(clickConfigButton:)];
        [self addChild:configButton];
        
    }
    return self;
}

// ぼうけんをはじめる
- (void)clickPlayButton:(id)sender {
    [self addChild:[StageDebugLayer node]];
}

// せっていをかえる
- (void)clickConfigButton:(id)sender {
    [GameUtil replaceScene:[GameScene createInstance:1 isRandom:true]];
}

@end
