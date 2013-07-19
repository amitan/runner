//
//  Block.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/09.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Block : CCNode {
    
}

// 指定したブロックを生成する
+ (Block*)createBlock:(int)blockId;

// ブロックを指定して初期化する
-(id) initWithBlockId:(int)blockId;

// ブロックの幅/高さを取得する
- (float)getWidth;
- (float)getHeight;

// 座標がブロックに含まれているか判定する
- (BOOL)isHit:(CGPoint)point;

// レイヤーベースの接地点座標を取得する
- (float)getLandPoint;
- (float)getLeftPoint;

@end
