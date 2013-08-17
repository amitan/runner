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
#import "Map.h"

@interface MapController : CCNode {
    
}
@property (nonatomic, retain)Map *map;

// 動作を開始/停止する
- (void)setup:(int)stageId;
- (void)start;
- (void)stop;

// 衝突しているブロック/エネミーを取得する
- (Block*)getHitBlock:(CGPoint)point;

// マップをスクロールする
- (void)scroll:(float)dx;

@end
