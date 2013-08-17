//
//  HomeScene.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/13.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "HomeInterfaceLayer.h"
#import "HomeController.h"

@interface HomeScene : CCScene {
    
}
@property (nonatomic, retain)CCLayer *backgroundLayer;
@property (nonatomic, retain)CCLayer *mainLayer;
@property (nonatomic, retain)CCLayer *popupLayer;
@property (nonatomic, retain)HomeInterfaceLayer *interfaceLayer;
@property (nonatomic, retain)HomeController *homeController;

// シングルトンオブジェクトを返すメソッド
+ (HomeScene *)sharedInstance;

// シングルトンオブジェクトの有無に関わらずインスタンスを生成するメソッド
+ (HomeScene *)createInstance;

// 開始/停止する
- (void)setup;
- (void)start;
- (void)stop;

@end
