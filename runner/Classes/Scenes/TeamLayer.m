//
//  TeamLayer.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/17.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "TeamLayer.h"
#import "GameUtil.h"
#import "PointUtil.h"
#import "CCSpriteButton.h"
#import "ColorUtil.h"
#import "LabelUtil.h"

@interface TeamLayer ()
@property (nonatomic, retain)NSInvocation* _listener;
@property (nonatomic, retain)CCSpriteButton *_player1Button, *_player2Button, *_player3Button;
@end

@implementation TeamLayer

- (id)init {
    self = [super init];
	if (self) {
        
        // 背景の追加
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        CCSprite *black = [CCSprite spriteWithSpriteFrameName:@"black.png"];
        black.scaleY = 1.5;
        black.position = ccp(winSize.width / 2, winSize.height / 2);
        [self addChild:black];
        
        // ベースウィンドウ追加
        CCSprite *popupBaseSprite = [CCSprite spriteWithSpriteFrameName:@"popup_large.png"];
        [PointUtil setTLPosition:popupBaseSprite x:45 y:120];
        [self addChild:popupBaseSprite];
        
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        int playerId1 = [[userDefaults objectForKey:@"player1"] intValue];
        int playerId2 = [[userDefaults objectForKey:@"player2"] intValue];
        int playerId3 = [[userDefaults objectForKey:@"player3"] intValue];

        // プレイヤー1
        CCSpriteButton *base1Button = [CCSpriteButton spriteWithSpriteFrameName:@"player_base_middle.png"];
        base1Button.position = [PointUtil getPosition:276 y:660];
        [base1Button addClickListner:self selector:@selector(clickPlayerButton:)];
        [popupBaseSprite addChild:base1Button];
        self._player1Button = base1Button;
        
        CCSprite *player1 = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"player%d_stand.png", playerId1]];
        player1.position = [PointUtil getPosition:62 y:188];
        [base1Button addChild:player1];

        CCLabelTTF *player1Name = [LabelUtil createLabel:@"ゆうしゃ Lv: 1/99" fontSize:26 dimensions:CGSizeMake(386, 60) alignment:kCCTextAlignmentLeft];
        player1Name.position = [PointUtil getPosition:307 y:200];
        [base1Button addChild:player1Name];

        CCLabelTTF *nextLevel1 = [LabelUtil createLabel:@"次のレベルまであと 100 G" fontSize:26 dimensions:CGSizeMake(386, 60) alignment:kCCTextAlignmentLeft];
        nextLevel1.position = ccpAdd(player1Name.position, [PointUtil getPosition:0 y:-42]);
        [base1Button addChild:nextLevel1];

        CCLabelTTF *gold1 = [LabelUtil createLabel:@"ゴールドボーナス: +1%" fontSize:26 dimensions:CGSizeMake(386, 60) alignment:kCCTextAlignmentLeft];
        gold1.position = [PointUtil getPosition:213 y:106];;
        [base1Button addChild:gold1];

        CCLabelTTF *item1 = [LabelUtil createLabel:@"アイテムボーナス: 特になし" fontSize:26 dimensions:CGSizeMake(386, 60) alignment:kCCTextAlignmentLeft];
        item1.position = ccpAdd(gold1.position, [PointUtil getPosition:0 y:-32]);
        [base1Button addChild:item1];

        CCLabelTTF *special1 = [LabelUtil createLabel:@"とくぎ: 特になし" fontSize:26 dimensions:CGSizeMake(386, 60) alignment:kCCTextAlignmentLeft];
        special1.position = ccpAdd(item1.position, [PointUtil getPosition:0 y:-32]);
        [base1Button addChild:special1];

        // プレイヤー2
        CCSpriteButton *base2Button = [CCSpriteButton spriteWithSpriteFrameName:@"player_base_middle.png"];
        base2Button.position = [PointUtil getPosition:276 y:406];
        [base2Button addClickListner:self selector:@selector(clickPlayerButton:)];
        [popupBaseSprite addChild:base2Button];
        self._player2Button = base2Button;

        // プレイヤー3
        CCSpriteButton *base3Button = [CCSpriteButton spriteWithSpriteFrameName:@"player_base_middle.png"];
        base3Button.position = [PointUtil getPosition:276 y:152];
        [base3Button addClickListner:self selector:@selector(clickPlayerButton:)];
        [popupBaseSprite addChild:base3Button];
        self._player3Button = base3Button;

        // ボタンの優先度を調整
        int popupButtonPriority = POPUP_PRIORITY - 1;
        base1Button.property = popupButtonPriority;
        base2Button.property = popupButtonPriority;
        base3Button.property = popupButtonPriority;

    }
    return self;
}

- (void)clickPlayerButton:(id)sender {
}

- (void)dealloc {
    [super dealloc];
}

- (void)onEnter {
    [super onEnter];
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self
                                                              priority:POPUP_PRIORITY
                                                       swallowsTouches:YES];
}

- (void)onExit {
    [super onExit];
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}

- (void)addCompleteListner:(id)target selector:(SEL)selector {
	if( target && selector ) {
		NSMethodSignature *signature = [[target class] instanceMethodSignatureForSelector:selector];
		self._listener = [NSInvocation invocationWithMethodSignature:signature];
		[self._listener setTarget:target];
		[self._listener setSelector:selector];
        [self._listener setArgument:&self atIndex:2];
	}
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    if (self._listener) {
        [self._listener invoke];
    }
    [self removeFromParentAndCleanup:NO];
}

@end
