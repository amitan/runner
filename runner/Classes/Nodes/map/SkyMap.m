//
//  SkyMap.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/29.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "SkyMap.h"
#import "GameScene.h"
#import "GameUtil.h"
#import "SkyPage.h"
#import "PointUtil.h"

@interface SkyMap ()
@property (nonatomic, readwrite)int _stageId;
@property (nonatomic, readwrite)int _speed;
@end
@implementation SkyMap
const int INIT_SKY_PAGE_NUM = 2;
const int MIN_SKY_PAGE_STOCK_NUM = 3;

+ (SkyMap*)createMap:(int)stageId {
    return [[[self alloc] initWithStageId:stageId] autorelease];
}

- (id)initWithStageId:(int)stageId {
    self = [super init];
	if (self) {
        
        // 初期設定
        self._stageId = stageId;
        self._pages = [NSMutableArray arrayWithCapacity:5];
        self._speed = 1;
        
        // 初期ページを追加
        PageController *pageController = [GameScene sharedInstance].pageController;
        for (int i = 0; i < INIT_SKY_PAGE_NUM; i++) {
            [self addPage:[pageController getPageBy:SKY_PAGE_BASE_ID]];
        }
    }
    return self;
}

- (void)takeItemsIfCollided:(CGPoint)center radius:(float)radius {
    SkyPage *currentPage = [self getCurrentPage:center];
    CGPoint location = ccpSub(center, self.position);
    [currentPage takeCoinsIfCollided:location radius:radius];
}

- (BOOL)isEnemyHit:(CGPoint)center radius:(float)radius {
    SkyPage *currentPage = [self getCurrentPage:center];
    CGPoint location = ccpSub(center, self.position);
    return [currentPage isEnemyHit:location radius:radius];
}

- (SkyPage*)getCurrentPage:(CGPoint)point {
    CGPoint location = ccpSub(point, self.position);
    for (SkyPage *page in self._pages) {
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
            break;
        }
    }
    if (result) {
        Page *page = [self._pages objectAtIndex:0];
        [page stageOff];
        [self._pages removeObject:page];
    }
    if (self._pages.count < MIN_SKY_PAGE_STOCK_NUM) {
        [self addPage:[[GameScene sharedInstance].pageController getSkyPage]];
    }
}

- (void)restructure {
    for (Page *page in self._pages) {
        [page stageOff];
    }
    self.position = ccp(0, self.position.y);
    PageController *pageController = [GameScene sharedInstance].pageController;
    [pageController resetPages:SKY_PAGE_BASE_ID];
    self._currentRight = 0;
    self._pages = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i < INIT_SKY_PAGE_NUM; i++) {
        Page *page = [pageController getPageBy:SKY_PAGE_BASE_ID];
        [self addPage:page];
    }
}

- (BOOL)checkSpeedUp {
    float speed = [self _getSpeed];
    if (self._speed != speed) {
        self._speed = speed;
        return true;
    }
    return false;
}

- (int)_getSpeed {
    float skyDistance = [[GameScene sharedInstance].hudController getSkyDistance];
    if (skyDistance > 300) return 5;
    if (skyDistance > 200) return 4;
    if (skyDistance > 100) return 3;
    if (skyDistance > 50) return 2;
    return 1;
}

@end
