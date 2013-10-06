//
//  GameScene.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "GameScene.h"
#import "PointUtil.h"
#import "GameUtil.h"
#import "GameResultLayer.h"

@interface GameScene ()
@property (nonatomic, readwrite)int _stageId;
@property (nonatomic, readwrite)BOOL _isSetup;
@property (nonatomic, readwrite)BOOL _isRandom;
@end

@implementation GameScene
@synthesize backgroundLayer, mapLayer, gameLayer;
@synthesize hudLayer, effectLayer;
@synthesize interfaceLayer;
@synthesize countController, mapController, playerController;
@synthesize hudController, pageController;

static GameScene *_scene = nil;

+ (GameScene *)sharedInstance {
	return _scene;
}

+ (GameScene *)createInstance:(int)stageId isRandom:(BOOL)isRandom {
    if (_scene != nil) {
        _scene = nil;
    }
    _scene = [[[self alloc] initWithStage:stageId isRandom:isRandom] autorelease];
	return _scene;
}

- (id)initWithStage:(int)stageId isRandom:isRandom {
    self = [super init];
	if (self) {
        
        // 初期値を追加
        self._stageId = stageId;
        self._isRandom = isRandom;
        self._isSetup = false;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        // 背景を設定
        self.backgroundLayer = [CCLayer node];
        self.backgroundLayer.scale = [PointUtil getScale];
        [self addChild:self.backgroundLayer];

        // 背景画像を追加
        NSString *bgName = [GameUtil getBgSpriteName:@"game_bg" ext:@"png"];
        CCSprite *background = [CCSprite spriteWithFile:bgName];
        background.position = ccp(winSize.width / 2, winSize.height / 2);
        [self.backgroundLayer addChild:background];

        // マップレイヤーを追加
        self.mapLayer = [CCLayer node];
        [self.backgroundLayer addChild:self.mapLayer];

        // ゲームレイヤーを追加
        self.gameLayer = [CCLayer node];
        [self.backgroundLayer addChild:self.gameLayer];

        // ヘッダー・フッターレイヤーを追加
        self.hudLayer = [CCLayer node];
        [self.backgroundLayer addChild:self.hudLayer];

        // エフェクトレイヤーを追加
        self.effectLayer = [CCLayer node];
        [self.backgroundLayer addChild:self.effectLayer];

        // ユーザーの入力を受け付けるレイヤーを追加
        self.interfaceLayer = [GameInterfaceLayer node];
        [self.backgroundLayer addChild:self.interfaceLayer];

        // 管理クラスを設定
        self.countController = [CountController node];
        [self.countController addEndListner:self selector:@selector(onGameStart:)];
        self.mapController = [MapController node];
        self.playerController = [PlayerController node];
        self.hudController = [HudController node];
        self.pageController = [PageController node];
        [self addChild:self.countController z:-1];
        [self addChild:self.mapController z:-1];
        [self addChild:self.playerController z:-1];
        [self addChild:self.hudController z:-1];
        [self addChild:self.pageController z:-1];
    }
    return self;
}

// TODO:: deallocの実装
- (void)dealloc {
    [self stop];
    self.backgroundLayer = nil;
    self.mapLayer = nil;
    self.gameLayer = nil;
    self.hudLayer = nil;
    self.effectLayer = nil;
    self.interfaceLayer = nil;
    self.countController = nil;
    self.mapController = nil;
    self.playerController = nil;
    self.hudController = nil;
    self.pageController = nil;
    [super dealloc];
}

- (void)onEnter {
    [super onEnter];
    if (!self._isSetup) {
        self._isSetup = true;
        [self setup];
    }
    [self start];
}

- (void)onExit {
    [super onExit];
    [self stop];
}

- (void)setup {
    [self.countController setup];
    [self.mapController setup:self._stageId];
    [self.hudController setup];
    [self.playerController setup];
}

- (void)start {
    [self.countController start];
}

- (void)onGameStart:(id)sender {
    [self gameStart];
}

- (void)gameStart {
    [self.mapController start];
    [self.hudController start];
    [self.playerController start];    
}

- (void)resume {
    [self.mapController resume];
    [self.hudController start];
    [self.playerController start];    
}

- (void)suspend {
    [self.countController stop];
    [self.mapController suspend];
    [self.hudController stop];
    [self.playerController stop];
}

- (void)stop {
    [self.countController stop];
    [self.mapController stop];
    [self.hudController stop];
    [self.playerController stop];
}

- (void)finishGame {
    [self stop];
    
    // ゲーム結果ウィンドウを表示
    GameResultLayer *gameResultLayer = [GameResultLayer node];
    [gameResultLayer setDistance:[self.hudController getDistance]];
    [gameResultLayer setCoin:[self.hudController getTotalCoin]];
    [self.backgroundLayer addChild:gameResultLayer];
}

- (void)fever {
    [self.hudController fever];
    [self.mapController.landMap clearBullets];
    [self.playerController ride];
}

@end
