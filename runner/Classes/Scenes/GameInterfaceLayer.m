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

@interface GameInterfaceLayer ()
@property (nonatomic, readwrite)BOOL _isAttacked;
@property (nonatomic, readwrite)CGPoint _touchStart;
@end

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

    self._isAttacked = false;
    self._touchStart = [self convertTouchToNodeSpace:touch];
    [[GameScene sharedInstance].playerController jump];
    
    // タッチイベントをこのメソッドで終了させる（他レイヤーのデリゲートメソッドは呼ばない）
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    if (!self._isAttacked) {
        CGPoint touchMove = [self convertTouchToNodeSpace:touch];
        if (abs(touchMove.x - self._touchStart.x) > [PointUtil getPoint:50]
            || abs(touchMove.y - self._touchStart.y) > [PointUtil getPoint:50]) {
            self._isAttacked = true;
            [[GameScene sharedInstance].playerController cancelJump];
            [[GameScene sharedInstance].playerController attack];
        }
    }
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    [[GameScene sharedInstance].playerController endJumpCancel];
}

@end
