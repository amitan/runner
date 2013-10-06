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
@property (nonatomic, readwrite)int _totalCoinNum;
@property (nonatomic, readwrite)float _dx, _skyDx, _landDx;
@property (nonatomic, readwrite)int _currentDistance, _exp, _maxExp;
@property (nonatomic, retain)CCLabelTTF *_coinNumLabel, *_distanceLabel;
@property (nonatomic, retain)CCSprite *_coinBonus;
@property (nonatomic, retain)CCLabelTTF *_coinBonusLabel, *_expLabel;
@property (nonatomic, retain)CCSprite *_speedUp, *_fever, *_expBar;
@property (nonatomic, retain)CCSpriteButton *_stopSprite;
@property (nonatomic, retain)Pause *_pause;
@end

@implementation HudController
const int COIN_BONUS_EFFECT_X = 300;
const float EXP_BAR_FULL = 234;
const float DISTANCE_FACTOR = 128.0f;
const int INIT_EXP = 30;

- (id)init {
    self = [super init];
	if (self) {
        self.isPausing = false;
        self._maxExp = INIT_EXP;
    }
    return self;
}

- (void)setup {
    
    // 距離表示追加
    self._distanceLabel = [LabelUtil createLabel:@"" fontSize:50];
    [PointUtil setPosition:self._distanceLabel x:480 y:66 offsetX:0 offsetY:0];
    [[GameScene sharedInstance].hudLayer addChild:self._distanceLabel];
    
    // コイン表示追加
    CCSprite *coinBaseSprite = [CCSprite spriteWithSpriteFrameName:@"coin_base.png"];
    [PointUtil setTLPosition:coinBaseSprite x:802 y:27];
    [[GameScene sharedInstance].hudLayer addChild:coinBaseSprite];
    
    self._coinNumLabel = [LabelUtil createLabel:@"" fontSize:30 dimensions:CGSizeMake(138, 54) alignment:kCCTextAlignmentRight];
    self._coinNumLabel.position = [PointUtil getPosition:40 y:22];
    [coinBaseSprite addChild:self._coinNumLabel];
    
    CCLabelTTF *coinUnit = [LabelUtil createLabel:@"G" fontSize:28];
    coinUnit.position = [PointUtil getPosition:122 y:20];
    [coinBaseSprite addChild:coinUnit];

    // 停止/再生ボタン
    self._stopSprite = [CCSpriteButton spriteWithSpriteFrameName:@"stop_btn.png"];
    [self._stopSprite addClickListner:self selector:@selector(clickStopButton:)];
    [PointUtil setTLPosition:self._stopSprite x:20 y:20];
    [[GameScene sharedInstance].hudLayer addChild:self._stopSprite];
    
    // スピードアップエフェクト追加
    self._speedUp = [CCSprite spriteWithSpriteFrameName:@"speed_up.png"];
    [PointUtil setTLPosition:self._speedUp x:339 y:84];
    self._speedUp.scale = 0;
    [[GameScene sharedInstance].hudLayer addChild:self._speedUp];

    // フィーバーエフェクト追加
    self._fever = [CCSprite spriteWithSpriteFrameName:@"fever.png"];
    self._fever.visible = NO;
    [PointUtil setTLPosition:self._fever x:106 y:34];
    [[GameScene sharedInstance].hudLayer addChild:self._fever];

    // コインボーナスエフェクト追加
    self._coinBonus = [CCSprite spriteWithSpriteFrameName:@"coin_bonus.png"];
    [PointUtil setTLPosition:self._coinBonus x:-COIN_BONUS_EFFECT_X y:100];
    self._coinBonusLabel = [LabelUtil createLabel:@"" fontSize:42 dimensions:CGSizeMake(100, 30) alignment:kCCTextAlignmentLeft];
    self._coinBonusLabel.color = [ColorUtil getEffectOrangeColor];
    self._coinBonusLabel.position = [PointUtil getPosition:235 y:16];
    [self._coinBonus addChild:self._coinBonusLabel];
    self._coinBonus.visible = NO;
    [[GameScene sharedInstance].hudLayer addChild:self._coinBonus];
    
    // expバー
    self._expBar = [CCSprite spriteWithSpriteFrameName:@"exp_bar_yellow.png"];
    self._expBar.scaleX = 0;
    self._expBar.anchorPoint = ccp(0, 0.5);
    [PointUtil setTLPosition:self._expBar x:246 y:580];
    [[GameScene sharedInstance].hudLayer addChild:self._expBar];
    
    CCSprite *expBarBase = [CCSprite spriteWithSpriteFrameName:@"exp_bar.png"];
    [PointUtil setTLPosition:expBarBase x:236 y:580];
    [[GameScene sharedInstance].hudLayer addChild:expBarBase];
    
    self._expLabel = [LabelUtil createLabel:@"" fontSize:28];
    self._expLabel.position = ccp(expBarBase.contentSize.width / 2, 2 * expBarBase.contentSize.height / 5);
    self._expLabel.color = [ColorUtil getEffectOrangeColor];
    [expBarBase addChild:self._expLabel];
    
    // 停止ビュー
    self._pause = [Pause node];
    
    // 同期
    [self sync];
}

