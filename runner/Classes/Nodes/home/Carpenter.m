//
//  Carpenter.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/13.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Carpenter.h"
#import "GameUtil.h"
#import "CommonAnimation.h"
#import "ConversationLayer.h"
#import "HomeScene.h"

@interface Carpenter ()
@property (nonatomic, readwrite)int _nodeId;
@property (nonatomic, readwrite)int _direction;
@end
@implementation Carpenter

+ (Carpenter*)create:(int)nodeId {
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
    }
    return self;
}

- (void)clickButton:(id)sender {
    [[HomeScene sharedInstance] showConversation:
     [NSArray arrayWithObjects:
      @"*「おれは大工のケンってんだ。\nぐうぜんこのあたりをとおりがかった\nんだが、ここいらはさみしくていけねぇ。」",
      @"*「よっしゃ。おれが1000Gでいいもの\nをつくってやるよ。いいよな？」", nil]];
}

- (void)start {
    NSString *fileName = [NSString stringWithFormat:@"carpenter%d_%@", self._nodeId, [GameUtil getDirectionStr:self._direction]];
    [self._sprite runAction:[CommonAnimation getFrameRepeatAction:fileName frameNum:2 duration:0.5f]];
}

- (void)stop {
    [self._sprite stopAllActions];
}

@end