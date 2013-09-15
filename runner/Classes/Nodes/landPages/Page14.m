//
//  Page14.m
//  runner
//
//  Created by Ayumi Otomo on 2013/09/14.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page14.h"


@implementation Page14

- (id)init {
    self = [super init];
	if (self) {
        
        // 地面を追加
        self._land = [Block createBlock:1];
        self._land.position = [self getLandPosition:self._land];
        [self._land stageOn:self];
        
        // ブロック追加
        self._blocks = @[[Block createBlock:101 x:40 y:-360],
                         [Block createBlock:101 x:100 y:-360],
                         [Block createBlock:101 x:160 y:-360],
                         [Block createBlock:101 x:560 y:-360],
                         [Block createBlock:101 x:740 y:-360],
                         [Block createBlock:101 x:920 y:-360],
                         ];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
        
        // アイテム
        self._item = [Item createItem:740 y:-120];
        [self._item stageOn:self];
    }
    return self;
}

- (void)reset {
    
    if (self.appearNum == 1) {
        NSMutableArray *extraEnemies = [NSMutableArray arrayWithArray:self._enemies];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:1120 y:-520]];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:1180 y:-520]];
        self._enemies = extraEnemies;

    } else if (self.appearNum == 2) {
        NSMutableArray *extraEnemies = [NSMutableArray arrayWithArray:self._enemies];
        [extraEnemies addObject:[Enemy createEnemy:E_KINOKO x:160 y:-330]];
        self._enemies = extraEnemies;
    }
    
    [super reset];
}

@end
