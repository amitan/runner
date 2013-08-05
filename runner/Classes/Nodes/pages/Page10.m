//
//  Page10.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/05.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page10.h"
#import "PointUtil.h"

@interface Page10 ()
@property (nonatomic, retain)Block *_land2;
@end

@implementation Page10

- (id)init {
    
    self = [super init];
	if (self) {
        
        // 初期設定
        self._blocks = [NSMutableArray arrayWithCapacity:10];
        self._coins = [NSMutableArray arrayWithCapacity:10];
        self._switches = [NSMutableArray arrayWithCapacity:2];
        
        // 地面を追加
        self._land = [Block createBlock:5];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        self._land2 = [Block createBlock:5];
        self._land2.position = ccpAdd(ccp(self._land.position.x + [self._land getWidth] / 2, 0), [self getLandPosition:self._land2]);
        [self._land2 stageOn:self];
        
        // ブロック追加
        Block *block1 = [Block createBlock:104];
        Block *block2 = [Block createBlock:101];
        Block *block3 = [Block createBlock:104];
        Block *block4 = [Block createBlock:105];
        Block *block5 = [Block createBlock:304];
        Block *block11 = [Block createBlock:107];
        Block *block12 = [Block createBlock:107];
        Block *block13 = [Block createBlock:107];
        Block *block14 = [Block createBlock:107];
        Block *block15 = [Block createBlock:107];
        Block *block16 = [Block createBlock:107];
        Block *block17 = [Block createBlock:107];
        Block *block21 = [Block createBlock:105];
        Block *block22 = [Block createBlock:104];
        Block *block23 = [Block createBlock:105];
        Block *block24 = [Block createBlock:104];
        Block *block25 = [Block createBlock:105];
        Block *block26 = [Block createBlock:104];
        Block *block27 = [Block createBlock:105];
        Block *block28 = [Block createBlock:104];
        Block *block31 = [Block createBlock:108];
        Block *block32 = [Block createBlock:108];
        Block *block33 = [Block createBlock:108];
        Block *block34 = [Block createBlock:105];
        Block *block35 = [Block createBlock:108];
        Block *block41 = [Block createBlock:303];
        Block *block42 = [Block createBlock:304];
        Block *block51 = [Block createBlock:107];
        Block *block52 = [Block createBlock:109];
        Block *block53 = [Block createBlock:109];
        Block *block54 = [Block createBlock:107];
        Block *block55 = [Block createBlock:105];
        Block *block56 = [Block createBlock:105];
        Block *block57 = [Block createBlock:109];
        Block *block58 = [Block createBlock:102];
        Block *block59 = [Block createBlock:102];
        Block *block60 = [Block createBlock:103];
        Block *block61 = [Block createBlock:103];
        Block *block62 = [Block createBlock:101];
        
        // 山
        block1.position = [PointUtil getPosition:100 y:-670]; // 階段ブロック
        block2.position = [PointUtil getPosition:100 y:-550];
        block3.position = [PointUtil getPosition:160 y:-670];
        block4.position = [PointUtil getPosition:160 y:-430];
        block5.position = [PointUtil getPosition:220 y:-610];
        block11.position = [PointUtil getPosition:520 y:-340]; // 上ブロック
        block12.position = [PointUtil getPosition:820 y:-340];
        block13.position = [PointUtil getPosition:1240 y:-340];
        block14.position = [PointUtil getPosition:1540 y:-340];
        block15.position = [PointUtil getPosition:1840 y:-340];
        block16.position = [PointUtil getPosition:2140 y:-340];
        block17.position = [PointUtil getPosition:2560 y:-340];
        block21.position = [PointUtil getPosition:1000 y:-370]; // へこみ部分1
        block22.position = [PointUtil getPosition:1000 y:-130];
        block23.position = [PointUtil getPosition:1060 y:-370];
        block24.position = [PointUtil getPosition:1060 y:-130];
        block25.position = [PointUtil getPosition:2320 y:-370]; // へこみ部分2
        block26.position = [PointUtil getPosition:2320 y:-130];
        block27.position = [PointUtil getPosition:2380 y:-370];
        block28.position = [PointUtil getPosition:2380 y:-130];
        block31.position = [PointUtil getPosition:3070 y:-700]; // 階段部分
        block32.position = [PointUtil getPosition:2830 y:-460];
        block33.position = [PointUtil getPosition:3070 y:-220];
        block34.position = [PointUtil getPosition:3280 y:-310];
        block35.position = [PointUtil getPosition:3190 y:-700];
        block41.position = [PointUtil getPosition:3280 y:-610]; // 反転ブロック
        block42.position = [PointUtil getPosition:2740 y:-370];
        block51.position = [PointUtil getPosition:3460 y:-460]; // 狭い通路部分（大ブロック）
        block52.position = [PointUtil getPosition:3760 y:-610];
        block53.position = [PointUtil getPosition:4060 y:-610];
        block54.position = [PointUtil getPosition:4450 y:-310];
        block55.position = [PointUtil getPosition:3730 y:-220]; // 狭い通路部分（小ブロック）
        block56.position = [PointUtil getPosition:3790 y:-220];
        block57.position = [PointUtil getPosition:4060 y:-490];
        block58.position = [PointUtil getPosition:3970 y:-220];
        block59.position = [PointUtil getPosition:3970 y:-160];
        block60.position = [PointUtil getPosition:4210 y:-220];
        block61.position = [PointUtil getPosition:4210 y:-160];
        block62.position = [PointUtil getPosition:3100 y:-430]; // スイッチ2

        [self._blocks addObject:block1];
        [self._blocks addObject:block2];
        [self._blocks addObject:block3];
        [self._blocks addObject:block4];
        [self._blocks addObject:block5];
        [self._blocks addObject:block11];
        [self._blocks addObject:block12];
        [self._blocks addObject:block13];
        [self._blocks addObject:block14];
        [self._blocks addObject:block15];
        [self._blocks addObject:block16];
        [self._blocks addObject:block17];
        [self._blocks addObject:block21];
        [self._blocks addObject:block22];
        [self._blocks addObject:block23];
        [self._blocks addObject:block24];
        [self._blocks addObject:block25];
        [self._blocks addObject:block26];
        [self._blocks addObject:block27];
        [self._blocks addObject:block28];
        [self._blocks addObject:block31];
        [self._blocks addObject:block32];
        [self._blocks addObject:block33];
        [self._blocks addObject:block34];
        [self._blocks addObject:block35];
        [self._blocks addObject:block41];
        [self._blocks addObject:block42];
        [self._blocks addObject:block51];
        [self._blocks addObject:block52];
        [self._blocks addObject:block53];
        [self._blocks addObject:block54];
        [self._blocks addObject:block55];
        [self._blocks addObject:block56];
        [self._blocks addObject:block57];
        [self._blocks addObject:block58];
        [self._blocks addObject:block59];
        [self._blocks addObject:block60];
        [self._blocks addObject:block61];
        [self._blocks addObject:block62];
        
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }

        // スイッチ
        Switch *switch1 = [Switch createSwitch:102 groupId:1];
        Switch *switch2 = [Switch createSwitch:102 groupId:2];
        switch1.position = [PointUtil getPosition:1030 y:-543];
        switch2.position = [PointUtil getPosition:3100 y:-483];
        [self._switches addObject:switch1];
        [self._switches addObject:switch2];
        for (Switch *sw in self._switches) {
            [sw stageOn:self];
        }

        // コイン
        Coin *coin1 = [Coin createCoin:4 groupId:1];
        Coin *coin2 = [Coin createCoin:4 groupId:1];
        Coin *coin3 = [Coin createCoin:4 groupId:1];
        Coin *coin4 = [Coin createCoin:4 groupId:1];
        Coin *coin5 = [Coin createCoin:4 groupId:1];
        Coin *coin6 = [Coin createCoin:4 groupId:1];
        Coin *coin7 = [Coin createCoin:4 groupId:1];
        Coin *coin8 = [Coin createCoin:4 groupId:1];
        Coin *coin9 = [Coin createCoin:4 groupId:1];
        Coin *coin10 = [Coin createCoin:4 groupId:1];
        Coin *coin11 = [Coin createCoin:4 groupId:1];
        Coin *coin12 = [Coin createCoin:4 groupId:1];
        Coin *coin13 = [Coin createCoin:4 groupId:1];
        Coin *coin14 = [Coin createCoin:4 groupId:1];
        Coin *coin15 = [Coin createCoin:4 groupId:1];
        Coin *coin16 = [Coin createCoin:4 groupId:1];
        Coin *coin17 = [Coin createCoin:4 groupId:1];
        Coin *coin18 = [Coin createCoin:4 groupId:1];
        Coin *coin19 = [Coin createCoin:4 groupId:1];
        Coin *coin20 = [Coin createCoin:4 groupId:1];
        Coin *coin21 = [Coin createCoin:4 groupId:1];
        Coin *coin22 = [Coin createCoin:4 groupId:1];
        Coin *coin23 = [Coin createCoin:4 groupId:1];
        Coin *coin24 = [Coin createCoin:4 groupId:1];
        Coin *coin25 = [Coin createCoin:4 groupId:1];
        Coin *coin26 = [Coin createCoin:4 groupId:1];
        Coin *coin27 = [Coin createCoin:4 groupId:1];
        Coin *coin28 = [Coin createCoin:4 groupId:1];
        Coin *coin29 = [Coin createCoin:4 groupId:1];
        Coin *coin30 = [Coin createCoin:4 groupId:1];

        Coin *coin101 = [Coin createCoin:4 groupId:2];
        Coin *coin102 = [Coin createCoin:4 groupId:2];
        Coin *coin103 = [Coin createCoin:4 groupId:2];
        Coin *coin104 = [Coin createCoin:4 groupId:2];
        Coin *coin105 = [Coin createCoin:4 groupId:2];
        Coin *coin106 = [Coin createCoin:4 groupId:2];
        Coin *coin107 = [Coin createCoin:4 groupId:2];
        Coin *coin108 = [Coin createCoin:4 groupId:2];
        Coin *coin109 = [Coin createCoin:4 groupId:2];
        Coin *coin110 = [Coin createCoin:4 groupId:2];
        Coin *coin111 = [Coin createCoin:4 groupId:2];
        Coin *coin112 = [Coin createCoin:4 groupId:2];
        Coin *coin113 = [Coin createCoin:4 groupId:2];
        Coin *coin114 = [Coin createCoin:4 groupId:2];
        Coin *coin115 = [Coin createCoin:4 groupId:2];
        Coin *coin116 = [Coin createCoin:4 groupId:2];
        Coin *coin117 = [Coin createCoin:4 groupId:2];
        Coin *coin118 = [Coin createCoin:4 groupId:2];
        Coin *coin119 = [Coin createCoin:4 groupId:2];
        Coin *coin120 = [Coin createCoin:4 groupId:2];
        Coin *coin121 = [Coin createCoin:4 groupId:2];
        Coin *coin122 = [Coin createCoin:4 groupId:2];
        Coin *coin123 = [Coin createCoin:4 groupId:2];
        Coin *coin124 = [Coin createCoin:4 groupId:2];
        Coin *coin125 = [Coin createCoin:4 groupId:2];
        Coin *coin126 = [Coin createCoin:4 groupId:2];
        Coin *coin127 = [Coin createCoin:4 groupId:2];
        Coin *coin128 = [Coin createCoin:4 groupId:2];
        Coin *coin129 = [Coin createCoin:4 groupId:2];
        Coin *coin130 = [Coin createCoin:4 groupId:2];

        Coin *coin200 = [Coin createCoin:5];
        
        coin1.position = [PointUtil getPosition:1120 y:-730];
        coin2.position = [PointUtil getPosition:1180 y:-730];
        coin3.position = [PointUtil getPosition:1240 y:-730];
        coin4.position = [PointUtil getPosition:1300 y:-730];
        coin5.position = [PointUtil getPosition:1360 y:-730];
        coin6.position = [PointUtil getPosition:1420 y:-730];
        coin7.position = [PointUtil getPosition:1480 y:-730];
        coin8.position = [PointUtil getPosition:1540 y:-730];
        coin9.position = [PointUtil getPosition:1600 y:-730];
        coin10.position = [PointUtil getPosition:1660 y:-730];
        coin11.position = [PointUtil getPosition:1720 y:-730];
        coin12.position = [PointUtil getPosition:1780 y:-730];
        coin13.position = [PointUtil getPosition:1840 y:-730];
        coin14.position = [PointUtil getPosition:1900 y:-730];
        coin15.position = [PointUtil getPosition:1960 y:-730];
        coin16.position = [PointUtil getPosition:2020 y:-730];
        coin17.position = [PointUtil getPosition:2080 y:-730];
        coin18.position = [PointUtil getPosition:2140 y:-730];
        coin19.position = [PointUtil getPosition:2200 y:-730];
        coin20.position = [PointUtil getPosition:2260 y:-730];
        coin21.position = [PointUtil getPosition:2320 y:-730];
        coin22.position = [PointUtil getPosition:2380 y:-730];
        coin23.position = [PointUtil getPosition:2440 y:-730];
        coin24.position = [PointUtil getPosition:2500 y:-730];
        coin25.position = [PointUtil getPosition:2560 y:-730];
        coin26.position = [PointUtil getPosition:2620 y:-730];
        coin27.position = [PointUtil getPosition:2680 y:-730];
        coin28.position = [PointUtil getPosition:2740 y:-730];
        coin29.position = [PointUtil getPosition:2800 y:-730];
        coin30.position = [PointUtil getPosition:2860 y:-730];
        
        coin101.position = [PointUtil getPosition:3640 y:-190];
        coin102.position = [PointUtil getPosition:3640 y:-250];
        coin103.position = [PointUtil getPosition:3640 y:-310];
        coin104.position = [PointUtil getPosition:3640 y:-370];
        coin105.position = [PointUtil getPosition:3640 y:-430];
        coin106.position = [PointUtil getPosition:3700 y:-430];
        coin107.position = [PointUtil getPosition:3760 y:-430];
        coin108.position = [PointUtil getPosition:3820 y:-430];
        coin109.position = [PointUtil getPosition:3880 y:-430];
        coin110.position = [PointUtil getPosition:3880 y:-370];
        coin111.position = [PointUtil getPosition:3880 y:-310];
        coin112.position = [PointUtil getPosition:3940 y:-310];
        coin113.position = [PointUtil getPosition:4000 y:-310];
        coin114.position = [PointUtil getPosition:4060 y:-310];
        coin115.position = [PointUtil getPosition:4120 y:-310];
        coin116.position = [PointUtil getPosition:4180 y:-310];
        coin117.position = [PointUtil getPosition:4240 y:-310];
        coin118.position = [PointUtil getPosition:4240 y:-370];
        coin119.position = [PointUtil getPosition:4240 y:-430];
        coin120.position = [PointUtil getPosition:4240 y:-490];
        coin121.position = [PointUtil getPosition:4240 y:-550];
        coin122.position = [PointUtil getPosition:4240 y:-610];
        coin123.position = [PointUtil getPosition:4240 y:-670];
        coin124.position = [PointUtil getPosition:4300 y:-730];
        coin125.position = [PointUtil getPosition:4360 y:-730];
        coin126.position = [PointUtil getPosition:4420 y:-730];
        coin127.position = [PointUtil getPosition:4480 y:-730];
        coin128.position = [PointUtil getPosition:4540 y:-730];
        coin129.position = [PointUtil getPosition:4600 y:-730];
        coin130.position = [PointUtil getPosition:4660 y:-730];
        coin200.position = [PointUtil getPosition:2350 y:-580];

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
        [self._coins addObject:coin101];
        [self._coins addObject:coin102];
        [self._coins addObject:coin103];
        [self._coins addObject:coin104];
        [self._coins addObject:coin105];
        [self._coins addObject:coin106];
        [self._coins addObject:coin107];
        [self._coins addObject:coin108];
        [self._coins addObject:coin109];
        [self._coins addObject:coin110];
        [self._coins addObject:coin111];
        [self._coins addObject:coin112];
        [self._coins addObject:coin113];
        [self._coins addObject:coin114];
        [self._coins addObject:coin115];
        [self._coins addObject:coin116];
        [self._coins addObject:coin117];
        [self._coins addObject:coin118];
        [self._coins addObject:coin119];
        [self._coins addObject:coin120];
        [self._coins addObject:coin121];
        [self._coins addObject:coin122];
        [self._coins addObject:coin123];
        [self._coins addObject:coin124];
        [self._coins addObject:coin125];
        [self._coins addObject:coin126];
        [self._coins addObject:coin127];
        [self._coins addObject:coin128];
        [self._coins addObject:coin129];
        [self._coins addObject:coin130];
        [self._coins addObject:coin200];
        
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }

    }
    return self;
}

- (float)getWidth {
    return (self._land2.position.x + [self._land2 getWidth] / 2) - (self._land.position.x - [self._land getWidth] / 2);
}

- (Block*)getHitBlock:(CGPoint)point {
    for (Block *block in self._blocks) {
        if ([block isHit:point]) return block;
    }
    if ([self._land isHit:point]) return self._land;
    if ([self._land2 isHit:point]) return self._land2;
    return NULL;
}

@end
