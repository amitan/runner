//
//  GameResultLayer.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/29.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "GameResultLayer.h"
#import "CCSpriteButton.h"
#import "GameUtil.h"
#import "HomeScene.h"
#import "TitleLayer.h"
#import "PointUtil.h"
#import "LabelUtil.h"
#import "UserPlayer.h"
#import "PlayerMaster.h"

@interface GameResultLayer ()
@property (nonatomic, retain)CCSprite* _popupBaseSprite;
@property (nonatomic, readwrite)int _coin1, _coin2, _coin3, _distance;
@end

@implementation GameResultLayer

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
        self._popupBaseSprite = [CCSprite spriteWithSpriteFrameName:@"popup_large.png"];
        [PointUtil setTLPosition:self._popupBaseSprite x:60 y:154];
        [self addChild:self._popupBaseSprite];
    }
    return self;
}

- (void)setDistance:(int)distance {
    self._distance = distance;
}

- (void)setCoin:(int)coin1 player2Coin:(int)coin2 player3Coin:(int)coin3 {
    self._coin1 = coin1;
    self._coin2 = coin2;
    self._coin3 = coin3;
}

- (void)onEnter {
    [super onEnter];
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self
                                                              priority:0
                                                       swallowsTouches:YES];
    [self _showWindow];
}

- (void)_showWindow {
    
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    
    // 距離
    NSString *distance = [NSString stringWithFormat:@"RESULT: %d M", self._distance];
    CCLabelTTF *distanceLabel = [LabelUtil createLabel:distance fontSize:48 dimensions:CGSizeMake(500, 80) alignment:kCCTextAlignmentCenter];
    distanceLabel.position = [PointUtil getPosition:260 y:600];
    [self._popupBaseSprite addChild:distanceLabel];
    PlayerMaster *master = [PlayerMaster create];
    
    int intervalY = 130;
    int totalCoin = 0;
    for (int i = 0; i < 3; i++) {
        
        // プレイヤー情報取得
        int playerSequenceId = [[userDefaults objectForKey:[NSString stringWithFormat:@"player%d", i + 1]] intValue];
        NSMutableDictionary *userPlayer = [UserPlayer getUserPlayer:playerSequenceId];

        // コイン数決定
        int coinNum;
        switch (i + 1) {
            case 1:
                coinNum = self._coin1;
                break;
            case 2:
                coinNum = self._coin2;
                break;
            case 3:
                coinNum = self._coin3;
                break;
        }
        
        if (userPlayer) {
            
            // プレイヤー画像
            int playerId = [userPlayer[@"playerId"] intValue];
            CCSprite *playerImage = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"player%d_stand.png", playerId]];
            playerImage.position = [PointUtil getPosition:90 y:500 - i * intervalY];
            [self._popupBaseSprite addChild:playerImage];

            // 獲得コイン
            NSString *coinNumStr = [NSString stringWithFormat:@"COIN: %d G", coinNum];
            CCLabelTTF *coinLabel = [LabelUtil createLabel:coinNumStr fontSize:26 dimensions:CGSizeMake(400, 60) alignment:kCCTextAlignmentLeft];
            coinLabel.position = [PointUtil getPosition:360 y:530 - i * intervalY];
            [self._popupBaseSprite addChild:coinLabel];

            // コインボーナス
            int level = [userPlayer[@"level"] intValue];
            int coinBonus = [master getGoldBonus:playerId currentLevel:level];
            NSString *coinBonusStr = [NSString stringWithFormat:@"BONUS +%d%@", coinBonus, @"%"];
            CCLabelTTF *coinBonusLabel = [LabelUtil createLabel:coinBonusStr fontSize:26 dimensions:CGSizeMake(400, 60) alignment:kCCTextAlignmentLeft];
            coinBonusLabel.position = [PointUtil getPosition:360 y:500 - i * intervalY];
            [self._popupBaseSprite addChild:coinBonusLabel];

            // コイン合計
            float coinBonusFactor = (float)coinBonus / 100.0f + 1;
            int playerTotalCoin = floor((float)coinNum * coinBonusFactor);
            totalCoin += playerTotalCoin;
            
            NSString *playerTotalStr = [NSString stringWithFormat:@"TOTAL COIN: %d G", playerTotalCoin];
            CCLabelTTF *playerTotalLabel = [LabelUtil createLabel:playerTotalStr fontSize:30 dimensions:CGSizeMake(400, 60) alignment:kCCTextAlignmentLeft];
            playerTotalLabel.position = [PointUtil getPosition:360 y:460 - i * intervalY];
            [self._popupBaseSprite addChild:playerTotalLabel];
        }
    }
    NSString *totalCoinStr = [NSString stringWithFormat:@"TOTAL: %d G", totalCoin];
    CCLabelTTF *totalCoinLabel = [LabelUtil createLabel:totalCoinStr fontSize:42 dimensions:CGSizeMake(500, 80) alignment:kCCTextAlignmentCenter];
    totalCoinLabel.position = [PointUtil getPosition:260 y:100];
    [self._popupBaseSprite addChild:totalCoinLabel];
    
    // ゴールド設定
    int currentGold = [[userDefaults objectForKey:@"gold"] intValue];
    currentGold += totalCoin;
    [userDefaults setObject:[NSNumber numberWithInt:currentGold] forKey:@"gold"];
    [userDefaults synchronize];
}

- (void)onExit {
    [super onExit];
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    [GameUtil replaceScene:[HomeScene createInstance]];
    return YES;
}

@end
