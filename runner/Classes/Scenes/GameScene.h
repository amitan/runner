//
//  GameScene.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CountController.h"
#import "MapController.h"
#import "PlayerController.h"
#import "HudController.h"
#import "PageController.h"
#import "GameInterfaceLayer.h"

@interface GameScene : CCScene {
    
}
@property (nonatomic, retain)CCLayer *backgroundLayer;
@property (nonatomic, retain)CCLayer *mapLayer;
@property (nonatomic, retain)CCLayer *gameLayer;
@property (nonatomic, retain)CCLayer *hudLayer;
@property (nonatomic, retain)CCLayer *effectLayer;
@property (nonatomic, retain)GameInterfaceLayer *interfaceLayer;
@property (nonatomic, retain)CountController *countController;
@property (nonatomic, retain)MapController *mapController;
@property (nonatomic, retain)PlayerController *playerController;
@property (nonatomic, retain)HudController *hudController;
@property (nonatomic, retain)PageController *pageController;

// シングルトンオブジェクトを返すメソッド
+ (GameScene *)sharedInstance;

// シングルトンオブジェクトの有無に関わらずインスタンスを生成するメソッド
+ (GameScene *)createInstance:(int)worldId areaId:(int)areaId stageId:(int)stageId isRandom:(BOOL)isRandom;

// ゲームを開始/停止する
- (void)setup;
- (void)start;
- (void)stop;

// ゲームを終了する
- (void)finishGame;

@end
