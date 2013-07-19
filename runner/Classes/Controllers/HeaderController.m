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

@interface HeaderController ()
@property (nonatomic, retain)CCLabelTTF *_coinNumLabel;
@end

@implementation HeaderController
@synthesize coinNum;

- (id)init {
    self = [super init];
	if (self) {
    }
    return self;
}

- (void)setup {
    
    // ヘッダー背景を追加
    CCSprite *coinBaseSprite = [CCSprite spriteWithSpriteFrameName:@"header_coin.png"];
    [PointUtil setTLPosition:coinBaseSprite x:492 y:110];
    [[GameScene sharedInstance].hudLayer addChild:coinBaseSprite];
    
    // コイン追加
    self._coinNumLabel = [LabelUtil createLabel:@"" fontSize:30 dimensions:CGSizeMake(138, 54) alignment:kCCTextAlignmentRight];
    self._coinNumLabel.position = [PointUtil getPosition:40 y:22];
    [coinBaseSprite addChild:self._coinNumLabel];
    
    CCLabelTTF *coinUnit = [LabelUtil createLabel:@"G" fontSize:28];
    coinUnit.position = [PointUtil getPosition:122 y:20];
    [coinBaseSprite addChild:coinUnit];
    
    // 同期
    [self sync];
}

- (void)start {
}

- (void)stop {
}

- (void)sync {
    [self._coinNumLabel setString:[NSString stringWithFormat:@"%d", self.coinNum]];
}
@end
