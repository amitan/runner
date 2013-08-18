//
//  PlayerSelectLayer.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/18.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "PlayerSelectLayer.h"
#import "GameUtil.h"
#import "PointUtil.h"
#import "LabelUtil.h"
#import "CCSpriteButton.h"
#import "ColorUtil.h"

@interface PlayerSelectLayer ()
@property (nonatomic, retain)NSInvocation* _listener;
@property (nonatomic, retain)CCSprite *_popupBaseSprite;
@end

@implementation PlayerSelectLayer

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
        self._popupBaseSprite = [CCSprite spriteWithSpriteFrameName:@"popup_square_large.png"];
        [PointUtil setTLPosition:self._popupBaseSprite x:45 y:252];
        [self addChild:self._popupBaseSprite];
        
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)onEnter {
    [super onEnter];
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self
                                                              priority:UPPER_POPUP_PRIORITY
                                                       swallowsTouches:YES];
    [self _showWindow];
}

- (void)_showWindow {

    // 所持キャラリスト取得
    NSArray *charaArray = [NSArray arrayWithObjects:@"1001001", nil];
    int popupButtonPriority = UPPER_POPUP_PRIORITY - 1;

    // TODO: キャラ編成
    int count = 0;
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            if (i == 0 && j == 0 && self.orderNo != 1) {
                NSString *fileName = @"popup_square_small.png";
                CCSpriteButton *chara = [CCSpriteButton spriteWithSpriteFrameName:fileName];
                chara.property = popupButtonPriority;
                chara.position = [PointUtil getPosition:80 + j * 130 y:470 - i * 130];
                [self._popupBaseSprite addChild:chara];
                CCLabelTTF *releaseLabel = [LabelUtil createLabel:@"はずす" fontSize:26];
                [chara addLabel:releaseLabel];
                
            } else {
                if (count < charaArray.count) {
                    int playerId = [[charaArray objectAtIndex:count] intValue];
                    NSString *fileName = [NSString stringWithFormat:@"player%d_stand.png", playerId];
                    CCSpriteButton *chara = [CCSpriteButton spriteWithSpriteFrameName:fileName];
                    chara.property = popupButtonPriority;
                    chara.changeColor = false;
                    chara.position = [PointUtil getPosition:80 + j * 130 y:470 - i * 130];
                    [self._popupBaseSprite addChild:chara];
                    CCLabelTTF *useLabel = [LabelUtil createLabel:@"使用中" fontSize:26];
                    useLabel.color = [ColorUtil getWarningRedColor];
                    [chara addLabel:useLabel];
                }
                count++;
            }
        }
    }
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
    [self._popupBaseSprite removeAllChildren];
    [self removeFromParentAndCleanup:NO];
}

@end
