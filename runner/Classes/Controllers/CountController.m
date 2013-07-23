//
//  CountController.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "CountController.h"
#import "Counter.h"

@interface CountController ()
@property (nonatomic, retain)NSTimer *_timer;
@property (nonatomic, retain)NSInvocation *_endListener;
@property (nonatomic, retain)Counter *_counter;
- (void)_stopTimer;
@end

@implementation CountController

- (id)init {
    self = [super init];
	if (self) {
        self._counter = [Counter node];
    }
    return self;
}

- (void)dealloc {
    [self _stopTimer];
    [super dealloc];
}

- (void)setup {
}

- (void)start {
    [self._counter stageOn];
    self._timer = [NSTimer scheduledTimerWithTimeInterval:0.8f target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
}

- (void)stop {
    [self _stopTimer];
    [self._counter stageOff];
}

- (void)_stopTimer {
    if (self._timer) {
        [self._timer invalidate];
        self._timer = nil;
    }
}

- (void)onTimer:(id)sender {
    if ([self._counter isEnd]) {
        [self _stopTimer];
        [self._counter stageOff];
        [self._endListener invoke];
        return;
    }
    [self._counter next];
}

- (void)addEndListner:(id)target selector:(SEL)selector;
{
	if (target && selector) {
		NSMethodSignature *signature = [[target class] instanceMethodSignatureForSelector:selector];
		self._endListener = [NSInvocation invocationWithMethodSignature:signature];
		[self._endListener setTarget:target];
		[self._endListener setSelector:selector];
        [self._endListener setArgument:&self atIndex:2];
	}
}

@end
