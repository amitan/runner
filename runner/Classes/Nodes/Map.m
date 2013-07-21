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
@property (nonatomic, readwrite)float _currentRight;
@property (nonatomic, retain)NSMutableArray *_pages;
@property (nonatomic, readwrite)int _pageNum;
@end

@implementation Map
const int SPEED_UP_PAGE = 900;
@synthesize isPlaying;

- (id)init {
    self = [super init];
	if (self) {
        
        // 初期設定
        self.isPlaying = false;
        self._pages = [NSMutableArray arrayWithCapacity:5];
    }
    return self;
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
        
        if (self._pageNum % 10 == 0) { // TODO:: スピードアップ間隔の調整
            [self addPage:[[GameScene sharedInstance].pageController getPage:SPEED_UP_PAGE]];
        } else {
            [self addPage:[[GameScene sharedInstance].pageController getPage]];
        }
    }
}

@end
