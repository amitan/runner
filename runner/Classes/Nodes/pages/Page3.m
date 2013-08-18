//
//  Page3.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/20.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page3.h"
#import "PointUtil.h"
#import "Enemy.h"

// 敵敵敵 -> ブロック（下にコイン）
@implementation Page3

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期設定
        self._enemies = [NSMutableArray arrayWithCapacity:2];
        
        // 地面を追加
        self._land = [Block createBlock:1];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        // 敵を追加
        self._enemies = @[[Enemy createEnemy:1 x:184 y:-715],
                         [Enemy createEnemy:1 x:268 y:-715],
                         [Enemy createEnemy:1 x:352 y:-715]];
        for (Enemy *enemy in self._enemies) {
            [enemy stageOn:self];
        }
        
        // ブロック追加
        self._blocks = @[[Block createBlock:101 x:792 y:-600],
                        [Block createBlock:101 x:852 y:-600],
                        [Block createBlock:101 x:912 y:-600],
                        [Block createBlock:101 x:972 y:-600],
                        [Block createBlock:101 x:1032 y:-600]];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        self._coins = @[[Coin createCoin:1 x:600 y:-735],
                       [Coin createCoin:1 x:664 y:-735],
                       [Coin createCoin:1 x:728 y:-735],
                       [Coin createCoin:1 x:792 y:-735],
                       [Coin createCoin:1 x:852 y:-735],
                       [Coin createCoin:1 x:912 y:-735],
                       [Coin createCoin:1 x:972 y:-735],
                       [Coin createCoin:1 x:1032 y:-735]];
        self._lastCoin = [self._coins objectAtIndex:self._coins.count - 1];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

@end
