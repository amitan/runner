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
#import "CarpenterConversationLayer.h"
#import "HomeScene.h"
#import "PointUtil.h"

@interface Carpenter ()
@property (nonatomic, readwrite)int _homeStep, _nodeId;
@property (nonatomic, readwrite)int _direction;
@property (nonatomic, retain)CarpenterConversationLayer *_conversationLayer;
@property (nonatomic, retain)id _walkAction;
@property (nonatomic, retain)CCSprite *_character;
@end
@implementation Carpenter

+ (Carpenter*)create:(int)homeStep {
    return [[[self alloc] initWithHomeStep:homeStep] autorelease];
}

- (id)initWithHomeStep:(int)homeStep {
    self = [super init];
	if (self) {
        
        // 初期値設定
        self._homeStep = homeStep;
        self._nodeId = 1;
        self._direction = BOTTOM;
        
        // アニメーションの最初のコマを読み込む
        NSString* fileName = [NSString stringWithFormat:@"towner%d_%@1.png", self._nodeId, [GameUtil getDirectionStr:self._direction]];
        self._character = [CCSprite spriteWithSpriteFrameName:fileName];
        [self addChild:self._character];
        [self addClickListner:self selector:@selector(clickButton:)];
        [self._sprites addObject:self._character];
        
        // 会話レイヤーの初期化
        self._conversationLayer = [CarpenterConversationLayer node];
    }
    return self;
}

- (void)dealloc {
    self._conversationLayer = nil;
    self._character = nil;
    self._walkAction = nil;
    [super dealloc];
}

- (void)clickButton:(id)sender {
    if (self._conversationLayer.isSuccessful) return;
    
    HomeController *homeController = [HomeScene sharedInstance].homeController;
    int price = [self _getPrice];
    
    // 会話設定
    NSMutableArray *conversationTexts;
    switch (self._homeStep) {
        case 0:
            conversationTexts = [NSMutableArray arrayWithObjects:
                                 @"大工「おれは大工のケンってんだ。ここに冒険者のためのでっけぇ宿をつくりてぇんだが、ゴールドが足りなくてよ。」",
                                 [NSString stringWithFormat:@"大工「%dG もあればいいもんがつくれるんだけどな・・」", price], nil];
            break;
        case 1:
            conversationTexts = [NSMutableArray arrayWithObjects:
                                 @"大工「よぉ、訓練所は気に入ってくれたかい？」",
                                 [NSString stringWithFormat:@"大工「%dG あればもっといいもんがつくれるぜ。どうだい？」", price], nil];
            break;
        default:
            conversationTexts = [NSMutableArray array];
            break;
    }
    [self._conversationLayer setTexts:conversationTexts];
    [self._conversationLayer addCompleteListner:self selector:@selector(onConversationClose:)];
    [self._conversationLayer setConfirmCommand:2];
    [self._conversationLayer setConfirmButtonName:@">> 払う" noName:@"払わない"];
    self._conversationLayer.price = price;
    
    // 会話レイヤー表示
    [homeController suspend];
    [[HomeScene sharedInstance].popupLayer addChild:self._conversationLayer z:100];
}

- (int)_getPrice {
    switch (self._homeStep) {
        case 0:
            return 300;
        case 1:
            return 1000;
        case 2:
            return 10000;
        case 3:
            return 1000000;
        default:
            return 0;
    }
}

// 会話終了時
- (void)onConversationClose:(id)sender {
    [[HomeScene sharedInstance].homeController resume];
    if (self._conversationLayer.isSuccessful) {
        [self move];
    }
}

- (void)start {
    NSString *fileName = [NSString stringWithFormat:@"towner%d_%@", self._nodeId, [GameUtil getDirectionStr:self._direction]];
    self._walkAction = [self._character runAction:[CommonAnimation getFrameRepeatAction:fileName frameNum:2 duration:0.5f]];
}

- (void)stop {
    [self._character stopAllActions];
}

- (void)move {
    id moveDown = [CCMoveBy actionWithDuration:0.2f position:[PointUtil getPosition:0 y:-80]];
    id moveLeft = [CCMoveBy actionWithDuration:0.6f position:[PointUtil getPosition:-240 y:0]];
    id changeDirection = [CCCallBlock actionWithBlock:^{
        [self._character stopAction:self._walkAction];
        self._direction = LEFT;
        [self start];
    }];
    [self._character runAction:[CCSequence actions:moveDown, changeDirection, moveLeft, nil]];
}

@end