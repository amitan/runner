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
@property (nonatomic, retain)CCLabelTTF* _talkLabel;
@property (nonatomic, retain)NSArray *_texts;
@property (nonatomic, readwrite)int _step;
@property (nonatomic, retain)NSInvocation* _listener;
- (void)_showWindow;
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
        CCSprite *talkBaseSprite = [CCSprite spriteWithSpriteFrameName:@"talk_base.png"];
        [PointUtil setCenterPosition:talkBaseSprite x:320 y:800];
        [self addChild:talkBaseSprite];

        // 詳細ラベル
        self._talkLabel = [LabelUtil createLabel:@"" fontSize:30 dimensions:CGSizeMake(524, 264) hAlignment:kCCTextAlignmentLeft vAlignment:kCCVerticalTextAlignmentTop];
        self._talkLabel.anchorPoint = ccp(0, 0);
        self._talkLabel.position = [PointUtil getPosition:24 y:-24];
        [talkBaseSprite addChild:self._talkLabel];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)onEnter {
    [super onEnter];
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self
                                                              priority:POPUP_PRIORITY
                                                       swallowsTouches:YES];
    [self _showWindow];
}

- (void)_showWindow {
    self._step = 0;
    [self._talkLabel setString:[self._texts objectAtIndex:self._step]];
}

- (void)onExit {
    [super onExit];
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}

- (void)setTexts:(NSArray *)texts {
    self._texts = texts;
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
    self._step++;
    if (self._step >= self._texts.count) {
        if (self._listener) {
            [self._listener invoke];
        }
        [self removeFromParentAndCleanup:NO];
    } else {
        [self._talkLabel setString:[self._texts objectAtIndex:self._step]];
    }
}


@end
