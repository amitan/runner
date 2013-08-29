//
//  Map.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/29.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Map.h"
#import "PointUtil.h"

@interface Map ()
@property (nonatomic, readwrite)int _stageId;
@property (nonatomic, readwrite)float _currentRight;
@property (nonatomic, retain)NSMutableArray *_pages;
@property (nonatomic, readwrite)int _pageNum;
@end

@implementation Map

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

@end
