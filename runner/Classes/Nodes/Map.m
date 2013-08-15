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
#import "GameScene.h"

@interface Map ()
@property (nonatomic, readwrite)int _stageId;
@property (nonatomic, readwrite)int _isRandom;
@property (nonatomic, readwrite)int _currentPageIndex;
@property (nonatomic, readwrite)float _currentRight;
@property (nonatomic, retain)NSMutableArray *_pages;
@property (nonatomic, readwrite)int _pageNum;
@end

@implementation Map
const int SPEED_UP_PAGE = 900;
const int INIT_PAGE_NUM = 3;
@synthesize isPlaying;

+ (Map*)createMap:(int)stageId isRandom:(BOOL)isRandom {
    return [[[self alloc] initWithStageId:stageId isRandom:isRandom] autorelease];
}

- (id)initWithStageId:(int)stageId isRandom:(BOOL)isRandom {
    self = [super init];
	if (self) {

        // 初期設定
        self._stageId = stageId;
        self._isRandom = isRandom;
        self._pages = [NSMutableArray arrayWithCapacity:5];
        self.isPlaying = false;
        
        // 初期ページを追加
        PageController *pageController = [GameScene sharedInstance].pageController;
        for (int i = 0; i < INIT_PAGE_NUM; i++) {
            int pageIndex = (!isRandom) ? [self _getFixedPageIndex:self._currentPageIndex] : i;
            [self addPage:[pageController getPage:pageIndex]];
            self._currentPageIndex++;
        }
    }
    return self;
}

- (int)_getFixedPageIndex:(int)index {
    if (index == 0) return index;
    return self._stageId * 100 + index;
}

- (void)start {
    self.isPlaying = true;
    for (Page *page in self._pages) {
        if (!page.isPlaying) {
            [page start];
        }
    }
}

- (void)stop {
    self.isPlaying = false;
    for (Page *page in self._pages) {
        if (page.isPlaying) {
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
    [page stageOn:self];
    [self._pages addObject:page];
    self._pageNum++;
    
    if (self.isPlaying) {
        [page start];
    }
}

- (Block*)getHitBlock:(CGPoint)point {
    Page *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    return [currentPage getHitBlock:location];
}

- (Rail*)getHitRail:(CGRect)rect {
    CGPoint point = ccp(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2);
    Page *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    CGRect newRect = CGRectMake(location.x - rect.size.width / 6, location.y - rect.size.height / 6, rect.size.width / 3, rect.size.height / 3);
    return [currentPage getHitRail:newRect];
}

- (void)takeItemsIfCollided:(CGRect)rect {
    CGPoint point = ccp(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2);
    Page *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    CGRect worldRect = CGRectMake(location.x - rect.size.width / 2, location.y - rect.size.height / 2, rect.size.width, rect.size.height);
    [currentPage takeCoinsIfCollided:worldRect];
    [currentPage pressSwitchesIfCollided:worldRect];
}

- (BOOL)jumpIfCollided:(CGRect)rect {
    CGPoint point = ccp(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2);
    Page *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    CGRect worldRect = CGRectMake(location.x - rect.size.width / 2, location.y - rect.size.height / 2, rect.size.width, rect.size.height);
    return [currentPage jumpIfCollided:worldRect];
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

- (BOOL)checkSpeedUp:(CGPoint)point {
    Page *currentPage = [self getCurrentPage:point];
    if (currentPage.isSpeedUp) {
        currentPage.isSpeedUp = false;
        return true;
    }
    return false;
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
        Page *page = [self._pages objectAtIndex:0];
        [page stageOff];
        [self._pages removeObject:page];
        
        if (!self._isRandom) {
            [self addPage:[[GameScene sharedInstance].pageController getPage:[self _getFixedPageIndex:self._currentPageIndex]]];
            self._currentPageIndex++;
//        } else if (self._pageNum % 10 == 0) { // TODO:: スピードアップ間隔の調整
//            [self addPage:[[GameScene sharedInstance].pageController getPage:SPEED_UP_PAGE]];
        } else {
            [self addPage:[[GameScene sharedInstance].pageController getPage]];
        }
    }
}
@end
