//
//  HeaderController.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/17.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "HeaderController.h"
#import "GameScene.h"
#import "PointUtil.h"
#import "LabelUtil.h"
#import "ColorUtil.h"
#import "CommonAnimation.h"

@interface HeaderController ()
@property (nonatomic, readwrite)int _coinNum;
@property (nonatomic, readwrite)float _dx;
@property (nonatomic, readwrite)int _currentDistance;
@property (nonatomic, retain)CCLabelTTF *_coinNumLabel;
@property (nonatomic, retain)CCLabelTTF *_distanceLabel;
@property (nonatomic, retain)CCSprite *_coinBonus;
@property (nonatomic, retain)CCLabelTTF *_coinBonusLabel;
@property (nonatomic, retain)CCSprite *_speedUp;
@end

@implementation HeaderController

- (id)init {
    self = [super init];
	if (self) {
    }
    return self;
}

- (void)setup {
    
    // 距離表示追加
    self._distanceLabel = [LabelUtil createLabel:@"" fontSize:50];
    [PointUtil setPosition:self._distanceLabel x:320 y:146 offsetX:0 offsetY:0];
    [[GameScene sharedInstance].hudLayer addChild:self._distanceLabel];
    
    // コイン表示追加
    CCSprite *coinBaseSprite = [CCSprite spriteWithSpriteFrameName:@"coin_base.png"];
    [PointUtil setTLPosition:coinBaseSprite x:492 y:110];
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

@end
