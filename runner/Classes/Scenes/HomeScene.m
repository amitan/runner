//
//  HomeScene.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/13.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "HomeScene.h"
#import "GameUtil.h"
#import "PointUtil.h"
#import "ConversationLayer.h"

@interface HomeScene ()
@property (nonatomic, readwrite)BOOL _isSetup;
@end

@implementation HomeScene

static HomeScene *_scene = nil;

+ (HomeScene *)sharedInstance {
	return _scene;
}

+ (HomeScene *)createInstance {
    if (_scene != nil) {
        _scene = nil;
    }
    _scene = [[[self alloc] init] autorelease];
	return _scene;
}

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期値を追加
        self._isSetup = false;
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        // 背景を設定
        self.backgroundLayer = [CCLayer node];
        self.backgroundLayer.scale = [PointUtil getScale];
        [self addChild:self.backgroundLayer];
        
        // 背景画像を追加
        NSString *bgName = [GameUtil getBgSpriteName:@"home_bg" ext:@"png"];
        CCSprite *background = [CCSprite spriteWithFile:bgName];
        background.position = ccp(winSize.width / 2, winSize.height / 2);
        [self.backgroundLayer addChild:background];

        // メインレイヤーを追加
        self.mainLayer = [CCLayer node];
        [self.backgroundLayer addChild:self.mainLayer];
        
        // ユーザーの入力を受け付けるレイヤーを追加
        self.interfaceLayer = [HomeInterfaceLayer node];
        [self.backgroundLayer addChild:self.interfaceLayer];

        // ポップアップレイヤーを追加
        self.popupLayer = [CCLayer node];
        [self.backgroundLayer addChild:self.popupLayer];
        
        // 管理クラスを設定
        self.homeController = [HomeController node];
        [self addChild:self.homeController z:-1];
        
    }
    return self;
}

// TODO:: deallocの実装
- (void)dealloc {
    [self stop];
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
    [self.homeController setup];
}

- (void)start {
    [self.homeController start];
}

- (void)stop {
    [self.homeController stop];
}

@end
