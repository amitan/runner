//
//  Page2001.m
//  runner
//
//  Created by Ayumi Otomo on 2013/09/23.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page2001.h"
#import "Item.h"

@implementation Page2001

- (id)init {
    self = [super init];
	if (self) {
        self.isItem = true;
        
        // 地面を追加
        Block *land = [Block createBlock:1];
        land.position = [self getLandPosition:land];
        [land stageOn:self];
        self._lands = @[land];
        
        
        // ブロック追加
        self._blocks = @[[Block createBlock:101 x:100 y:-360],
                         [Block createBlock:101 x:500 y:-360],
                         [Block createBlock:101 x:560 y:-360],
                         [Block createBlock:101 x:620 y:-360],
                         [Block createBlock:101 x:680 y:-360],
                         [Block createBlock:101 x:740 y:-360]];
        for (Block *block in self._blocks) {
            [block stageOn:self];
        }
     
        // アイテム
        self._item = [Item createItem:620 y:-160];
        [self._item stageOn:self];
    }
    return self;
}

@end
