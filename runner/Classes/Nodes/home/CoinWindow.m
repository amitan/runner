//
//  CoinWindow.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/21.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "CoinWindow.h"
#import "LabelUtil.h"
#import "PointUtil.h"
#import "GameDao.h"

@interface CoinWindow ()
@property (nonatomic, retain)CCLabelTTF *_coinNumLabel;
@end

@implementation CoinWindow

- (id)init {
    self = [super init];
	if (self) {
        
        // コイン表示追加
        CCSprite *coinBaseSprite = [CCSprite spriteWithSpriteFrameName:@"coin_base.png"];
        [self addChild:coinBaseSprite];
        
        self._coinNumLabel = [LabelUtil createLabel:@"" fontSize:30 dimensions:CGSizeMake(138, 54) alignment:kCCTextAlignmentRight];
        self._coinNumLabel.position = [PointUtil getPosition:40 y:22];
        [coinBaseSprite addChild:self._coinNumLabel];
        
        CCLabelTTF *coinUnit = [LabelUtil createLabel:@"G" fontSize:28];
        coinUnit.position = [PointUtil getPosition:122 y:20];
        [coinBaseSprite addChild:coinUnit];
    }
    return self;
}

- (void)dealloc {
    self._coinNumLabel = nil;
    [super dealloc];
}

- (void)sync {
    int gold = [GameDao getGold];
    [self._coinNumLabel setString:[NSString stringWithFormat:@"%d", gold]];
}

@end
