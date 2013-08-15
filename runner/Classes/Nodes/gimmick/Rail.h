//
//  Rail.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/12.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Gimmick.h"

@interface Rail : Gimmick {
    
}
@property (nonatomic, readwrite)int _railId;
@property (nonatomic, readwrite)BOOL isSwitched;

// 指定したレールを生成する
+ (Rail*)createRail:(int)railId rotation:(float)rotation;
+ (Rail*)createRail:(int)railId rotation:(float)rotation x:(float)x y:(float)y;

// レールを指定して初期化する
-(id)initWithRailId:(int)railId rotation:(float)rotation;

// 衝突判定
- (BOOL)isHit:(CGRect)rect;

// ロープ移動
- (BOOL)isRopeMovable;
- (CGPoint)moveRope:(float)dx;

@end