- (void)dealloc {
    self._coinNumLabel = nil;
    self._distanceLabel = nil;
    self._coinBonus = nil;
    self._coinBonusLabel = nil;
    self._speedUp = nil;
    self._fever = nil;
    self._stopSprite = nil;
    self._pause = nil;
    [super dealloc];
}

- (void)start {
}

- (void)stop {
}

- (void)sync {
    [self._coinNumLabel setString:[NSString stringWithFormat:@"%d", self._totalCoinNum]];
    [self._distanceLabel setString:[NSString stringWithFormat:@"%dM", self._currentDistance]];
    if (self.isPausing) {
        self._stopSprite.visible = NO;
        self._stopSprite.isEnabled = NO;
    } else {
        self._stopSprite.visible = YES;
        self._stopSprite.isEnabled = YES;
    }
    [self._expLabel setString:[NSString stringWithFormat:@"%d/%d", self._exp, self._maxExp]];
    self._expBar.scaleX = EXP_BAR_FULL * self._exp / self._maxExp;
}

- (void)addCoin:(int)num {
    self._totalCoinNum += num;
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

- (void)addSkyDistance:(float)dx {
    self._skyDx += dx;
    [self addDistance:dx];
}

- (void)addLandDistance:(float)dx {
    self._landDx += dx;
    [self addDistance:dx];
}

- (int)getDistance {
    return self._dx / DISTANCE_FACTOR;
}

- (int)getSkyDistance {
    return self._skyDx / DISTANCE_FACTOR;
}

- (int)getLandDistance {
    return self._landDx / DISTANCE_FACTOR;
}

- (void)resetSkyDistance {
    self._skyDx = 0;
}

- (int)getTotalCoin {
    return self._totalCoinNum;
}

- (BOOL)addExp:(int)num {
    self._exp = min(self._exp + num, self._maxExp);
    [self sync];
    if (self._exp >= self._maxExp) {
        [[GameScene sharedInstance] fever];
        return true;
    }
    return false;
}

- (void)resetExp {
    self._exp = 0;
    self._maxExp *= 2.7;
}

- (void)fever {
    [self._fever runAction:[CommonAnimation getBlinkAction]];
}

- (void)stopFever {
    [self._fever stopAllActions];
    self._fever.visible = NO;
}

- (void)showSpeedUpEffect {
    [self._speedUp runAction:[CommonAnimation getNotificationAction]];
}

- (void)clickStopButton:(id)sender {
    self.isPausing = true;
    [[GameScene sharedInstance] suspend];
    [self sync];
    [self._pause stageOn];
}

@end
