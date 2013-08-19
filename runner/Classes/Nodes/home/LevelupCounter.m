//
//  LevelupCounter.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/19.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "LevelupCounter.h"
#import "GameUtil.h"
#import "CommonAnimation.h"
#import "PointUtil.h"

@interface LevelupCounter ()
@property (nonatomic, readwrite)int _nodeId;
@property (nonatomic, readwrite)int _direction;
@end

@implementation LevelupCounter

+ (LevelupCounter*)create:(int)nodeId {
    return [[[self alloc] initWithNodeId:nodeId] autorelease];
}

- (id)initWithNodeId:(int)nodeId {
    self = [super init];
	if (self) {
        
        // 初期値設定
        self._nodeId = nodeId;
        self._direction = BOTTOM;
        
        // アニメーションの最初のコマを読み込む
        NSString* fileName = [NSString stringWithFormat:@"carpenter%d_%@1.png", self._nodeId, [GameUtil getDirectionStr:self._direction]];
        self._sprite = [CCSprite spriteWithSpriteFrameName:fileName];
        [self addChild:self._sprite];
        [self addClickListner:self selector:@selector(clickButton:)];
        
        // カウンター追加
        CCSprite *counter = [CCSprite spriteWithSpriteFrameName:@"levelup_counter.png"];
        counter.position = [PointUtil getPosition:0 y:-38];
        [self addChild:counter];
        
    }
    return self;
}

- (void)clickButton:(id)sender {
}

- (void)start {
    NSString *fileName = [NSString stringWithFormat:@"carpenter%d_%@", self._nodeId, [GameUtil getDirectionStr:self._direction]];
    [self._sprite runAction:[CommonAnimation getFrameRepeatAction:fileName frameNum:2 duration:0.5f]];
}

- (void)stop {
    [self._sprite stopAllActions];
}

@end
