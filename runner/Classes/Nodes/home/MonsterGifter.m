//
//  MonsterGifter.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/22.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "MonsterGifter.h"
#import "GameUtil.h"
#import "CommonAnimation.h"
#import "PointUtil.h"

@interface MonsterGifter ()
@property (nonatomic, readwrite)int _nodeId;
@property (nonatomic, readwrite)int _direction;
@property (nonatomic, retain)CCSprite *_character;
@end

@implementation MonsterGifter

+ (MonsterGifter*)create:(int)nodeId {
    return [[[self alloc] initWithNodeId:nodeId] autorelease];
}

- (id)initWithNodeId:(int)nodeId {
    self = [super init];
	if (self) {
        
        // 初期値設定
        self._nodeId = nodeId;
        self._direction = LEFT;
        
        // アニメーションの最初のコマを読み込む
        NSString* fileName = [NSString stringWithFormat:@"towner%d_%@1.png", self._nodeId, [GameUtil getDirectionStr:self._direction]];
        self._character = [CCSprite spriteWithSpriteFrameName:fileName];
        [self addChild:self._character];
        [self._sprites addObject:self._character];
        [self addClickListner:self selector:@selector(clickButton:)];
        
        // 小物を追加
        CCSprite *foodSprite = [CCSprite spriteWithSpriteFrameName:@"food1.png"];
        foodSprite.position = [PointUtil getPosition:-90 y:-10];
        [self addChild:foodSprite];
        
//        // ポップアップレイヤーの初期化
//        self._conversationLayer = [ConversationLayer node];
//        self._playerSelectLayer = [PlayerSelectLayer node];
//        self._playerSelectLayer.orderNo = 4;
    }
    return self;
}

- (void)dealloc {
    self._character = nil;
    [super dealloc];
}

- (void)clickButton:(id)sender {    
}

- (void)start {
    NSString *fileName = [NSString stringWithFormat:@"towner%d_%@", self._nodeId, [GameUtil getDirectionStr:self._direction]];
    [self._character runAction:[CommonAnimation getFrameRepeatAction:fileName frameNum:2 duration:0.5f]];
}

- (void)stop {
    [self._character stopAllActions];
}

@end
