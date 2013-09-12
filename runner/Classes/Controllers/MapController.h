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
#import "LandMap.h"
#import "SkyMap.h"

@interface MapController : CCNode {
    
}
@property (nonatomic, retain)LandMap *landMap;
@property (nonatomic, retain)SkyMap *skyMap;

// 動作を開始/停止する
- (void)setup:(int)stageId;
- (void)start;
- (void)stop;
- (void)suspend;
- (void)resume;

// 衝突しているブロック/エネミーを取得する
- (Block*)getHitBlock:(CGPoint)point;

// マップをスクロールする
- (void)scroll:(float)dx;
- (void)skyScroll:(float)dx;
- (void)flyUp;
- (void)flyDown;

@end
