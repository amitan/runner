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

@interface SkyMap ()
@property (nonatomic, readwrite)int _stageId;
@property (nonatomic, retain)NSMutableArray *_pages;
@end
@implementation SkyMap
const int INIT_SKY_PAGE_NUM = 1;

+ (SkyMap*)createMap:(int)stageId {
    return [[[self alloc] initWithStageId:stageId] autorelease];
}

- (id)initWithStageId:(int)stageId {
    self = [super init];
	if (self) {
        
        // 初期設定
        self._stageId = stageId;
        self._pages = [NSMutableArray arrayWithCapacity:5];
        
        // 初期ページを追加
        PageController *pageController = [GameScene sharedInstance].pageController;
        for (int i = 0; i <= INIT_SKY_PAGE_NUM; i++) {
            [self addPage:[pageController getPageBy:i + SKY_PAGE_BASE_ID]];
        }
    }
    return self;
}



@end
