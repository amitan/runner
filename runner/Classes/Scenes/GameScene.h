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

@interface GameScene : CCScene {
    
}
@property (nonatomic, retain)CCLayer *backgroundLayer;
@property (nonatomic, retain)CCLayer *mapLayer;
@property (nonatomic, retain)CCLayer *gameLayer;
@property (nonatomic, retain)CCLayer *effectLayer;
@property (nonatomic, retain)CountController *countController;
@property (nonatomic, retain)MapController *mapController;
@property (nonatomic, retain)PlayerController *playerController;

// シングルトンオブジェクトを返すメソッド
+ (GameScene *)sharedInstance;

// シングルトンオブジェクトの有無に関わらずインスタンスを生成するメソッド
+ (GameScene *)createInstance:(int)worldId areaId:(int)areaId stageId:(int)stageId;

// ゲームを開始/停止する
- (void)setup;
- (void)start;
- (void)stop;

@end
