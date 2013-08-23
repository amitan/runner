//
//  ConversationLayer.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/13.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "ConversationLayer.h"
#import "GameUtil.h"
#import "PointUtil.h"
#import "LabelUtil.h"

@interface ConversationLayer ()
@property (nonatomic, retain)CCSprite *_talkBaseSprite;
@property (nonatomic, readwrite)int _step, _confirmStep;
@property (nonatomic, retain)NSInvocation* _listener;
@property (nonatomic, readwrite)BOOL _isLock;
@end

@implementation ConversationLayer

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
        self._talkBaseSprite = [CCSprite spriteWithSpriteFrameName:@"talk_base.png"];
        [PointUtil setCenterPosition:self._talkBaseSprite x:320 y:800];
        [self addChild:self._talkBaseSprite];

        // 詳細ラベル
        self._talkLabel = [LabelUtil createLabel:@"" fontSize:28 dimensions:CGSizeMake(524, 264) hAlignment:kCCTextAlignmentLeft vAlignment:kCCVerticalTextAlignmentTop];
        self._talkLabel.anchorPoint = ccp(0, 0);
        self._talkLabel.position = [PointUtil getPosition:24 y:-24];
        [self._talkBaseSprite addChild:self._talkLabel];
        
        // 確認ボタン追加
        int buttonProperty = POPUP_PRIORITY - 1;
        self._yesButton = [CCSpriteButton spriteWithSpriteFrameName:@"popup_command.png"];
        self._yesButton.property = buttonProperty;
        self._yesButton.position = [PointUtil getPosition:150 y:70];
        [self._yesButton addClickListner:self selector:@selector(clickYesButton:)];
        [self._talkBaseSprite addChild:self._yesButton];
        self._yesLabel = [LabelUtil createLabel:@">> はい" fontSize:34];
        [self._yesButton addLabel:self._yesLabel];
        
        self._noButton = [CCSpriteButton spriteWithSpriteFrameName:@"popup_command.png"];
        self._noButton.property = buttonProperty;
        self._noButton.position = [PointUtil getPosition:410 y:70];
        [self._noButton addClickListner:self selector:@selector(clickNoButton:)];
        [self._talkBaseSprite addChild:self._noButton];
        self._noLabel = [LabelUtil createLabel:@">> いいえ" fontSize:34];
        [self._noButton addLabel:self._noLabel];
        
        // コイン表示追加
        self._coinWindow = [CoinWindow node];
        [PointUtil setTLPosition:self._coinWindow x:556 y:144];
        [self addChild:self._coinWindow];
    }
    return self;
}

- (void)dealloc {
    self._talkLabel = nil;
    self._yesLabel = nil;
    self._noLabel = nil;
    self._yesButton = nil;
    self._noButton = nil;
    self._coinWindow = nil;
    self._texts = nil;
    self._talkBaseSprite = nil;
    self._listener = nil;
    [super dealloc];
}

- (void)onEnter {
    [super onEnter];
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self
                                                              priority:POPUP_PRIORITY
                                                       swallowsTouches:YES];
    [self showWindow];
}

- (void)showWindow {
    self._step = 0;
    self._isLock = false;
    
    // コイン表示
    [self._coinWindow sync];
    [self fowardConversation];
}

- (void)onExit {
    [super onExit];
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}

- (void)setTexts:(NSMutableArray *)texts {
    self._texts = texts;
}

- (void)addCompleteListner:(id)target selector:(SEL)selector {
	if (target && selector) {
		NSMethodSignature *signature = [[target class] instanceMethodSignatureForSelector:selector];
		self._listener = [NSInvocation invocationWithMethodSignature:signature];
		[self._listener setTarget:target];
		[self._listener setSelector:selector];
        [self._listener setArgument:&self atIndex:2];
	}
}

- (void)setConfirmCommand:(int)step {
    self._confirmStep = step;
}

- (void)setConfirmButtonName:(NSString*)yesName noName:(NSString*)noName {
    [self._yesLabel setString:yesName];
    [self._noLabel setString:noName];
}


- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    [self fowardConversation];
}

- (void)fowardConversation {

    // 確認コマの場合はボタンを押すまで閉じない
    if (self._isLock) {
        return;
    }

    // ボタン表示初期化
    self._yesButton.visible = false;
    self._noButton.visible = false;
    self._yesButton.isEnabled = false;
    self._noButton.isEnabled = false;
    

    // 会話を次に進める
    if (self._step >= self._texts.count) {
        [self closeConversation];
    } else {

        [self._talkLabel setString:[self._texts objectAtIndex:self._step]];
        
        // 確認コマの場合はボタン表示
        if (self._confirmStep > 0 && self._confirmStep - 1 == self._step) {
            self._yesButton.visible = true;
            self._noButton.visible = true;
            self._yesButton.isEnabled = true;
            self._noButton.isEnabled = true;
            self._isLock = true;
        }
    }
    self._step++;
}

- (void)clickYesButton:(id)sender {
    self._isLock = false;
    [self executeYes];
}

- (void)clickNoButton:(id)sender {
    self._isLock = false;
    [self executeNo];
}


- (void)executeYes {
}

- (void)executeNo {
    [self fowardConversation];
}

- (void)closeConversation {
    if (self._listener) {
        [self._listener invoke];
    }
    [self removeFromParentAndCleanup:NO];
}


@end
