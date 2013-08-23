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
#import "UserPlayerDao.h"
#import "UnitDao.h"

@interface Team ()
@property (nonatomic, retain)TeamLayer *_teamLayer;
@end

@implementation Team

- (id)init {
    self = [super init];
	if (self) {
        
        // ベース追加
        CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:@"player_base_small.png"];
        sprite.position = ccp(sprite.contentSize.width / 2, - sprite.contentSize.height / 2);
        [self addChild:sprite];
        [self addClickListner:self selector:@selector(clickButton:)];
        [self._sprites addObject:sprite];
        
        // パーティ情報取得
        for (int i = 0; i < 3; i++) {
            int playerSequenceId = [UnitDao getUnitSequenceId:i + 1];
            NSMutableDictionary *userPlayer = [UserPlayerDao getUserPlayer:playerSequenceId];
            
            if (userPlayer) {
                int playerId = [userPlayer[@"playerId"] intValue];
                NSString *name = [[PlayerMaster getInstance] getName:playerId];
                
                CCLabelTTF *playerNameLabel = [LabelUtil createLabel:name fontSize:18 dimensions:CGSizeMake(200, 70) alignment:kCCTextAlignmentCenter];
                playerNameLabel.position = [PointUtil getPosition:60 + i * 96 y:-28];
                [self addChild:playerNameLabel];
                
                NSString *level = [NSString stringWithFormat:@"Lv: %d", [userPlayer[@"level"] intValue]];
                CCLabelTTF *playerLevel = [LabelUtil createLabel:level fontSize:24 dimensions:CGSizeMake(200, 70) alignment:kCCTextAlignmentCenter];
                playerLevel.position = ccpAdd(playerNameLabel.position, [PointUtil getPosition:0 y:-26]);
                [self addChild:playerLevel];
            }
        }

        // ポップアップレイヤーの初期化
        self._teamLayer = [TeamLayer node];
    }
    return self;
}

- (void)dealloc {
    self._teamLayer = nil;
    [super dealloc];
}

- (void)sync {
    
    // パーティ情報取得
    for (int i = 0; i < 3; i++) {
        int playerSequenceId = [UnitDao getUnitSequenceId:i + 1];
        NSMutableDictionary *userPlayer = [UserPlayerDao getUserPlayer:playerSequenceId];
        
        if (userPlayer) {
            int playerId = [userPlayer[@"playerId"] intValue];
            NSString *name = [[PlayerMaster getInstance] getName:playerId];
            
            CCLabelTTF *playerNameLabel = [LabelUtil createLabel:name fontSize:18 dimensions:CGSizeMake(200, 70) alignment:kCCTextAlignmentCenter];
            playerNameLabel.position = [PointUtil getPosition:60 + i * 96 y:-28];
            [self addChild:playerNameLabel];
            
            NSString *level = [NSString stringWithFormat:@"Lv: %d", [userPlayer[@"level"] intValue]];
            CCLabelTTF *playerLevel = [LabelUtil createLabel:level fontSize:24 dimensions:CGSizeMake(200, 70) alignment:kCCTextAlignmentCenter];
            playerLevel.position = ccpAdd(playerNameLabel.position, [PointUtil getPosition:0 y:-26]);
            [self addChild:playerLevel];
        }
    }
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
