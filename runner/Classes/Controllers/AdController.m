//
//  AdController.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/13.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "AdController.h"

@interface AdController ()
@property (nonatomic, retain)NADView *_nadView;
@end

@implementation AdController

- (id)init {
    self = [super init];
	if (self) {
        
        // Frameを指定してNADViewを生成
        self._nadView = [[NADView alloc]initWithFrame:
                         CGRectMake(0, 0, NAD_ADVIEW_SIZE_320x50.width, NAD_ADVIEW_SIZE_320x50.height)];
        
        // nendSDKログ出力の設定(任意)
        [self._nadView setIsOutputLog:YES];
        
        // 広告枠のapikey/spotidを設定します(必須)
        [self._nadView setNendID:@"170902b2e4f24e2c1d0ccfc5b1c50a0c0e516add" spotID:@"65817"];
        
        // delegateを受けるオブジェクトを指定(必須)
        [self._nadView setDelegate:self];
        
        // 広告をロード
        [[[CCDirector sharedDirector] view] addSubview:self._nadView];
        [self._nadView load];
    }
    return self;
}

- (void)dealloc {
    [self pause];
    [self._nadView removeFromSuperview];
    [self._nadView setDelegate:nil];
    self._nadView = nil;
    [super dealloc];
}

// 広告の受信に成功し表示できた場合に１度通知されます。必須メソッドです。
- (void)nadViewDidFinishLoad:(NADView *)adView {
    [self._nadView pause];
}

- (void)pause {
    [self._nadView pause];
}

- (void)resume {
    [self._nadView resume];
}

@end
