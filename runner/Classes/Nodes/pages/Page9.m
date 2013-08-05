//
//  Page9.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/03.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page9.h"
#import "PointUtil.h"

// コインスイッチ
@implementation Page9

- (id)init {
    
    self = [super init];
	if (self) {
        
        // 初期設定
        self._blocks = [NSMutableArray arrayWithCapacity:31];
        self._coins = [NSMutableArray arrayWithCapacity:30];
        self._switches = [NSMutableArray arrayWithCapacity:1];
        
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
        Block *block13 = [Block createBlock:101];
        Block *block14 = [Block createBlock:101];
        Block *block15 = [Block createBlock:101];
        Block *block16 = [Block createBlock:101];
        Block *block21 = [Block createBlock:105];
        Block *block22 = [Block createBlock:105];
        Block *block23 = [Block createBlock:106];
        Block *block24 = [Block createBlock:106];
        Block *block25 = [Block createBlock:106];
        Block *block26 = [Block createBlock:106];
        Block *block27 = [Block createBlock:106];

        // 山
        block1.position = [PointUtil getPosition:170 y:-730];
        block2.position = [PointUtil getPosition:470 y:-730];
        block3.position = [PointUtil getPosition:230 y:-670];
        block4.position = [PointUtil getPosition:290 y:-610];
        block5.position = [PointUtil getPosition:350 y:-550];
        block6.position = [PointUtil getPosition:410 y:-490];
        block7.position = [PointUtil getPosition:470 y:-430];
        block11.position = [PointUtil getPosition:470 y:-670];
        block12.position = [PointUtil getPosition:530 y:-610];
        block13.position = [PointUtil getPosition:590 y:-670];
        block14.position = [PointUtil getPosition:530 y:-550];
        block15.position = [PointUtil getPosition:590 y:-550];
        block16.position = [PointUtil getPosition:590 y:-490];
        
        // 壁
        block21.position = [PointUtil getPosition:770 y:0];
        block22.position = [PointUtil getPosition:770 y:-300];
        block23.position = [PointUtil getPosition:1070 y:-700];
        block24.position = [PointUtil getPosition:1970 y:-700];
        block25.position = [PointUtil getPosition:1250 y:-390];
        block26.position = [PointUtil getPosition:1250 y:-270];
        block27.position = [PointUtil getPosition:1250 y:-150];

        
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
        [self._blocks addObject:block21];
        [self._blocks addObject:block22];
        [self._blocks addObject:block23];
        [self._blocks addObject:block24];
        [self._blocks addObject:block25];
        [self._blocks addObject:block26];
        [self._blocks addObject:block27];
        
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // スイッチ
        Switch *switch1 = [Switch createSwitch:101];
        switch1.position = [PointUtil getPosition:718 y:-150];
        [self._switches addObject:switch1];
        for (Switch *sw in self._switches) {
            [sw stageOn:self];
        }
        
        // コイン
        Coin *coin1 = [Coin createCoin:4];
        Coin *coin2 = [Coin createCoin:4];
        Coin *coin3 = [Coin createCoin:4];
        Coin *coin4 = [Coin createCoin:4];
        Coin *coin5 = [Coin createCoin:4];
        Coin *coin6 = [Coin createCoin:4];
        Coin *coin7 = [Coin createCoin:4];
        Coin *coin8 = [Coin createCoin:4];
        Coin *coin9 = [Coin createCoin:4];
        Coin *coin10 = [Coin createCoin:4];
        Coin *coin11 = [Coin createCoin:4];
        Coin *coin12 = [Coin createCoin:4];
        Coin *coin13 = [Coin createCoin:4];
        Coin *coin14 = [Coin createCoin:4];
        Coin *coin15 = [Coin createCoin:4];
        Coin *coin16 = [Coin createCoin:4];
        Coin *coin17 = [Coin createCoin:4];
        Coin *coin18 = [Coin createCoin:4];
        Coin *coin19 = [Coin createCoin:4];
        Coin *coin20 = [Coin createCoin:4];
        Coin *coin21 = [Coin createCoin:4];
        Coin *coin22 = [Coin createCoin:4];
        Coin *coin23 = [Coin createCoin:4];
        Coin *coin24 = [Coin createCoin:4];
        Coin *coin25 = [Coin createCoin:4];
        Coin *coin26 = [Coin createCoin:4];
        Coin *coin27 = [Coin createCoin:4];
        Coin *coin28 = [Coin createCoin:4];
        Coin *coin29 = [Coin createCoin:4];
        Coin *coin30 = [Coin createCoin:4];
        Coin *coin31 = [Coin createCoin:4];
        Coin *coin32 = [Coin createCoin:4];
        Coin *coin33 = [Coin createCoin:4];
        Coin *coin34 = [Coin createCoin:4];
        Coin *coin35 = [Coin createCoin:4];
        Coin *coin36 = [Coin createCoin:4];
        Coin *coin37 = [Coin createCoin:4];
        Coin *coin38 = [Coin createCoin:4];
        Coin *coin39 = [Coin createCoin:4];
        Coin *coin40 = [Coin createCoin:4];
        Coin *coin41 = [Coin createCoin:4];
        Coin *coin42 = [Coin createCoin:4];
        Coin *coin43 = [Coin createCoin:4];
        Coin *coin44 = [Coin createCoin:4];
        Coin *coin45 = [Coin createCoin:4];
        Coin *coin46 = [Coin createCoin:4];
        Coin *coin47 = [Coin createCoin:4];
        Coin *coin48 = [Coin createCoin:4];
        
        coin1.position = [PointUtil getPosition:830 y:-610];
        coin2.position = [PointUtil getPosition:830 y:-550];
        coin3.position = [PointUtil getPosition:830 y:-490];
        coin4.position = [PointUtil getPosition:890 y:-610];
        coin5.position = [PointUtil getPosition:890 y:-550];
        coin6.position = [PointUtil getPosition:890 y:-490];
        coin7.position = [PointUtil getPosition:950 y:-610];
        coin8.position = [PointUtil getPosition:950 y:-550];
        coin9.position = [PointUtil getPosition:950 y:-490];
        coin10.position = [PointUtil getPosition:1010 y:-610];
        coin11.position = [PointUtil getPosition:1010 y:-550];
        coin12.position = [PointUtil getPosition:1010 y:-490];
        coin13.position = [PointUtil getPosition:1070 y:-610];
        coin14.position = [PointUtil getPosition:1070 y:-550];
        coin15.position = [PointUtil getPosition:1070 y:-490];
        coin16.position = [PointUtil getPosition:1130 y:-610];
        coin17.position = [PointUtil getPosition:1130 y:-550];
        coin18.position = [PointUtil getPosition:1130 y:-490];
        coin19.position = [PointUtil getPosition:1190 y:-610];
        coin20.position = [PointUtil getPosition:1190 y:-550];
        coin21.position = [PointUtil getPosition:1190 y:-490];
        coin22.position = [PointUtil getPosition:1250 y:-610];
        coin23.position = [PointUtil getPosition:1250 y:-550];
        coin24.position = [PointUtil getPosition:1250 y:-490];
        coin25.position = [PointUtil getPosition:1310 y:-610];
        coin26.position = [PointUtil getPosition:1310 y:-550];
        coin27.position = [PointUtil getPosition:1310 y:-490];
        coin28.position = [PointUtil getPosition:1370 y:-610];
        coin29.position = [PointUtil getPosition:1370 y:-550];
        coin30.position = [PointUtil getPosition:1370 y:-490];
        coin31.position = [PointUtil getPosition:1430 y:-610];
        coin32.position = [PointUtil getPosition:1430 y:-550];
        coin33.position = [PointUtil getPosition:1430 y:-490];
        coin34.position = [PointUtil getPosition:1490 y:-610];
        coin35.position = [PointUtil getPosition:1490 y:-550];
        coin36.position = [PointUtil getPosition:1490 y:-490];
        coin37.position = [PointUtil getPosition:1550 y:-610];
        coin38.position = [PointUtil getPosition:1550 y:-550];
        coin39.position = [PointUtil getPosition:1550 y:-490];
        coin40.position = [PointUtil getPosition:1610 y:-610];
        coin41.position = [PointUtil getPosition:1610 y:-550];
        coin42.position = [PointUtil getPosition:1610 y:-490];
        coin43.position = [PointUtil getPosition:1670 y:-610];
        coin44.position = [PointUtil getPosition:1670 y:-550];
        coin45.position = [PointUtil getPosition:1670 y:-490];
        coin46.position = [PointUtil getPosition:1730 y:-610];
        coin47.position = [PointUtil getPosition:1730 y:-550];
        coin48.position = [PointUtil getPosition:1730 y:-490];
        
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
        [self._coins addObject:coin21];
        [self._coins addObject:coin22];
        [self._coins addObject:coin23];
        [self._coins addObject:coin24];
        [self._coins addObject:coin25];
        [self._coins addObject:coin26];
        [self._coins addObject:coin27];
        [self._coins addObject:coin28];
        [self._coins addObject:coin29];
        [self._coins addObject:coin30];
        [self._coins addObject:coin31];
        [self._coins addObject:coin32];
        [self._coins addObject:coin33];
        [self._coins addObject:coin34];
        [self._coins addObject:coin35];
        [self._coins addObject:coin36];
        [self._coins addObject:coin37];
        [self._coins addObject:coin38];
        [self._coins addObject:coin39];
        [self._coins addObject:coin40];
        [self._coins addObject:coin41];
        [self._coins addObject:coin42];
        [self._coins addObject:coin43];
        [self._coins addObject:coin44];
        [self._coins addObject:coin45];
        [self._coins addObject:coin46];
        [self._coins addObject:coin47];
        [self._coins addObject:coin48];
        
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }

    }
    return self;
}

@end
