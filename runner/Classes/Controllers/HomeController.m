//
//  HomeController.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/13.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "HomeController.h"
#import "CCSpriteButton.h"
#import "PointUtil.h"
#import "GameUtil.h"
#import "HomeScene.h"
#import "GameScene.h"
#import "Door.h"
#import "Carpenter.h"
#import "Team.h"
#import "LevelupCounter.h"
#import "LabelUtil.h"
#import "HomeDebugLayer.h"
#import "GameDao.h"
#import "MonsterGifter.h"

@interface HomeController ()
@property (nonatomic, retain)Door *_door;
@property (nonatomic, retain)Carpenter *_carpenter;
@property (nonatomic, retain)Team *_team;
@property (nonatomic, retain)MonsterGifter *_gifter;
@property (nonatomic, retain)LevelupCounter *_levelupCounter;
@property (nonatomic, retain)HomeDebugLayer *_homeDebugLayer;
@end

@implementation HomeController

- (id)init {
    self = [super init];
	if (self) {
        
    }
    return self;
}

- (void)dealloc {
    self._door = nil;
    self._carpenter = nil;
    self._team = nil;
    self._gifter = nil;
    self._levelupCounter = nil;
    self._homeDebugLayer = nil;
    [super dealloc];
}

- (void)setup {
    
    // 進捗を取得
    int homeStep = [GameDao getHomeStep];
    
    // ドア追加
    self._door = [Door node];
    [PointUtil setTLPosition:self._door x:430 y:184];
    [[HomeScene sharedInstance].mainLayer addChild:self._door];
    
    // 大工追加
    if (homeStep <= 3) {
        self._carpenter = [Carpenter create:homeStep];
        [PointUtil setTLPosition:self._carpenter x:130 y:760];
        [[HomeScene sharedInstance].mainLayer addChild:self._carpenter];
    }
    
    // チームウィンドウ追加
    if (homeStep >= 2) {
        self._team = [Team node];
        [PointUtil setTLPosition:self._team x:80 y:190];
        [[HomeScene sharedInstance].mainLayer addChild:self._team];
    }
    
    // レベルアップカウンター追加
    if (homeStep >= 1) {
        self._levelupCounter = [LevelupCounter create:2];
        [PointUtil setTLPosition:self._levelupCounter x:280 y:294];
        [[HomeScene sharedInstance].mainLayer addChild:self._levelupCounter];
    }
    
    // テーブルといす追加
    if (homeStep >= 2) {
        CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:@"table.png"];
        [PointUtil setTLPosition:sprite x:320 y:500];
        [[HomeScene sharedInstance].mainLayer addChild:sprite];
        
        self._gifter = [MonsterGifter create:3];
        [PointUtil setTLPosition:self._gifter x:530 y:520];
        [[HomeScene sharedInstance].mainLayer addChild:self._gifter];
    }
    
    // デバッグボタン追加
    if (IS_SANDBOX) {
        CCSpriteButton *debugButton = [CCSpriteButton spriteWithSpriteFrameName:@"coin_base.png"];
        CCLabelTTF *debugLabel = [LabelUtil createLabel:@"DEBUG" fontSize:30];
        [debugButton addLabel:debugLabel];
        [PointUtil setTLPosition:debugButton x:0 y:100];
        [debugButton addClickListner:self selector:@selector(clickDebugButton:)];
        [[HomeScene sharedInstance].mainLayer addChild:debugButton];
        self._homeDebugLayer = [HomeDebugLayer node];
    }
}

- (void)clickDebugButton:(id)sender {
    [[HomeScene sharedInstance].popupLayer addChild:self._homeDebugLayer z:100];
}

- (void)start {
    [self._carpenter start];
    [self._levelupCounter start];
    [self._gifter start];
}

- (void)stop {
    [self._carpenter stop];
    [self._levelupCounter stop];
    [self._gifter stop];
}

- (void)suspend {
    [self stop];
}

- (void)resume {
    [self start];
}


@end
