//
//  HomeInterfaceLayer.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/13.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "HomeInterfaceLayer.h"


@implementation HomeInterfaceLayer

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
    
    // タッチイベントをこのメソッドで終了させる（他レイヤーのデリゲートメソッドは呼ばない）
    return YES;
}

@end
