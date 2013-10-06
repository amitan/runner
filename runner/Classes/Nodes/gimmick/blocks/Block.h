//
//  Block.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/09.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Gimmick.h"

@interface Block : Gimmick {
    
}

// 地面種類
typedef enum {
    LAND_DEFAULT = 1280,
    LAND_LONG = 2560,
    LAND_2 = 120,
    LAND_4 = 240,
    LAND_6 = 360,
    LAND_8 = 480,
    LAND_12 = 720,
    LAND_16 = 960,
    LAND_24 = 1440,
    LAND_26 = 1560,
    LAND_30 = 1800,
} LAND_W;

// ブロック種類
typedef enum {
    B_STANDARD = 101,
    B_X2 = 102,
    B_X3 = 103,
    B_X4 = 104,
    B_X5 = 105,
    B_X6 = 106,
    B_X7 = 107,
    B_X8 = 108,
    B_X9 = 109,
    B_X10 = 110,
    B_X2Y2 = 301,
} BLOCK_TYPE;

// 指定したブロックを生成する
+ (Block*)createBlock:(int)blockId;
+ (Block*)createBlock:(int)blockId x:(float)x y:(float)y;
+ (Block*)createBlock:(int)blockId bx:(float)bx by:(float)by;

// ブロックを指定して初期化する
-(id) initWithBlockId:(int)blockId;

// 座標がブロックに含まれているか判定する
- (BOOL)isHit:(CGPoint)point;
- (BOOL)isHitByRect:(CGRect)rect;

// レイヤーベースの接地点座標を取得する
- (float)getLandPoint;
- (float)getBottomPoint;
- (float)getLeftPoint;
- (float)getRightPoint;

// 反転判定
- (BOOL)isLeftReverse;
- (BOOL)isRightReverse;


@end
