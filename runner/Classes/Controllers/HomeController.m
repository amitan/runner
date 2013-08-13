//
//  HomeController.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/13.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "HomeController.h"
#import "CCSpriteButton.h"
#import "PointUtil.h"
#import "GameUtil.h"
#import "HomeScene.h"
#import "GameScene.h"
#import "Door.h"
#import "Carpenter.h"

@interface HomeController ()
@property (nonatomic, retain)Door *_door;
@property (nonatomic, retain)Carpenter *_carpenter;
@end

@implementation HomeController

- (id)init {
    self = [super init];
	if (self) {
        
    }
    return self;
}

- (void)setup {
    
    // ドア追加
    self._door = [Door node];
    [PointUtil setTLPosition:self._door x:400 y:184];
    [[HomeScene sharedInstance].mainLayer addChild:self._door];
    
    // 大工追加
    self._carpenter = [Carpenter create:1];
    [PointUtil setTLPosition:self._carpenter x:150 y:650];
    [[HomeScene sharedInstance].mainLayer addChild:self._carpenter];
}

- (void)start {
    [self._carpenter start];
}

- (void)stop {
    [self._carpenter stop];
}

- (void)suspend {
    [self._carpenter stop];
}

- (void)resume {
    [self._carpenter start];
}


@end
