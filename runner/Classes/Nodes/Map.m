//
//  Map.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/14.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Map.h"
#import "PointUtil.h"
#import "Page1.h"

@interface Map ()
@property (nonatomic, readwrite)float _currentRight;
@property (nonatomic, retain)NSMutableArray *_pages;
@end

@implementation Map
const int MAX_PAGE_NUM = 30;
const int INTERVAL1 = 150;
@synthesize isPlaying;

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期設定
        isPlaying = false;
        self._pages = [NSMutableArray arrayWithCapacity:MAX_PAGE_NUM];
    }
    return self;
}

- (void)start {
    isPlaying = true;
    for (Page *page in self._pages) {
        if (![page isPlaying]) {
            [page start];
        }
    }
}

- (void)stop {
    isPlaying = false;
    for (Page *page in self._pages) {
        if ([page isPlaying]) {
            [page stop];
        }
    }    
}

- (void)addPage:(Page *)page {
    [self addPage:page interval:0];
}

- (void)addPage:(Page *)page interval:(int)interval {
    float dx = [PointUtil getPoint:interval];
    page.position = ccp(self._currentRight + dx, 0);
    self._currentRight = page.position.x + [page getWidth];
    [self addChild:page];
    [self._pages addObject:page];
    
    if (isPlaying) {
        [page start];
    }
}

- (Block*)getHitBlock:(CGPoint)point {
    Page *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    
    Block *block = [currentPage getHitBlock:location];
    return (block) ? block : NULL;
}

- (BOOL)takeCoinsIfCollided:(CGPoint)point {
    Page *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    return [currentPage takeCoinsIfCollided:location];
}

- (BOOL)attackEnemyIfCollided:(CGPoint)point {
    Page *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    return [currentPage attackEnemyIfCollided:location];
}

- (BOOL)isHit:(CGPoint)point {
    Page *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    return [currentPage isHit:location];
}

- (Page*)getCurrentPage:(CGPoint)point {
    CGPoint location = ccpSub(point, self.position);
    for (Page *page in self._pages) {
        if (location.x >= page.position.x && location.x <= page.position.x + [page getWidth]) {
            return page;
        }
    }
    return NULL;
}

- (void)refillIfNeeded {
    BOOL result = false;
    for (Page *page in self._pages) {
        if ([page isOut]) {
            result = true;
        }
    }
    if (result) {
        [self._pages removeObjectAtIndex:0];
        [self addPage:[Page1 node]];
    }
}

@end
