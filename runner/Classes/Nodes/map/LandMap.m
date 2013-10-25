//
//  Map.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/14.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "LandMap.h"
#import "PointUtil.h"
#import "GameScene.h"
#import "GameUtil.h"
#import "Gun.h"

@interface LandMap ()
@property (nonatomic, readwrite)int _stageId;
@property (nonatomic, readwrite)BOOL _isRandom;
@property (nonatomic, readwrite)float _fire1Time, _fire2Time;
@property (nonatomic, retain)Gun *_gun1, *_gun2;
@property (nonatomic, readwrite)int _fixedPageNo;
@end

@implementation LandMap
const int MAX_SPEED_STEP = 9;
const int MIN_LAND_PAGE_STOCK_NUM = 3;
const int INIT_PAGE_NUM = 1;
const int MIN_FIRE1_SPEED = 2;
const int MIN_FIRE2_SPEED = 3;
const float MIN_FIRE1_SECONDS = 10;
const float MIN_FIRE1_SECONDS2 = 7;
const float MIN_FIRE1_SECONDS3 = 3;
const float MIN_FIRE2_SECONDS = 10;

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
        self.speed = 1;
        self.isPlaying = false;
        self._pages = [NSMutableArray arrayWithCapacity:5];
        self._fixedPageNo = 1;

        PageController *pageController = [GameScene sharedInstance].pageController;

        // 初期ページ追加
        if (self._isRandom) {
            for (int i = 0; i <= INIT_PAGE_NUM; i++) {
                [self addPage:[pageController getPageBy:i]];
            }
            // 大砲があるのはエンドレスステージのみ
            self._fire1Time = MIN_FIRE1_SECONDS;
            self._fire2Time = MIN_FIRE2_SECONDS;
            self._gun1 = [Gun node];
            self._gun2 = [Gun node];
            
        } else {
            [self addPage:[pageController getPageBy:PAGE_START]];
            for (int i = 0; i <= INIT_PAGE_NUM; i++) {
                [self addPage:[pageController getPageWithStageId:stageId pageNo:self._fixedPageNo]];
                self._fixedPageNo++;
            }
        }
    }
    return self;
}

- (Block*)getHitBlock:(CGPoint)point {
    LandPage *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    return [currentPage getHitBlock:location];
}

- (Rail*)getHitRail:(CGRect)rect {
    CGPoint point = [self _getCollisionPoint:rect];
    LandPage *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    CGRect newRect = CGRectMake(location.x - rect.size.width / 6, location.y - rect.size.height / 6, rect.size.width / 3, rect.size.height / 3);
    return [currentPage getHitRail:newRect];
}

- (void)takeCoinsIfCollided:(CGRect)rect magnet:(BOOL)isMagnet {
    CGPoint point = [self _getCollisionPoint:rect];
    LandPage *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    CGRect worldRect = CGRectMake(location.x - rect.size.width / 2, location.y - rect.size.height / 2, rect.size.width, rect.size.height);
    [currentPage takeCoinsIfCollided:worldRect magnet:isMagnet];
}

- (void)takeOthersIfCollided:(CGRect)rect {
    CGPoint point = [self _getCollisionPoint:rect];
    LandPage *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    CGRect worldRect = CGRectMake(location.x - rect.size.width / 2, location.y - rect.size.height / 2, rect.size.width, rect.size.height);
    [currentPage pressSwitchesIfCollided:worldRect];
}

- (Item*)takeItemIfCollided:(CGRect)rect {
    CGPoint point = [self _getCollisionPoint:rect];
    LandPage *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    CGRect worldRect = CGRectMake(location.x - rect.size.width / 2, location.y - rect.size.height / 2, rect.size.width, rect.size.height);
    return [currentPage takeItemIfCollided:worldRect];
}

- (Crystal*)takeCrystalIfCollided:(CGRect)rect {
    CGPoint point = [self _getCollisionPoint:rect];
    LandPage *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    CGRect worldRect = CGRectMake(location.x - rect.size.width / 2, location.y - rect.size.height / 2, rect.size.width, rect.size.height);
    return [currentPage takeCrystalIfCollided:worldRect];
}

- (BOOL)jumpIfCollided:(CGRect)rect {
    CGPoint point = [self _getCollisionPoint:rect];
    LandPage *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    CGRect worldRect = CGRectMake(location.x - rect.size.width / 2, location.y - rect.size.height / 2, rect.size.width, rect.size.height);
    return [currentPage jumpIfCollided:worldRect];
}

- (CGPoint)_getCollisionPoint:(CGRect)rect {
    return ccp(rect.origin.x + rect.size.width / 2, rect.origin.y + rect.size.height / 2);
}

- (Enemy*)attackEnemyIfCollided:(CGPoint)point  direction:(DIRECTION)direction isForce:(BOOL)isForce {
    LandPage *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    return [currentPage attackEnemyIfCollided:location direction:direction isForce:isForce];
}

