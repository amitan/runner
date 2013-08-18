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
#import "PlayerMaster.h"
#import "UserPlayer.h"

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
        
        // パーティ情報取得
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        PlayerMaster *master = [PlayerMaster create];
        for (int i = 0; i < 3; i++) {
            int playerSequenceId = [[userDefaults objectForKey:[NSString stringWithFormat:@"player%d", i + 1]] intValue];
            NSMutableDictionary *userPlayer = [UserPlayer getUserPlayer:playerSequenceId];
            
            if (userPlayer) {
                int playerId = [userPlayer[@"playerId"] intValue];
                NSString *name = [master getName:playerId];
                
                CCLabelTTF *playerNameLabel = [LabelUtil createLabel:name fontSize:26 dimensions:CGSizeMake(200, 70) alignment:kCCTextAlignmentCenter];
                playerNameLabel.position = [PointUtil getPosition:134 + i * 146 y:-28];
                [self addChild:playerNameLabel];
                
                NSString *level = [NSString stringWithFormat:@"Lv: %d", [userPlayer[@"level"] intValue]];
                CCLabelTTF *playerLevel = [LabelUtil createLabel:level fontSize:30 dimensions:CGSizeMake(200, 70) alignment:kCCTextAlignmentCenter];
                playerLevel.position = ccpAdd(playerNameLabel.position, [PointUtil getPosition:0 y:-30]);
                [self addChild:playerLevel];
            }
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
