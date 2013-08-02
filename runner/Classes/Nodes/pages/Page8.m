//
//  Page8.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/01.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page8.h"
#import "PointUtil.h"

// 反転ブロックとでかコイン
@implementation Page8

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期設定
        self._blocks = [NSMutableArray arrayWithCapacity:31];
        self._coins = [NSMutableArray arrayWithCapacity:1];
        
        // 地面を追加
        self._land = [Block createBlock:5];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        // ブロック追加
        Block *block1 = [Block createBlock:102];
        Block *block2 = [Block createBlock:102];
        Block *block3 = [Block createBlock:102];
        Block *block4 = [Block createBlock:102];
        Block *block5 = [Block createBlock:102];
        Block *block6 = [Block createBlock:102];
        Block *block7 = [Block createBlock:102];
        Block *block11 = [Block createBlock:103];
        Block *block12 = [Block createBlock:103];
        Block *block13 = [Block createBlock:103];
        Block *block14 = [Block createBlock:104];
        Block *block15 = [Block createBlock:101];
        Block *block16 = [Block createBlock:101];
        Block *block17 = [Block createBlock:101];
        Block *block18 = [Block createBlock:101];
        Block *block19 = [Block createBlock:101];
        Block *block101 = [Block createBlock:304];
        Block *block102 = [Block createBlock:302];
        Block *block103 = [Block createBlock:302];
        Block *block104 = [Block createBlock:302];
        Block *block105 = [Block createBlock:304];
        Block *block106 = [Block createBlock:304];
        
        Block *block21 = [Block createBlock:105];
        Block *block22 = [Block createBlock:105];
        Block *block23 = [Block createBlock:102];
        Block *block24 = [Block createBlock:104];
        Block *block25 = [Block createBlock:102];
        Block *block31 = [Block createBlock:103];
        Block *block32 = [Block createBlock:103];
        Block *block33 = [Block createBlock:103];
        Block *block34 = [Block createBlock:303];
        
        // 山
        block1.position = [PointUtil getPosition:170 y:-730];
        block2.position = [PointUtil getPosition:470 y:-730];
        block3.position = [PointUtil getPosition:230 y:-670];
        block4.position = [PointUtil getPosition:290 y:-610];
        block5.position = [PointUtil getPosition:350 y:-550];
        block6.position = [PointUtil getPosition:410 y:-490];
        block7.position = [PointUtil getPosition:470 y:-430];

        block11.position = [PointUtil getPosition:470 y:-670];
        block12.position = [PointUtil getPosition:470 y:-370];
        block13.position = [PointUtil getPosition:530 y:-310];
        block14.position = [PointUtil getPosition:590 y:-610];
        block15.position = [PointUtil getPosition:470 y:-610];
        block16.position = [PointUtil getPosition:530 y:-610];
        block17.position = [PointUtil getPosition:530 y:-550];
        block18.position = [PointUtil getPosition:590 y:-490];
        block19.position = [PointUtil getPosition:590 y:-370];

        // 反転ブロック
        block101.position = [PointUtil getPosition:650 y:-610];
        block102.position = [PointUtil getPosition:650 y:-430];
        block103.position = [PointUtil getPosition:650 y:-370];
        block104.position = [PointUtil getPosition:650 y:-310];
        block105.position = [PointUtil getPosition:950 y:60];
        block106.position = [PointUtil getPosition:950 y:-240];

        // 棚
        block21.position = [PointUtil getPosition:890 y:0];
        block22.position = [PointUtil getPosition:890 y:-300];
        block23.position = [PointUtil getPosition:1010 y:-420];
        block24.position = [PointUtil getPosition:1190 y:-480];
        block25.position = [PointUtil getPosition:1370 y:-540];
        block31.position = [PointUtil getPosition:1790 y:-730];
        block32.position = [PointUtil getPosition:1790 y:-670];
        block33.position = [PointUtil getPosition:2000 y:-490];
        block34.position = [PointUtil getPosition:2120 y:-370];
        
        [self._blocks addObject:block1];
        [self._blocks addObject:block2];
        [self._blocks addObject:block3];
        [self._blocks addObject:block4];
        [self._blocks addObject:block5];
        [self._blocks addObject:block6];
        [self._blocks addObject:block7];
        [self._blocks addObject:block11];
        [self._blocks addObject:block12];
        [self._blocks addObject:block13];
        [self._blocks addObject:block14];
        [self._blocks addObject:block15];
        [self._blocks addObject:block16];
        [self._blocks addObject:block17];
        [self._blocks addObject:block18];
        [self._blocks addObject:block19];
        [self._blocks addObject:block21];
        [self._blocks addObject:block22];
        [self._blocks addObject:block23];
        [self._blocks addObject:block24];
        [self._blocks addObject:block25];
        [self._blocks addObject:block101];
        [self._blocks addObject:block102];
        [self._blocks addObject:block103];
        [self._blocks addObject:block104];
        [self._blocks addObject:block105];
        [self._blocks addObject:block106];
        [self._blocks addObject:block31];
        [self._blocks addObject:block32];
        [self._blocks addObject:block33];
        [self._blocks addObject:block34];
        
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // コインを追加
        Coin *coin1 = [Coin createCoin:2];
        coin1.position = [PointUtil getPosition:1100 y:-250];
        [self._coins addObject:coin1];
        
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }
    }
    return self;
}

@end