- (NSArray*)attackAllEnemies {
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    float limitX1 = winSize.width / 2 - [PointUtil getPoint:BASE_WIDTH / 2];
    float limitX2 = winSize.width / 2 + [PointUtil getPoint:BASE_WIDTH / 2];
    float centerY = winSize.height / 2;
    CGPoint leftPoint = ccp(limitX1, centerY);
    CGPoint rightPoint = ccp(limitX2, centerY);
    CGPoint leftLocation = ccpSub(leftPoint, self.position);
    CGPoint rightLocation = ccpSub(rightPoint, self.position);
    LandPage *leftPage = [self getCurrentPage:leftPoint];
    NSArray *leftArray = [leftPage attackEnemiesBetween:leftLocation end:rightLocation];
    LandPage *rightPage = [self getCurrentPage:rightPoint];
    NSArray *rightArray = [rightPage attackEnemiesBetween:leftLocation end:rightLocation];
    return [leftArray arrayByAddingObjectsFromArray:rightArray];
}

- (BOOL)isEnemyHit:(CGPoint)point direction:(DIRECTION)direction {
    LandPage *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    return [currentPage isEnemyHit:location direction:direction];
}

- (BOOL)checkSpeedUp:(CGPoint)point {
    LandPage *currentPage = [self getCurrentPage:point];
    if (currentPage.isSpeedUp) {
        currentPage.isSpeedUp = false;
        return true;
    }
    return false;
}

- (BOOL)checkItem {
    for (Page *page in self._pages) {
        if (page.isItem) return true;
    }
    return [[GameScene sharedInstance].playerController isItemEffecting];
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
    if (self._isRandom) {
        [self refillRandomPageIfNeeded];
    } else {
        [self refillFixedPageIfNeeded];
    }
}

- (void)refillFixedPageIfNeeded {
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
    if (self._pages.count < MIN_LAND_PAGE_STOCK_NUM) {
        Page *page = [[GameScene sharedInstance].pageController getPageWithStageId:self._stageId pageNo:self._fixedPageNo];
        if (page) {
            [self addPage:page];
            self._fixedPageNo++;
        }
    }
}

- (void)refillRandomPageIfNeeded {
    
    int nextSpeed = [self _getSpeed:[[GameScene sharedInstance].hudController getLandDistance]];
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
    if (self._pages.count < MIN_LAND_PAGE_STOCK_NUM) {
        if (![self checkItem] && CCRANDOM_0_1() < 0.1) {
            [self addPage:[[GameScene sharedInstance].pageController getLandItemPage]];
        } else {
            [self addPage:[[GameScene sharedInstance].pageController getRandomLandPage]];
        }
    }
}

- (void)restructure {
    for (Page *page in self._pages) {
        [page stageOff];
    }
    [PointUtil setTLPosition:self x:0 y:0];
    PageController *pageController = [GameScene sharedInstance].pageController;
    self._currentRight = 0;
    self._pages = [NSMutableArray arrayWithCapacity:5];
    for (int i = 0; i < 2; i++) {
        Page *page = [pageController getPageBy:0];
        [self addPage:page];
    }
}

- (BOOL)checkFire1:(ccTime)dt {
    if (self.speed >= MIN_FIRE1_SPEED) {
        self._fire1Time -= dt;
        if (self._fire1Time < 0) {
            switch (self.speed) {
                case MIN_FIRE1_SPEED:
                    self._fire1Time = MIN_FIRE1_SECONDS;
                    break;
                case MIN_FIRE1_SPEED + 1:
                    self._fire1Time = MIN_FIRE1_SECONDS2;
                    break;
                case MIN_FIRE1_SPEED + 2:
                    self._fire1Time = MIN_FIRE1_SECONDS3;
                    break;
                default:
                    self._fire1Time = MIN_FIRE1_SECONDS;
                    break;
            }
            return true;
        }
    }
    return false;
}

- (BOOL)checkFire2:(ccTime)dt {
    if (self.speed >= MIN_FIRE2_SPEED) {
        self._fire2Time -= dt;
        if (self._fire2Time < 0) {
            self._fire2Time = MIN_FIRE2_SECONDS;
            return true;
        }
    }
    return false;
}

- (void)fire1 {
    if ([self._gun1 isReady]) {
        [self._gun1 stageOn];
        [self._gun1 start];
    }
}

- (void)fire2 {
    if ([self._gun2 isReady]) {
        [self._gun2 stageOn];
        [self._gun2 start];
    }
}

- (void)clearBullets {
    [self._gun1 clearBullets];
    [self._gun2 clearBullets];
}

- (void)suspend {
    [self._gun1 suspend];
    [self._gun2 suspend];
    [super suspend];
}

- (void)resume {
    [super resume];
    [self._gun1 resume];
    [self._gun2 resume];
}

- (int)_getSpeed:(int)distance {
    if (self.speed >= MAX_SPEED_STEP) {
        return self.speed;
    }
    if (distance > 1500) return 9;
    if (distance > 1300) return 8;
    if (distance > 1000) return 7;
    if (distance > 700) return 6;
    if (distance > 500) return 5;
    if (distance > 300) return 4;
    if (distance > 70) return 3;
    if (distance > 20) return 2;
    return 1;
}

- (BOOL)isRandom {
    return self._isRandom;
}

@end
