//
//  HudController.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/17.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "HudController.h"
#import "GameScene.h"
#import "PointUtil.h"
#import "LabelUtil.h"
#import "ColorUtil.h"
#import "CommonAnimation.h"
#import "CCSpriteButton.h"
#import "Pause.h"

@interface HudController ()
@property (nonatomic, readwrite)int _coinNum;
@property (nonatomic, readwrite)float _dx;
@property (nonatomic, readwrite)int _currentDistance;
@property (nonatomic, retain)CCLabelTTF *_coinNumLabel;
@property (nonatomic, retain)CCLabelTTF *_distanceLabel;
@property (nonatomic, retain)CCSprite *_coinBonus;
@property (nonatomic, retain)CCLabelTTF *_coinBonusLabel;
@property (nonatomic, retain)CCSprite *_speedUp;
@property (nonatomic, retain)CCSpriteButton *_stopSprite, *_playSprite;
@property (nonatomic, readwrite)BOOL _isPausing;
@property (nonatomic, retain)Pause *_pause;
@end

@implementation HudController

- (id)init {
    self = [super init];
	if (self) {
        self._isPausing = false;
    }
    return self;
}

- (void)setup {
    
    // 距離表示追加
    self._distanceLabel = [LabelUtil createLabel:@"" fontSize:50];
    [PointUtil setPosition:self._distanceLabel x:320 y:156 offsetX:0 offsetY:0];
    [[GameScene sharedInstance].hudLayer addChild:self._distanceLabel];
    
    // コイン表示追加
    CCSprite *coinBaseSprite = [CCSprite spriteWithSpriteFrameName:@"coin_base.png"];
    [PointUtil setTLPosition:coinBaseSprite x:492 y:117];
    [[GameScene sharedInstance].hudLayer addChild:coinBaseSprite];
    
    self._coinNumLabel = [LabelUtil createLabel:@"" fontSize:30 dimensions:CGSizeMake(138, 54) alignment:kCCTextAlignmentRight];
    self._coinNumLabel.position = [PointUtil getPosition:40 y:22];
    [coinBaseSprite addChild:self._coinNumLabel];
    
    CCLabelTTF *coinUnit = [LabelUtil createLabel:@"G" fontSize:28];
    coinUnit.position = [PointUtil getPosition:122 y:20];
    [coinBaseSprite addChild:coinUnit];

    // スピードアップエフェクト追加
    self._speedUp = [CCSprite spriteWithSpriteFrameName:@"speed_up.png"];
    [PointUtil setTLPosition:self._speedUp x:179 y:174];
    self._speedUp.scale = 0;
    [[GameScene sharedInstance].hudLayer addChild:self._speedUp];

    // コインボーナスエフェクト追加
    self._coinBonus = [CCSprite spriteWithSpriteFrameName:@"coin_bonus.png"];
    [PointUtil setTLPosition:self._coinBonus x:BASE_WIDTH y:174];
    self._coinBonusLabel = [LabelUtil createLabel:@"" fontSize:42 dimensions:CGSizeMake(100, 30) alignment:kCCTextAlignmentLeft];
    self._coinBonusLabel.color = [ColorUtil getEffectOrangeFontColor];
    self._coinBonusLabel.position = [PointUtil getPosition:235 y:16];
    [self._coinBonus addChild:self._coinBonusLabel];
    self._coinBonus.visible = NO;
    [[GameScene sharedInstance].hudLayer addChild:self._coinBonus];
    
    // 停止/再生ボタン
    self._stopSprite = [CCSpriteButton spriteWithSpriteFrameName:@"stop_btn.png"];
    [self._stopSprite addClickListner:self selector:@selector(clickStopButton:)];
    [PointUtil setTLPosition:self._stopSprite x:10 y:110];
    [[GameScene sharedInstance].hudLayer addChild:self._stopSprite];    

    self._playSprite = [CCSpriteButton spriteWithSpriteFrameName:@"play_btn.png"];
    [self._playSprite addClickListner:self selector:@selector(clickPlayButton:)];
    [PointUtil setTLPosition:self._playSprite x:10 y:110];
    [[GameScene sharedInstance].hudLayer addChild:self._playSprite];

    // 停止ビュー
    self._pause = [Pause node];
    
    // 同期
    [self sync];
}

- (void)start {
}

- (void)stop {
}

- (void)sync {
    [self._coinNumLabel setString:[NSString stringWithFormat:@"%d", self._coinNum]];
    [self._distanceLabel setString:[NSString stringWithFormat:@"%dM", self._currentDistance]];
    if (self._isPausing) {
        self._stopSprite.visible = NO;
        self._playSprite.visible = YES;
        self._stopSprite.isEnabled = NO;
        self._playSprite.isEnabled = YES;
    } else {
        self._stopSprite.visible = YES;
        self._playSprite.visible = NO;
        self._stopSprite.isEnabled = YES;
        self._playSprite.isEnabled = NO;
    }
}

- (void)addCoin:(int)num {
    self._coinNum += num;
    [self sync];
}

- (void)addCoinBonus:(int)num {
    self._coinBonus.visible = YES;
    [self._coinBonusLabel setString:[NSString stringWithFormat:@"+%d", num]];
    [self._coinBonus runAction:[CommonAnimation getEffectAppearAction]];
    self._coinNum += num;
    [self sync];
}

- (void)addDistance:(float)dx {
    self._dx += dx;
    float nextDistance = [self getDistance];
    if (self._currentDistance != nextDistance) {
        self._currentDistance = nextDistance;
        [self sync];
    }
}

- (int)getDistance {
    return self._dx / 128.0f;
}

- (void)showSpeedUpEffect {
    [self._speedUp runAction:[CommonAnimation getSpeedUpAction]];
}

- (void)clickPlayButton:(id)sender {
    [self._pause stageOff];
    self._isPausing = false;
    [[GameScene sharedInstance] start];
    [self sync];
}

- (void)clickStopButton:(id)sender {
    self._isPausing = true;
    [[GameScene sharedInstance] stop];
    [self sync];
    [self._pause stageOn];
}

@end
