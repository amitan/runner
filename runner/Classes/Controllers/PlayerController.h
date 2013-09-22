//
//  PlayerController.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface PlayerController : CCNode {
    
}

// 動作を開始/停止する
- (void)setup;
- (void)start;
- (void)stop;

// アクション
- (void)touchBegan;
- (void)touchEnd;
- (void)trampoline;
- (void)ride;
- (void)getOff:(CGPoint)position;
- (void)speedUp;
- (void)fly;
- (BOOL)deadIfBulletCollided:(CGPoint)position;
- (void)changePlayer:(int)crystalId;
- (void)backToDefaultPlayer;

// 取得
- (CGPoint)getPlayerFootPosition;

@end
