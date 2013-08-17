//
//  Team.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/17.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Team.h"
#import "PointUtil.h"
#import "LabelUtil.h"
#import "TeamLayer.h"
#import "HomeScene.h"

@interface Team ()
@property (nonatomic, retain)TeamLayer *_teamLayer;
@end

@implementation Team

- (id)init {
    self = [super init];
	if (self) {
        self._sprite = [CCSprite spriteWithSpriteFrameName:@"player_base_small.png"];
        self._sprite.position = ccp(self._sprite.contentSize.width / 2, - self._sprite.contentSize.height / 2);
        [self addChild:self._sprite];
        [self addClickListner:self selector:@selector(clickButton:)];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        int playerId1 = [[userDefaults objectForKey:@"player1"] intValue];
        int playerId2 = [[userDefaults objectForKey:@"player2"] intValue];
        int playerId3 = [[userDefaults objectForKey:@"player3"] intValue];
        CCSprite *player1 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"player%d_stand.png", playerId1]];
        player1.position = [PointUtil getPosition:134 y:-52];
        [self addChild:player1];
        
        CCLabelTTF *player1Name = [LabelUtil createLabel:@"ゆうしゃ" fontSize:26 dimensions:CGSizeMake(200, 70) alignment:kCCTextAlignmentCenter];
        player1Name.position = ccp(player1.contentSize.width / 2, [PointUtil getPoint:74]);
        [player1 addChild:player1Name];

        CCLabelTTF *player1Level = [LabelUtil createLabel:@"Lv: 1" fontSize:30 dimensions:CGSizeMake(200, 70) alignment:kCCTextAlignmentCenter];
        player1Level.position = ccp(player1.contentSize.width / 2, [PointUtil getPoint:10]);
        [player1 addChild:player1Level];

        if (playerId2) {
            CCSprite *player2 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"player%d_stand.png", playerId2]];
            player2.position = [PointUtil getPosition:280 y:-52];
            [self addChild:player2];
            
            CCLabelTTF *player2Name = [LabelUtil createLabel:@"スライム" fontSize:26 dimensions:CGSizeMake(200, 70) alignment:kCCTextAlignmentCenter];
            player2Name.position = ccp(player2.contentSize.width / 2, [PointUtil getPoint:74]);
            [player2 addChild:player2Name];
            
            CCLabelTTF *player2Level = [LabelUtil createLabel:@"Lv: 2" fontSize:30 dimensions:CGSizeMake(200, 70) alignment:kCCTextAlignmentCenter];
            player2Level.position = ccp(player2.contentSize.width / 2, [PointUtil getPoint:10]);
            [player2 addChild:player2Level];
        }

        if (playerId3) {
            CCSprite *player3 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"player%d_stand.png", playerId3]];
            player3.position = [PointUtil getPosition:426 y:-52];
            [self addChild:player3];
            
            CCLabelTTF *player3Name = [LabelUtil createLabel:@"きのころ" fontSize:26 dimensions:CGSizeMake(200, 70) alignment:kCCTextAlignmentCenter];
            player3Name.position = ccp(player3.contentSize.width / 2, [PointUtil getPoint:74]);
            [player3 addChild:player3Name];
            
            CCLabelTTF *player3Level = [LabelUtil createLabel:@"Lv: 3" fontSize:30 dimensions:CGSizeMake(200, 70) alignment:kCCTextAlignmentCenter];
            player3Level.position = ccp(player3.contentSize.width / 2, [PointUtil getPoint:10]);
            [player3 addChild:player3Level];
        }

        // ポップアップレイヤーの初期化
        self._teamLayer = [TeamLayer node];
    }
    return self;
}

- (void)clickButton:(id)sender {
    [self._teamLayer addCompleteListner:self selector:@selector(onConversationClose:)];
    [[HomeScene sharedInstance].homeController suspend];
    [[HomeScene sharedInstance].popupLayer addChild:self._teamLayer z:100];
}

- (void)onConversationClose:(id)sender {
    [[HomeScene sharedInstance].homeController resume];
}

@end
