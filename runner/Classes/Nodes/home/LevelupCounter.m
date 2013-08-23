//
//  LevelupCounter.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/19.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "LevelupCounter.h"
#import "GameUtil.h"
#import "CommonAnimation.h"
#import "PointUtil.h"
#import "ConversationLayer.h"
#import "HomeController.h"
#import "HomeScene.h"
#import "PlayerSelectLayer.h"
#import "UserPlayerDao.h"
#import "PlayerMaster.h"
#import "GameDao.h"

@interface LevelupCounter ()
@property (nonatomic, readwrite)int _nodeId;
@property (nonatomic, readwrite)int _direction;
@property (nonatomic, retain)CCSprite *_character;
@property (nonatomic, retain)ConversationLayer *_conversationLayer;
@property (nonatomic, retain)PlayerSelectLayer *_playerSelectLayer;
@end

@implementation LevelupCounter

+ (LevelupCounter*)create:(int)nodeId {
    return [[[self alloc] initWithNodeId:nodeId] autorelease];
}

- (id)initWithNodeId:(int)nodeId {
    self = [super init];
	if (self) {
        
        // 初期値設定
        self._nodeId = nodeId;
        self._direction = BOTTOM;
        
        // アニメーションの最初のコマを読み込む
        NSString* fileName = [NSString stringWithFormat:@"towner%d_%@1.png", self._nodeId, [GameUtil getDirectionStr:self._direction]];
        self._character = [CCSprite spriteWithSpriteFrameName:fileName];
        [self addChild:self._character];
        [self._sprites addObject:self._character];
        
        // カウンター追加
        CCSprite *counter = [CCSprite spriteWithSpriteFrameName:@"levelup_counter.png"];
        counter.position = [PointUtil getPosition:0 y:-38];
        [self addChild:counter];
        [self._sprites addObject:counter];
        
        // キャラクターおよびカウンタークリック時
        [self addClickListner:self selector:@selector(clickButton:)];
        
        // ポップアップレイヤーの初期化
        self._conversationLayer = [ConversationLayer node];
        self._playerSelectLayer = [PlayerSelectLayer node];
        self._playerSelectLayer.orderNo = 4;
    }
    return self;
}

- (void)dealloc {
    self._character = nil;
    self._conversationLayer = nil;
    self._playerSelectLayer = nil;
    [super dealloc];
}

- (void)clickButton:(id)sender {
    
    // 会話設定
    HomeController *homeController = [HomeScene sharedInstance].homeController;
    NSMutableArray *conversationTexts = [NSMutableArray arrayWithObjects:
                                         @"兵士「ここは訓練所である。訓練をうけるものは1歩前へ！」", nil];
    [self._conversationLayer setTexts:conversationTexts];
    [self._conversationLayer addCompleteListner:self selector:@selector(onConversationClose:)];
    
    // 会話レイヤー表示
    [homeController suspend];
    [[HomeScene sharedInstance].popupLayer addChild:self._conversationLayer z:100];
}

- (void)start {
    NSString *fileName = [NSString stringWithFormat:@"towner%d_%@", self._nodeId, [GameUtil getDirectionStr:self._direction]];
    [self._character runAction:[CommonAnimation getFrameRepeatAction:fileName frameNum:2 duration:0.5f]];
}

- (void)stop {
    [self._character stopAllActions];
}

// 初回会話終了時
- (void)onConversationClose:(id)sender {
    
    [self._playerSelectLayer addCompleteListner:self selector:@selector(onPlayerSelectClose:sequenceNumber:)];
    [[HomeScene sharedInstance].popupLayer addChild:self._playerSelectLayer z:100];
}

// プレイヤー選択終了時
- (void)onPlayerSelectClose:(id)sender sequenceNumber:(NSNumber*)sequenceNumber {
    
    // レベルアップ
    int sequenceId = [sequenceNumber intValue];
    NSMutableDictionary *userPlayer = [UserPlayerDao getUserPlayer:sequenceId];
    if (userPlayer) {
        int currentLevel = [userPlayer[@"level"] intValue];
        int newLevel = currentLevel + 1;
        int playerId = [userPlayer[@"playerId"] intValue];
        int gold = [GameDao getGold];
        int nextGold = [[PlayerMaster getInstance] getNextGold:playerId currentLevel:currentLevel];

        if (gold >= nextGold) {
        
            // レベル更新
            [userPlayer setObject:[NSNumber numberWithInt:newLevel] forKey:@"level"];
            [UserPlayerDao updateUserPlayer:userPlayer];
            
            // ゴールド更新
            [GameDao useGold:nextGold];
            
            NSString *name = [[PlayerMaster getInstance] getName:playerId];
            int oldGoldBonus = [[PlayerMaster getInstance] getGoldBonus:playerId currentLevel:currentLevel];
            int newGoldBonus = [[PlayerMaster getInstance] getGoldBonus:playerId currentLevel:newLevel];
            int goldBonusDiff = newGoldBonus - oldGoldBonus;
            [self._conversationLayer setTexts:[NSMutableArray arrayWithObjects:
                [NSString stringWithFormat:@"%@ はレベルが %d にあがった！\nゴールドボーナスが %d%@ アップした！", name, newLevel, goldBonusDiff, @"%"],
                @"兵士「そこまで！常に研鑽を怠るなよ。」", nil]];
            
        } else {
            [self._conversationLayer setTexts:[NSMutableArray arrayWithObjects:
                                               @"兵士「ゴールドが足りないぞ！」", nil]];
        }
        
    } else {
        [self._conversationLayer setTexts:[NSMutableArray arrayWithObjects:
                                           @"兵士「了解した。訓練を一時中止する。」", nil]];
    }
    [self._conversationLayer addCompleteListner:self selector:@selector(onCompleteConversation:)];
    [[HomeScene sharedInstance].popupLayer addChild:self._conversationLayer z:100];
}

// レベルアップ後会話終了時
- (void)onCompleteConversation:(id)sender {
    [[HomeScene sharedInstance].homeController resume];
}

@end
