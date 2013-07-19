//
//  MapController.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Block.h"
#import "Player.h"

@interface MapController : CCNode {
    
}

// 動作を開始/停止する
- (void)setup;
- (void)start;
- (void)stop;

// 衝突しているブロックを取得する
- (Block*)getHitBlock:(CGPoint)point;

// コインに衝突しているかチェックする
- (BOOL)checkHitCoins:(CGPoint)point;

// マップをスクロールする
- (void)scroll:(float)dx;

@end
