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

// ジャンプ
- (void)jump;

// スピードアップ
- (void)speedUp;

// 仲間の移動座標を設定する
- (void)moveFollower:(int)order points:(NSMutableArray*)points;
- (void)followerUpdate;

@end
