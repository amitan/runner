//
//  Player.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Player.h"
#import "GameScene.h"
#import "ScaleUtil.h"
#import "PlayerAnimation.h"

@interface Player ()
@property (nonatomic, readwrite)int _enemyId;
@property (nonatomic, retain)CCSprite *_playerSprite;
@end

@implementation Player

+ (Player*)createPlayer:(int)enemyId {
    return [[[self alloc] initWithEnemyId:enemyId] autorelease];
}

- (id)initWithEnemyId:(int)enemyId {
    self = [super init];
	if (self) {
        
        // 初期値設定
        self._enemyId = enemyId;
                
        // アニメーションの最初のコマを読み込む
        NSString* fileName = [NSString stringWithFormat:@"enemy%d_right1.png", self._enemyId];
        self._playerSprite = [CCSprite spriteWithSpriteFrameName:fileName];
        [self addChild:self._playerSprite];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)stageOn:(int)order { // TODO:: orderの実装
    [ScaleUtil setPosition:self x:150 y:760 offsetX:0 offsetY:-self._playerSprite.contentSize.height / 2];
    [[GameScene sharedInstance].gameLayer addChild:self];
}

- (void)start {
    [self._playerSprite runAction:[PlayerAnimation getWalk:self._enemyId]];
}

- (void)stop {
    [self stopAllActions];
}

@end
