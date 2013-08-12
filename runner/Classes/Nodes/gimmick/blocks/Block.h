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
@property (nonatomic, retain)CCSprite *_sprite;

// 指定したブロックを生成する
+ (Block*)createBlock:(int)blockId;
+ (Block*)createBlock:(int)blockId x:(float)x y:(float)y;

// ブロックを指定して初期化する
-(id) initWithBlockId:(int)blockId;

// ブロックの幅/高さを取得する
- (float)getWidth;
- (float)getHeight;

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
