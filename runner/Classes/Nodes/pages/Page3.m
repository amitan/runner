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

@implementation Page3

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期設定
        self._enemies = [NSMutableArray arrayWithCapacity:4];
        self._blocks = [NSMutableArray arrayWithCapacity:5];
        self._coins = [NSMutableArray arrayWithCapacity:8];
        
        // 地面を追加
        self._land = [Block createBlock:1];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        // 敵を追加
        Enemy *enemy1 = [Enemy createEnemy:1];
        Enemy *enemy2 = [Enemy createEnemy:1];
        Enemy *enemy3 = [Enemy createEnemy:1];
        Enemy *enemy4 = [Enemy createEnemy:1];
        
        enemy1.position = [PointUtil getPosition:100 y:-715];
        enemy2.position = [PointUtil getPosition:184 y:-715];
        enemy3.position = [PointUtil getPosition:268 y:-715];
        enemy4.position = [PointUtil getPosition:352 y:-715];
        
        [self._enemies addObject:enemy1];
        [self._enemies addObject:enemy2];
        [self._enemies addObject:enemy3];
        [self._enemies addObject:enemy4];
        
        for (Enemy *enemy in self._enemies) {
            [enemy stageOn:self];
        }
        
        // ブロック追加
        Block *block1 = [Block createBlock:101];
        Block *block2 = [Block createBlock:101];
        Block *block3 = [Block createBlock:101];
        Block *block4 = [Block createBlock:101];
        Block *block5 = [Block createBlock:101];

        block1.position = [PointUtil getPosition:792 y:-600];
        block2.position = [PointUtil getPosition:856 y:-600];
        block3.position = [PointUtil getPosition:920 y:-600];
        block4.position = [PointUtil getPosition:984 y:-600];
        block5.position = [PointUtil getPosition:1048 y:-600];

        [self._blocks addObject:block1];
        [self._blocks addObject:block2];
        [self._blocks addObject:block3];
        [self._blocks addObject:block4];
        [self._blocks addObject:block5];

        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        Coin *coin1 = [Coin node];
        Coin *coin2 = [Coin node];
        Coin *coin3 = [Coin node];
        Coin *coin4 = [Coin node];
        Coin *coin5 = [Coin node];
        Coin *coin6 = [Coin node];
        Coin *coin7 = [Coin node];
        Coin *coin8 = [Coin node];
        self._lastCoin = coin8;
        
        coin1.position = [PointUtil getPosition:600 y:-735];
        coin2.position = [PointUtil getPosition:664 y:-735];
        coin3.position = [PointUtil getPosition:728 y:-735];
        coin4.position = [PointUtil getPosition:792 y:-735];
        coin5.position = [PointUtil getPosition:856 y:-735];
        coin6.position = [PointUtil getPosition:920 y:-735];
        coin7.position = [PointUtil getPosition:984 y:-735];
        coin8.position = [PointUtil getPosition:1048 y:-735];
        
        [self._coins addObject:coin1];
        [self._coins addObject:coin2];
        [self._coins addObject:coin3];
        [self._coins addObject:coin4];
        [self._coins addObject:coin5];
        [self._coins addObject:coin6];
        [self._coins addObject:coin7];
        [self._coins addObject:coin8];
        
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

@end
