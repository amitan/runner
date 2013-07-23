//
//  Follower.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/22.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Follower.h"
#import "GameScene.h"
#import "PointUtil.h"
#import "PlayerAnimation.h"
#import "GameUtil.h"

@interface Follower ()
@property (nonatomic, readwrite)int _monsterId;
@property (nonatomic, retain)CCSprite *_followerSprite;
@property (nonatomic, retain)NSMutableArray *_points;
@end

@implementation Follower
const int FOLLOWER_DX = 70; // 前のモンスターとの間隔

+ (Follower*)createFollower:(int)monsterId {
    return [[[self alloc] initWithMonsterId:monsterId] autorelease];
}

- (id)initWithMonsterId:(int)monsterId {
    self = [super init];
	if (self) {
        
        // 初期値設定
        self._monsterId = monsterId;
        self._points = [NSMutableArray array];
        
        // アニメーションの最初のコマを読み込む
        NSString* fileName = [NSString stringWithFormat:@"monster%d_right1.png", self._monsterId];
        self._followerSprite = [CCSprite spriteWithSpriteFrameName:fileName];
        [self addChild:self._followerSprite];
    }
    return self;
}

- (void)stageOn:(int)order {
    [PointUtil setPosition:self x:INIT_PLAYER_X - order * FOLLOWER_DX y:760 offsetX:0 offsetY:-self._followerSprite.contentSize.height / 2];
    [[GameScene sharedInstance].gameLayer addChild:self];
}

- (void)start {
    [self._followerSprite runAction:[PlayerAnimation getWalkAction:self._monsterId]];
}

- (void)stop {
    [self._followerSprite stopAllActions];
}

- (void)setPointArray:(NSMutableArray *)points {
    [self._points addObjectsFromArray:points];
}

- (void)updatePosition {
    if (self._points && self._points.count > 0) {
        CGPoint diff = [[self._points objectAtIndex:0] CGPointValue];
        self.position = ccpAdd(self.position, diff);
        [self._points removeObjectAtIndex:0];
    }
}

@end
