//
//  PageController.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/21.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "PageController.h"

@interface PageController ()
@property (nonatomic, retain)NSMutableDictionary *_dictionary;
@end

@implementation PageController
const int INIT_ARRAY_CAPACITY = 5;

- (id)init {
    self = [super init];
	if (self) {
        self._dictionary = [NSMutableDictionary dictionary];
    }
    return self;
}

- (Page*)getPage:(int)pageId {
    pageId = pageId == 0 ? pageId : 12; // TODO:
    Page *page = [self _findAvailablePage:pageId];
    if (page) {
        return page;
    }
    return [self _createPage:pageId];
}

- (Page*)getPage {
    // TODO: ページ取得実装
    int pageId = floor(CCRANDOM_0_1()*13+1);
    return [self getPage:pageId];
}

- (Page*)_createPage:(int)pageId {
    NSString *key = [NSString stringWithFormat:@"%d", pageId];
    NSMutableArray *array = [self._dictionary objectForKey:key];
    if (!array) {
        array = [NSMutableArray arrayWithCapacity:INIT_ARRAY_CAPACITY];
    }
    Page *newPage = [Page create:pageId];
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
