//
//  PageController.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/21.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "PageController.h"
#import "GameScene.h"
#import "GameUtil.h"
#import "Page0.h"
#import "Page1.h"
#import "Page2.h"
#import "Page3.h"
#import "Page5.h"
#import "Page6.h"
#import "Page7.h"
#import "Page8.h"
#import "Page9.h"
#import "Page11.h"
#import "Page12.h"
#import "Page900.h"
#import "Page1000.h"
#import "Page1001.h"
#import "Page2001.h"

// world1
#import "Page10101001.h"
#import "Page10101002.h"
#import "Page10101003.h"
#import "Page10102001.h"
#import "Page10102002.h"
#import "Page10102003.h"
#import "Page10102004.h"


@interface PageController ()
@property (nonatomic, retain)NSMutableDictionary *_dictionary;
@property (nonatomic, retain)NSMutableDictionary *_pageDictionary;
@end

@implementation PageController
const int INIT_ARRAY_CAPACITY = 5;

- (Page*)_getNewPage:(int)pageId {
    switch (pageId) {
        case 10101001: return [Page10101001 node];
        case 10101002: return [Page10101002 node];
        case 10101003: return [Page10101003 node];
        case 10102001: return [Page10102001 node];
        case 10102002: return [Page10102002 node];
        case 10102003: return [Page10102003 node];
        case 10102004: return [Page10102004 node];
        
        case 0: return [Page0 node]; // 地面のみ
        case 1: return [Page1 node]; // 地面とコイン + 敵（きのこ、炎神）
        case 2: return [Page2 node]; // ブロック縦に3つ並んでいて間にコイン + 間に敵（スライム、とげとげ）
        case 3: return [Page3 node]; // 敵敵敵とブロック（下にコイン）+ 敵（スライム、とげ）+ 100コイン
        case 5: return [Page5 node]; // 2段ブロック + 敵（きのこ、とげ）
        case 6: return [Page6 node]; // ブロック横5個が4段とコイン + 敵（炎神）+ 100コイン
        case 7: return [Page7 node]; // ブロック縦3個とクリスタル + 敵（とげ、炎神）
        case 8: return [Page8 node]; // 階段と反転ブロックとクリスタル + 100コイン
        case 9: return [Page9 node]; // 壁にコインスイッチ + 敵（きのこ）
        case 11: return [Page11 node]; // ジャンプ台（縦）とブロック/コイン + 敵（きのこ、スライム）
        case 12: return [Page12 node]; // レール
        case 900: return [Page900 node]; // スピードアップ
        case 1000: return [Page1000 node]; // 空：何もなし
        case 1001: return [Page1001 node]; // 空：コイン
        case 2001: return [Page2001 node]; // アイテム
        default: return NULL;
    }
}

- (id)init {
    self = [super init];
	if (self) {
        self._dictionary = [NSMutableDictionary dictionary];
        self._pageDictionary = [NSMutableDictionary dictionary];
        [self._pageDictionary setObject:@[@1, @2, @3, @7, @9] forKey:@"1"]; // 0 - 50M: シンプル
        [self._pageDictionary setObject:@[@1, @2, @3, @7, @9] forKey:@"2"]; // 0 - 50M: シンプル
        [self._pageDictionary setObject:@[@1, @2, @3, @5, @7, @8, @11] forKey:@"3"];
        [self._pageDictionary setObject:@[@1, @2, @3, @5, @7, @8, @11] forKey:@"4"];
        [self._pageDictionary setObject:@[@2, @5, @6, @7, @11, @12] forKey:@"5"];
        [self._pageDictionary setObject:@[@2, @5, @6, @7, @11, @12] forKey:@"6"];
        [self._pageDictionary setObject:@[@1, @3, @5, @6, @11, @12] forKey:@"7"];
        [self._pageDictionary setObject:@[@1, @3, @5, @6, @11, @12] forKey:@"8"];
        [self._pageDictionary setObject:@[@1, @6, @11] forKey:@"9"];
        [self._pageDictionary setObject:@[@1001] forKey:@"1000"]; // 空
        [self._pageDictionary setObject:@[@2001] forKey:@"2000"]; // アイテム
        
    }
    return self;
}

- (void)dealloc {
    self._dictionary = nil;
    self._pageDictionary = nil;
    [super dealloc];
}

- (Page*)getPageWithStageId:(int)stageId pageNo:(int)pageNo {
    NSString *fullPageNo = [NSString stringWithFormat:@"%d%03d", stageId, pageNo];
    return [self _getNewPage:[fullPageNo intValue]];
}

- (Page*)getPageBy:(int)pageId {
//    pageId = (pageId == 0 || pageId == SPEED_UP_PAGE || pageId >= 1000) ? pageId : 12; // TODO:
    Page *page = [self _findAvailablePage:pageId];
    if (page) {
        return page;
    }
    return [self _createPage:pageId];
}

- (Page*)getRandomLandPage {
    int currentSpeed = [GameScene sharedInstance].mapController.landMap.speed;
    NSArray *array = [self._pageDictionary objectForKey:[NSString stringWithFormat:@"%d", currentSpeed]];
    int pageIndex = floor(CCRANDOM_0_1()*array.count);
    int pageId = [[array objectAtIndex:pageIndex] intValue];
    return [self getPageBy:pageId];
}

- (Page*)getLandItemPage {
    NSArray *array = [self._pageDictionary objectForKey:[NSString stringWithFormat:@"%d", ITEM_PAGE_BASE_ID]];
    int pageIndex = floor(CCRANDOM_0_1()*array.count);
    int pageId = [[array objectAtIndex:pageIndex] intValue];
    return [self getPageBy:pageId];    
}

- (Page*)getSkyPage {
    NSArray *array = [self._pageDictionary objectForKey:[NSString stringWithFormat:@"%d", SKY_PAGE_BASE_ID]];
    int pageIndex = floor(CCRANDOM_0_1()*array.count);
    int pageId = [[array objectAtIndex:pageIndex] intValue];
    return [self getPageBy:pageId];
}

- (Page*)_createPage:(int)pageId {
    NSString *key = [NSString stringWithFormat:@"%d", pageId];
    NSMutableArray *array = [self._dictionary objectForKey:key];
    if (!array) {
        array = [NSMutableArray arrayWithCapacity:INIT_ARRAY_CAPACITY];
    }
    Page *newPage = [self _getNewPage:pageId];
    [array addObject:newPage];
    [self._dictionary setObject:array forKey:key];
    return newPage;
}

- (Page*)_findAvailablePage:(int)pageId {
    NSMutableArray *array = [self._dictionary objectForKey:[NSString stringWithFormat:@"%d", pageId]];
    for (Page* page in array) {
        if (![page isStaged]) return page;
    }
    return NULL;
}

- (void)resetPages:(int)pageId {
    NSArray *keyArray = [self._pageDictionary objectForKey:[NSString stringWithFormat:@"%d", pageId]];
    for (NSNumber* pageIdNumber in keyArray) {
        NSMutableArray *array = [self._dictionary objectForKey:[NSString stringWithFormat:@"%d", [pageIdNumber intValue]]];
        for (Page* page in array) {
            [page resetAppearNum];
            [page clear];
        }
    }
}

@end
