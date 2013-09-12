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
#import "Gun.h"

@interface LandMap ()
@property (nonatomic, readwrite)int _stageId;
@property (nonatomic, readwrite)float _fireTime;
@property (nonatomic, retain)Gun *_gun;
@end

@implementation LandMap
const int MAX_SPEED_STEP = 5;
const int MIN_LAND_PAGE_STOCK_NUM = 3;
const int INIT_PAGE_NUM = 1;
const int MIN_FIRE_SPEED = 3;
const float MIN_FIRE_SECONDS = 10;
const float MIN_FIRE_SECONDS2 = 7;
const float MIN_FIRE_SECONDS3 = 3;

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
        self._fireTime = MIN_FIRE_SECONDS;
        self._gun = [Gun node];
        
        // 初期ページを追加
        PageController *pageController = [GameScene sharedInstance].pageController;
        for (int i = 0; i <= INIT_PAGE_NUM; i++) {
            [self addPage:[pageController getPageBy:i]];
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

- (Enemy*)attackEnemyIfCollided:(CGPoint)point  direction:(DIRECTION)direction {
    LandPage *currentPage = [self getCurrentPage:point];
    CGPoint location = ccpSub(point, self.position);
    return [currentPage attackEnemyIfCollided:location direction:direction];
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
        [self addPage:[[GameScene sharedInstance].pageController getLandPage]];
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

- (BOOL)checkFire:(ccTime)dt {
    if (self.speed >= MIN_FIRE_SPEED) {
        self._fireTime -= dt;
        if (self._fireTime < 0) {
            switch (self.speed) {
                case MIN_FIRE_SPEED:
                    self._fireTime = MIN_FIRE_SECONDS;
                    break;
                case MIN_FIRE_SPEED + 1:
                    self._fireTime = MIN_FIRE_SECONDS2;
                    break;
                case MIN_FIRE_SPEED + 2:
                    self._fireTime = MIN_FIRE_SECONDS3;
                    break;
                default:
                    self._fireTime = MIN_FIRE_SECONDS;
                    break;
            }
            return true;
        }
    }
    return false;
}

- (void)fire {
    if ([self._gun isReady]) {
        [self._gun stageOn];
        [self._gun start];
    }
}

- (void)suspend {
    [self._gun suspend];
    [super suspend];
}

- (void)resume {
    [super resume];
    [self._gun resume];
}

- (int)_getSpeed:(int)distance {
    if (self.speed >= MAX_SPEED_STEP) {
        return self.speed;
    }
    if (distance > 1000) return 5;
    if (distance > 500) return 4;
    if (distance > 200) return 3;
    if (distance > 50) return 2;
    return 1;
}

@end
