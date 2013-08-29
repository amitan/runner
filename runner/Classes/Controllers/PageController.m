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

@interface PageController ()
@property (nonatomic, retain)NSMutableDictionary *_dictionary;
@property (nonatomic, retain)NSMutableDictionary *_pageDictionary;
@end

@implementation PageController
const int INIT_ARRAY_CAPACITY = 5;

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
        [self._pageDictionary setObject:@[@1] forKey:@"1000"]; // 空
    }
    return self;
}

- (void)dealloc {
    self._dictionary = nil;
    self._pageDictionary = nil;
    [super dealloc];
}

- (Page*)getPageBy:(int)pageId {
    pageId = (pageId == 0 || pageId == SPEED_UP_PAGE || pageId >= 1000) ? pageId : 3; // TODO:
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
    int type = (pageId < 1000) ? 1 : 2;
    Page *newPage = [Page create:pageId type:type];
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
