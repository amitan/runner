//
//  GameInterfaceLayer.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/09.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "GameInterfaceLayer.h"
#import "GameScene.h"
#import "PointUtil.h"

@implementation GameInterfaceLayer

// 本クラスがアクティブなレイヤーに登録されたタイミングでタッチイベントの受信を開始する
- (void)onEnter {
    [super onEnter];
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self
                                                              priority:0
                                                    swallowsTouches:YES];
}

- (void)onExit {
    [super onExit];
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}


- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {

    [[GameScene sharedInstance].playerController jump];
    
    // タッチイベントをこのメソッドで終了させる（他レイヤーのデリゲートメソッドは呼ばない）
    return YES;
}

@end
