//
//  TeamLayer.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/17.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "TeamLayer.h"
#import "GameUtil.h"
#import "PointUtil.h"
#import "CCSpriteButton.h"
#import "ColorUtil.h"
#import "LabelUtil.h"
#import "PlayerSelectLayer.h"
#import "HomeScene.h"
#import "UserPlayerDao.h"
#import "PlayerMaster.h"
#import "UnitDao.h"

@interface TeamLayer ()
@property (nonatomic, retain)NSInvocation* _listener;
@property (nonatomic, retain)PlayerSelectLayer *_playerSelectLayer;
@property (nonatomic, retain)PlayerMaster *_playerMaster;
@end

@implementation TeamLayer

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
        
        // パーティ情報取得
        for (int i = 0; i < 3; i++) {
            
            // ベース画像設定
            CCSpriteButton *baseButton = [CCSpriteButton spriteWithSpriteFrameName:@"player_base_middle.png"];
            baseButton.position = [PointUtil getPosition:260 y:580 - i * 230];
            [baseButton addClickListner:self selector:@selector(clickPlayerButton:)];
            [popupBaseSprite addChild:baseButton];
            baseButton.tag = i + 1;
            baseButton.property = POPUP_PRIORITY - 1;

            // プレイヤー情報取得
            int playerSequenceId = [UnitDao getUnitSequenceId:i + 1];
            NSMutableDictionary *userPlayer = [UserPlayerDao getUserPlayer:playerSequenceId];
            
            if (userPlayer) {
                
                // プレイヤー画像
                int playerId = [userPlayer[@"playerId"] intValue];
                CCSprite *playerImage = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"player%d_stand.png", playerId]];
                playerImage.position = [PointUtil getPosition:62 y:174];
                [baseButton addChild:playerImage];

                // プレイヤー名とレベル
                NSString *name = [self._playerMaster getName:playerId];
                int level = [userPlayer[@"level"] intValue];
                int maxLevel = [self._playerMaster getMaxLevel:playerId];
                NSString *playerName = [NSString stringWithFormat:@"%@ Lv: %d/%d", name, level, maxLevel];
                CCLabelTTF *playerNameLabel = [LabelUtil createLabel:playerName fontSize:26 dimensions:CGSizeMake(386, 60) alignment:kCCTextAlignmentLeft];
                playerNameLabel.position = [PointUtil getPosition:307 y:190];
                [baseButton addChild:playerNameLabel];

                // 次のレベルまでのゴールド
                NSString *nextGold = [NSString stringWithFormat:@"次のレベルまであと %d G", [self._playerMaster getNextGold:playerId currentLevel:level]];
                CCLabelTTF *nextLevelLabel = [LabelUtil createLabel:nextGold fontSize:26 dimensions:CGSizeMake(386, 60) alignment:kCCTextAlignmentLeft];
                nextLevelLabel.position = ccpAdd(playerNameLabel.position, [PointUtil getPosition:0 y:-42]);
                [baseButton addChild:nextLevelLabel];

                // ゴールドボーナス
                NSString *goldBonus = [NSString stringWithFormat:@"ゴールドボーナス: +%d%@", [self._playerMaster getGoldBonus:playerId currentLevel:level], @"%"];
                CCLabelTTF *goldBonusLabel = [LabelUtil createLabel:goldBonus fontSize:26 dimensions:CGSizeMake(386, 60) alignment:kCCTextAlignmentLeft];
                goldBonusLabel.position = [PointUtil getPosition:213 y:100];;
                [baseButton addChild:goldBonusLabel];

                CCLabelTTF *item1 = [LabelUtil createLabel:@"アイテムボーナス: 特になし" fontSize:26 dimensions:CGSizeMake(386, 60) alignment:kCCTextAlignmentLeft];
                item1.position = ccpAdd(goldBonusLabel.position, [PointUtil getPosition:0 y:-32]);
                [baseButton addChild:item1];

                CCLabelTTF *special1 = [LabelUtil createLabel:@"とくぎ: 特になし" fontSize:26 dimensions:CGSizeMake(386, 60) alignment:kCCTextAlignmentLeft];
                special1.position = ccpAdd(item1.position, [PointUtil getPosition:0 y:-32]);
                [baseButton addChild:special1];
            }
        }
        
        // ポップアップレイヤーの初期化
        self._playerSelectLayer = [PlayerSelectLayer node];
    }
    return self;
}

- (void)clickPlayerButton:(id)sender {
    CCSpriteButton *senderButoom = (CCSpriteButton*)sender;
    self._playerSelectLayer.orderNo = senderButoom.tag;
    [self._playerSelectLayer addCompleteListner:self selector:@selector(onConversationClose:sequenceNumber:)];
    [[HomeScene sharedInstance].homeController suspend];
    [[HomeScene sharedInstance].popupLayer addChild:self._playerSelectLayer z:100];
}

- (void)onConversationClose:(id)sender sequenceNumber:(NSNumber*)sequenceNumber {
    [[HomeScene sharedInstance].homeController resume];
    // TODO: 編成処理
}


- (void)dealloc {
    self._listener = nil;
    self._playerSelectLayer = nil;
    self._playerMaster = nil;
    [super dealloc];
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

- (void)addCompleteListner:(id)target selector:(SEL)selector {
	if( target && selector ) {
		NSMethodSignature *signature = [[target class] instanceMethodSignatureForSelector:selector];
		self._listener = [NSInvocation invocationWithMethodSignature:signature];
		[self._listener setTarget:target];
		[self._listener setSelector:selector];
        [self._listener setArgument:&self atIndex:2];
	}
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    if (self._listener) {
        [self._listener invoke];
    }
    [self removeFromParentAndCleanup:NO];
}

@end
