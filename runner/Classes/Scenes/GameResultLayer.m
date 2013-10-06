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
#import "TitleLayer.h"
#import "PointUtil.h"
#import "LabelUtil.h"
#import "UserPlayerDao.h"
#import "PlayerMaster.h"
#import "GameDao.h"
#import "UnitDao.h"

@interface GameResultLayer ()
@property (nonatomic, retain)CCSprite* _popupBaseSprite;
@property (nonatomic, readwrite)int _coinNum, _distance;
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

- (void)dealloc {
    self._popupBaseSprite = nil;
    [super dealloc];
}

- (void)setDistance:(int)distance {
    self._distance = distance;
}

- (void)setCoin:(int)coinNum {
    self._coinNum = coinNum;
}

- (void)onEnter {
    [super onEnter];
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self
                                                              priority:0
                                                       swallowsTouches:YES];
    [self _showWindow];
}

- (void)_showWindow {
    
    // 距離
    NSString *distance = [NSString stringWithFormat:@"RESULT: %d M", self._distance];
    CCLabelTTF *distanceLabel = [LabelUtil createLabel:distance fontSize:48 dimensions:CGSizeMake(500, 80) alignment:kCCTextAlignmentCenter];
    distanceLabel.position = [PointUtil getPosition:260 y:600];
    [self._popupBaseSprite addChild:distanceLabel];
    
    int intervalY = 130;
    int totalCoin = 0;
    for (int i = 0; i < 3; i++) {
        
        // プレイヤー情報取得
        int playerSequenceId = [UnitDao getUnitSequenceId:i + 1];
        NSMutableDictionary *userPlayer = [UserPlayerDao getUserPlayer:playerSequenceId];

        // コイン数決定
        if (userPlayer) {
            
            // プレイヤー画像
            int playerId = [userPlayer[@"playerId"] intValue];
            CCSprite *playerImage = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"player%d_stand.png", playerId]];
            playerImage.position = [PointUtil getPosition:90 y:500 - i * intervalY];
            [self._popupBaseSprite addChild:playerImage];

            // 獲得コイン
            NSString *coinNumStr = [NSString stringWithFormat:@"COIN: %d G", self._coinNum];
            CCLabelTTF *coinLabel = [LabelUtil createLabel:coinNumStr fontSize:26 dimensions:CGSizeMake(400, 60) alignment:kCCTextAlignmentLeft];
            coinLabel.position = [PointUtil getPosition:360 y:530 - i * intervalY];
            [self._popupBaseSprite addChild:coinLabel];

            // コインボーナス
            int level = [userPlayer[@"level"] intValue];
            int coinBonus = [[PlayerMaster getInstance] getGoldBonus:playerId currentLevel:level];
            NSString *coinBonusStr = [NSString stringWithFormat:@"BONUS +%d%@", coinBonus, @"%"];
            CCLabelTTF *coinBonusLabel = [LabelUtil createLabel:coinBonusStr fontSize:26 dimensions:CGSizeMake(400, 60) alignment:kCCTextAlignmentLeft];
            coinBonusLabel.position = [PointUtil getPosition:360 y:500 - i * intervalY];
            [self._popupBaseSprite addChild:coinBonusLabel];

            // コイン合計
            float coinBonusFactor = (float)coinBonus / 100.0f + 1;
            int playerTotalCoin = floor((float)self._coinNum * coinBonusFactor);
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
    [GameDao addGold:totalCoin];
}

- (void)onExit {
    [super onExit];
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    [GameUtil replaceScene:[TitleLayer scene]];
    return YES;
}

@end
