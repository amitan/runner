//
//  Page6.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/28.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page6.h"
#import "PointUtil.h"

@implementation Page6

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期設定
        self._blocks = [NSMutableArray arrayWithCapacity:20];
        self._coins = [NSMutableArray arrayWithCapacity:20];
        
        // 地面を追加
        self._land = [Block createBlock:3];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        // ブロック追加
        Block *block1 = [Block createBlock:101];
        Block *block2 = [Block createBlock:101];
        Block *block3 = [Block createBlock:101];
        Block *block4 = [Block createBlock:101];
        Block *block5 = [Block createBlock:101];
        Block *block6 = [Block createBlock:101];
        Block *block7 = [Block createBlock:101];
        Block *block8 = [Block createBlock:101];
        Block *block9 = [Block createBlock:101];
        Block *block10 = [Block createBlock:101];
        Block *block11 = [Block createBlock:101];
        Block *block12 = [Block createBlock:101];
        Block *block13 = [Block createBlock:101];
        Block *block14 = [Block createBlock:101];
        Block *block15 = [Block createBlock:101];
        Block *block16 = [Block createBlock:101];
        Block *block17 = [Block createBlock:101];
        Block *block18 = [Block createBlock:101];
        Block *block19 = [Block createBlock:101];
        Block *block20 = [Block createBlock:101];
        
        block1.position = [PointUtil getPosition:50 y:-728];
        block2.position = [PointUtil getPosition:114 y:-728];
        block3.position = [PointUtil getPosition:178 y:-728];
        block4.position = [PointUtil getPosition:242 y:-728];
        block5.position = [PointUtil getPosition:306 y:-728];
        block6.position = [PointUtil getPosition:434 y:-568];
        block7.position = [PointUtil getPosition:498 y:-568];
        block8.position = [PointUtil getPosition:562 y:-568];
        block9.position = [PointUtil getPosition:626 y:-568];
        block10.position = [PointUtil getPosition:690 y:-568];
        block11.position = [PointUtil getPosition:818 y:-408];
        block12.position = [PointUtil getPosition:882 y:-408];
        block13.position = [PointUtil getPosition:946 y:-408];
        block14.position = [PointUtil getPosition:1010 y:-408];
        block15.position = [PointUtil getPosition:1074 y:-408];
        block16.position = [PointUtil getPosition:1202 y:-248];
        block17.position = [PointUtil getPosition:1266 y:-248];
        block18.position = [PointUtil getPosition:1330 y:-248];
        block19.position = [PointUtil getPosition:1394 y:-248];
        block20.position = [PointUtil getPosition:1458 y:-248];
        
        [self._blocks addObject:block1];
        [self._blocks addObject:block2];
        [self._blocks addObject:block3];
        [self._blocks addObject:block4];
        [self._blocks addObject:block5];
        [self._blocks addObject:block6];
        [self._blocks addObject:block7];
        [self._blocks addObject:block8];
        [self._blocks addObject:block9];
        [self._blocks addObject:block10];
        [self._blocks addObject:block11];
        [self._blocks addObject:block12];
        [self._blocks addObject:block13];
        [self._blocks addObject:block14];
        [self._blocks addObject:block15];
        [self._blocks addObject:block16];
        [self._blocks addObject:block17];
        [self._blocks addObject:block18];
        [self._blocks addObject:block19];
        [self._blocks addObject:block20];
        
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
        Coin *coin9 = [Coin node];
        Coin *coin10 = [Coin node];
        Coin *coin11 = [Coin node];
        Coin *coin12 = [Coin node];
        Coin *coin13 = [Coin node];
        Coin *coin14 = [Coin node];
        Coin *coin15 = [Coin node];
        Coin *coin16 = [Coin node];
        Coin *coin17 = [Coin node];
        Coin *coin18 = [Coin node];
        Coin *coin19 = [Coin node];
        Coin *coin20 = [Coin node];
        self._lastCoin = coin20;
        
        block1.position = [PointUtil getPosition:50 y:-728];
        block2.position = [PointUtil getPosition:114 y:-728];
        block3.position = [PointUtil getPosition:178 y:-728];
        block4.position = [PointUtil getPosition:242 y:-728];
        block5.position = [PointUtil getPosition:306 y:-728];
        block6.position = [PointUtil getPosition:434 y:-568];
        block7.position = [PointUtil getPosition:498 y:-568];
        block8.position = [PointUtil getPosition:562 y:-568];
        block9.position = [PointUtil getPosition:626 y:-568];
        block10.position = [PointUtil getPosition:690 y:-568];
        block11.position = [PointUtil getPosition:818 y:-408];
        block12.position = [PointUtil getPosition:882 y:-408];
        block13.position = [PointUtil getPosition:946 y:-408];
        block14.position = [PointUtil getPosition:1010 y:-408];
        block15.position = [PointUtil getPosition:1074 y:-408];
        block16.position = [PointUtil getPosition:1202 y:-248];
        block17.position = [PointUtil getPosition:1266 y:-248];
        block18.position = [PointUtil getPosition:1330 y:-248];
        block19.position = [PointUtil getPosition:1394 y:-248];
        block20.position = [PointUtil getPosition:1458 y:-248];

        coin1.position = [PointUtil getPosition:50 y:-660];
        coin2.position = [PointUtil getPosition:114 y:-660];
        coin3.position = [PointUtil getPosition:178 y:-660];
        coin4.position = [PointUtil getPosition:242 y:-660];
        coin5.position = [PointUtil getPosition:306 y:-660];
        coin6.position = [PointUtil getPosition:434 y:-500];
        coin7.position = [PointUtil getPosition:498 y:-500];
        coin8.position = [PointUtil getPosition:562 y:-500];
        coin9.position = [PointUtil getPosition:626 y:-500];
        coin10.position = [PointUtil getPosition:690 y:-500];
        coin11.position = [PointUtil getPosition:818 y:-340];
        coin12.position = [PointUtil getPosition:882 y:-340];
        coin13.position = [PointUtil getPosition:946 y:-340];
        coin14.position = [PointUtil getPosition:1010 y:-340];
        coin15.position = [PointUtil getPosition:1074 y:-340];
        coin16.position = [PointUtil getPosition:1202 y:-180];
        coin17.position = [PointUtil getPosition:1266 y:-180];
        coin18.position = [PointUtil getPosition:1330 y:-180];
        coin19.position = [PointUtil getPosition:1394 y:-180];
        coin20.position = [PointUtil getPosition:1458 y:-180];
        
        [self._coins addObject:coin1];
        [self._coins addObject:coin2];
        [self._coins addObject:coin3];
        [self._coins addObject:coin4];
        [self._coins addObject:coin5];
        [self._coins addObject:coin6];
        [self._coins addObject:coin7];
        [self._coins addObject:coin8];
        [self._coins addObject:coin9];
        [self._coins addObject:coin10];
        [self._coins addObject:coin11];
        [self._coins addObject:coin12];
        [self._coins addObject:coin13];
        [self._coins addObject:coin14];
        [self._coins addObject:coin15];
        [self._coins addObject:coin16];
        [self._coins addObject:coin17];
        [self._coins addObject:coin18];
        [self._coins addObject:coin19];
        [self._coins addObject:coin20];

        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }

    }
    return self;
}

@end
