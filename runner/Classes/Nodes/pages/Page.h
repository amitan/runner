//
//  Page.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/16.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Block.h"

@interface Page : CCNode {
    
}
@property (nonatomic, readonly)BOOL isPlaying;

// アニメーションを開始/停止する
- (void)start;
- (void)stop;

// ページ幅を取得
- (float)getWidth;

// 衝突したブロックを取得する
- (Block*)getHitBlock:(CGPoint)point;

// コインを取得したか判定する
- (BOOL)checkHitCoins:(CGPoint)point;

@end
