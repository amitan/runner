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
#import "Page4.h"
#import "Page5.h"
#import "Page6.h"
#import "Page7.h"
#import "Page8.h"
#import "Page9.h"
#import "Page10.h"
#import "Page11.h"
#import "Page12.h"
#import "Page13.h"
#import "Page900.h"
#import "Page1000.h"
#import "Page1001.h"

@interface PageController ()
@property (nonatomic, retain)NSMutableDictionary *_dictionary;
@property (nonatomic, retain)NSMutableDictionary *_pageDictionary;
@end

@implementation PageController
const int INIT_ARRAY_CAPACITY = 5;

- (Page*)_getNewPage:(int)pageId {
    switch (pageId) {
        case 1: return [Page1 node]; // 地面とコイン + 敵
        case 2: return [Page2 node];
        case 3: return [Page3 node];
        case 4: return [Page4 node];
        case 5: return [Page5 node];
        case 6: return [Page6 node];
        case 7: return [Page7 node];
        case 8: return [Page8 node];
        case 9: return [Page9 node];
        case 10: return [Page10 node];
        case 11: return [Page11 node];
        case 12: return [Page12 node];
        case 13: return [Page13 node];
        case 900: return [Page900 node];
        case 1000: return [Page1000 node];
        case 1001: return [Page1001 node];
        default: return [Page0 node]; // 地面のみ
    }
}

- (id)init {
    self = [super init];
	if (self) {
        self._dictionary = [NSMutableDictionary dictionary];
        self._pageDictionary = [NSMutableDictionary dictionary];
        [self._pageDictionary setObject:@[@1, @2, @3, @4, @6,  @7,  @13] forKey:@"1"]; // 0 - 50M: シンプル
        [self._pageDictionary setObject:@[@1, @3, @5, @9, @10, @11, @12] forKey:@"2"];
        [self._pageDictionary setObject:@[@2, @4, @5, @6, @7,  @8,  @11, @12] forKey:@"3"];
        [self._pageDictionary setObject:@[@1, @3, @4, @6, @11, @12, @13] forKey:@"4"];
        [self._pageDictionary setObject:@[@1, @3, @4, @6, @12, @13] forKey:@"5"];
        [self._pageDictionary setObject:@[@1001] forKey:@"1000"]; // 空
    }
    return self;
}

- (void)dealloc {
    self._dictionary = nil;
    self._pageDictionary = nil;
    [super dealloc];
}

- (Page*)getPageBy:(int)pageId {
    pageId = (pageId == 0 || pageId == SPEED_UP_PAGE || pageId >= 1000) ? pageId : 1; // TODO:
    Page *page = [self _findAvailablePage:pageId];
    if (page) {
        return page;
    }
    return [self _createPage:pageId];
}

- (Page*)getLandPage {
    int currentSpeed = [GameScene sharedInstance].mapController.landMap.speed;
    NSArray *array = [self._pageDictionary objectForKey:[NSString stringWithFormat:@"%d", currentSpeed]];
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

@end
