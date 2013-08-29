//
//  Map.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/14.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "LandMap.h"
#import "PointUtil.h"
#import "Page1.h"
#import "GameScene.h"
#import "GameUtil.h"

@interface LandMap ()
@property (nonatomic, readwrite)int _stageId;
@property (nonatomic, readwrite)float _currentRight;
@property (nonatomic, retain)NSMutableArray *_pages;
@property (nonatomic, readwrite)int _pageNum;
@end

@implementation LandMap
const int MAX_SPEED_STEP = 5;
const int MIN_PAGE_STOCK_NUM = 3;
const int INIT_PAGE_NUM = 1;

@synthesize isPlaying;

+ (Map*)createMap:(int)stageId {
    return [[[self alloc] initWithStageId:stageId] autorelease];
}

- (id)initWithStageId:(int)stageId {
    self = [super init];
	if (self) {

        // 初期設定
        self._stageId = stageId;
        self._pages = [NSMutableArray arrayWithCapacity:5];
        self.speed = 1;
        self.isPlaying = false;
        
        // 初期ページを追加
        PageController *pageController = [GameScene sharedInstance].pageController;
        for (int i = 0; i <= INIT_PAGE_NUM; i++) {
            [self addPage:[pageController getPageBy:i]];
        }
//        // スピードアップページ（デバッグ用）
//        int debugSpeed = 3;
//        for (int i = 0; i < debugSpeed; i++) {
//            [self addPage:[pageController getPageBy:SPEED_UP_PAGE]];
//        }
    }
    return self;
}


- (Block*)getHitBlock:(CGPoint)point {
    LandPage *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    return [currentPage getHitBlock:location];
}

- (Rail*)getHitRail:(CGRect)rect {
    CGPoint point = ccp(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2);
    LandPage *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    CGRect newRect = CGRectMake(location.x - rect.size.width / 6, location.y - rect.size.height / 6, rect.size.width / 3, rect.size.height / 3);
    return [currentPage getHitRail:newRect];
}

- (void)takeItemsIfCollided:(CGRect)rect {
    CGPoint point = ccp(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2);
    LandPage *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    CGRect worldRect = CGRectMake(location.x - rect.size.width / 2, location.y - rect.size.height / 2, rect.size.width, rect.size.height);
    [currentPage takeCoinsIfCollided:worldRect];
    [currentPage pressSwitchesIfCollided:worldRect];
}

- (BOOL)jumpIfCollided:(CGRect)rect {
    CGPoint point = ccp(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2);
    LandPage *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    CGRect worldRect = CGRectMake(location.x - rect.size.width / 2, location.y - rect.size.height / 2, rect.size.width, rect.size.height);
    return [currentPage jumpIfCollided:worldRect];
}

- (BOOL)attackEnemyIfCollided:(CGPoint)point {
    LandPage *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    return [currentPage attackEnemyIfCollided:location];
}

- (BOOL)isHit:(CGPoint)point {
    LandPage *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    return [currentPage isHit:location];
}

- (BOOL)checkSpeedUp:(CGPoint)point {
    LandPage *currentPage = [self getCurrentPage:point];
    if (currentPage.isSpeedUp) {
        currentPage.isSpeedUp = false;
        return true;
    }
    return false;
}

- (LandPage*)getCurrentPage:(CGPoint)point {
    CGPoint location = ccpSub(point, self.position);
    for (LandPage *page in self._pages) {
        if (location.x >= page.position.x && location.x <= page.position.x + [page getWidth]) {
            return page;
        }
    }
    return NULL;
}

- (void)refillIfNeeded {
    
    int nextSpeed = [self _getSpeed:[[GameScene sharedInstance].hudController getDistance]];
    if (self.speed != nextSpeed) {
        self.speed = nextSpeed;
        [self addPage:[[GameScene sharedInstance].pageController getPageBy:SPEED_UP_PAGE]];
    }
    
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
    if (self._pages.count < MIN_PAGE_STOCK_NUM) {
        [self addPage:[[GameScene sharedInstance].pageController getLandPage]];
    }
}

- (int)_getSpeed:(int)distance {
    if (self.speed >= MAX_SPEED_STEP) {
        return self.speed;
    }
//    if (distance > 1000) return 5;
//    if (distance > 400) return 4;
//    if (distance > 100) return 3;
//    if (distance > 20) return 2;
//    return 1;
    return distance / 30 + 1;
}

@end
