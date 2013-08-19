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
@property (nonatomic, readwrite)int _homeStep, _nodeId;
@property (nonatomic, readwrite)int _direction;
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
        NSString* fileName = [NSString stringWithFormat:@"carpenter%d_%@1.png", self._nodeId, [GameUtil getDirectionStr:self._direction]];
        self._sprite = [CCSprite spriteWithSpriteFrameName:fileName];
        [self addChild:self._sprite];
        [self addClickListner:self selector:@selector(clickButton:)];
    }
    return self;
}

- (void)clickButton:(id)sender {
    HomeController *homeController = [HomeScene sharedInstance].homeController;
    ConversationLayer *conversationLayer = [homeController getConversationLayer];
    
    // 会話設定
    NSArray *conversationTexts = @[@"*「おれは大工のケンってんだ。ここに冒険者のためのでっけぇ宿をつくりてぇんだが、ゴールドが足りなくてよ。」",
                                   @"*「1000G もあればいいものがつくれるんだが・・」",
                                   @"*「そうか、つまんねぇこと言ってすまなかったな。気が変わったらまた声かけてくれや。」"];
    [conversationLayer setTexts:conversationTexts];
    [conversationLayer addCompleteListner:self selector:@selector(onConversationClose:)];
    [conversationLayer setConfirmCommand:2];
    
    // 会話レイヤー表示
    [homeController suspend];
    [[HomeScene sharedInstance].popupLayer addChild:conversationLayer z:100];
}

// 会話終了時
- (void)onConversationClose:(id)sender {
    [[HomeScene sharedInstance].homeController resume];
}
- (void)start {
    NSString *fileName = [NSString stringWithFormat:@"carpenter%d_%@", self._nodeId, [GameUtil getDirectionStr:self._direction]];
    [self._sprite runAction:[CommonAnimation getFrameRepeatAction:fileName frameNum:2 duration:0.5f]];
}

- (void)stop {
    [self._sprite stopAllActions];
}

@end
