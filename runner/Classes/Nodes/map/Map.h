//
//  Map.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/29.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "LandPage.h"

@interface Map : CCNode {
    
}
@property (nonatomic, readwrite)BOOL isPlaying;
@property (nonatomic, readwrite)float _currentRight;
@property (nonatomic, retain)NSMutableArray *_pages;

// マップにページを追加する
- (void)addPage:(Page *)page;
- (void)addPage:(Page *)page interval:(int)interval;

// アニメーションを開始/停止する
- (void)start;
- (void)stop;
- (void)suspend;
- (void)resume;

@end
