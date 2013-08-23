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
#import "UserPlayerDao.h"
#import "PlayerMaster.h"
#import "CoinWindow.h"
#import "UnitDao.h"

@interface PlayerSelectLayer ()
@property (nonatomic, retain)NSInvocation* _listener;
@property (nonatomic, retain)CCSprite *_popupBaseSprite;
@property (nonatomic, retain)CoinWindow *_coinWindow;
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
        
        // コイン表示
        self._coinWindow = [CoinWindow node];
        [PointUtil setTLPosition:self._coinWindow x:556 y:144];
        [self addChild:self._coinWindow];
    }
    return self;
}

- (void)dealloc {
    self._listener = nil;
    self._popupBaseSprite = nil;
    self._coinWindow = nil;
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
    NSMutableArray *userPlayers = [UserPlayerDao getUserPlayers];
    
    // TODO: キャラ編成
    int count = 0;
    for (int i = 0; i < 4; i++) {
        for (int j = 0; j < 4; j++) {
            if (i == 0 && j == 0 && self.orderNo != 1) {
                CCSpriteButton *chara = [self getOptionButton];
                chara.position = [PointUtil getPosition:80 + j * 130 y:470 - i * 130];
                [self._popupBaseSprite addChild:chara];
                
            } else {
                if (count < userPlayers.count) {
                    NSMutableDictionary *userPlayer = [userPlayers objectAtIndex:count];
                    CCSpriteButton *chara = [self getCharaButton:userPlayer];
                    chara.position = [PointUtil getPosition:80 + j * 130 y:470 - i * 130];
                    [self._popupBaseSprite addChild:chara];
                }
                count++;
            }
        }
    }
    
    // コイン表示更新
    [self._coinWindow sync];
}

- (CCSpriteButton*)getOptionButton {

    // ラベル名決定
    NSString *labelName;
    switch (self.orderNo) {
        case 2:
        case 3:
            labelName = @"はずす";
            break;
        default:
            labelName = @"もどる";
            break;
    }
    
    // ボタン生成
    NSString *fileName = @"popup_square_small.png";
    CCSpriteButton *chara = [CCSpriteButton spriteWithSpriteFrameName:fileName];
    chara.property = UPPER_POPUP_PRIORITY - 1;
    chara.tag = 999;
    [chara addClickListner:self selector:@selector(onSelected:)];
    CCLabelTTF *releaseLabel = [LabelUtil createLabel:labelName fontSize:26];
    [chara addLabel:releaseLabel];
    return chara;
}

- (CCSpriteButton*)getCharaButton:(NSDictionary*)userPlayer {
    
    // キャラ画像生成
    int playerId = [userPlayer[@"playerId"] intValue];
    int sequenceId = [userPlayer[@"sequenceId"] intValue];
    NSString *fileName = [NSString stringWithFormat:@"player%d_stand.png", playerId];
    CCSpriteButton *chara = [CCSpriteButton spriteWithSpriteFrameName:fileName];
    chara.property = UPPER_POPUP_PRIORITY - 1;
    chara.tag = sequenceId;
    [chara addClickListner:self selector:@selector(onSelected:)];

    // レベル生成
    int level = [userPlayer[@"level"] intValue];
    CCLabelTTF *nameLabel = [LabelUtil createLabel:[NSString stringWithFormat:@"Lv: %d", level] fontSize:24];
    nameLabel.position = ccp(chara.contentSize.width / 2, 0);
    [chara addChild:nameLabel];
    
    // レベルアップ時のゴールド
    if (self.orderNo == 4) {
        int nextGold = [[PlayerMaster getInstance] getNextGold:playerId currentLevel:level];
        CCLabelTTF *nextGoldLabel = [LabelUtil createLabel:[NSString stringWithFormat:@"%dG", nextGold] fontSize:30];
        nextGoldLabel.position = ccp(chara.contentSize.width / 2, chara.contentSize.height - nextGoldLabel.contentSize.height / 2);
        [chara addChild:nextGoldLabel];
    }

    // 使用中ラベル付加
    if ([UnitDao isUnit:sequenceId]) {
        CCLabelTTF *useLabel = [LabelUtil createLabel:@"使用中" fontSize:20];
        useLabel.color = [ColorUtil getWarningRedColor];
        useLabel.position = ccp(chara.contentSize.width / 2, chara.contentSize.height - 2 * useLabel.contentSize.height);
        [chara addChild:useLabel];
    }
    
    
    return chara;
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

- (void)onSelected:(id)sender {
    CCSpriteButton *senderButton = (CCSpriteButton*)sender;
    int sequenceId = senderButton.tag;

    // TODO:編成解除
    if (sequenceId == 999) {
        [self close:sequenceId];
    } else {
        [self close:sequenceId];
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    return YES;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    [self close];
}

- (void)close {
    [self close:0];
}
- (void)close:(int)sequenceId {
    if (self._listener) {
        NSNumber *sequenceNumber = [NSNumber numberWithInt:sequenceId];
        [self._listener setArgument:&sequenceNumber atIndex:3];
        [self._listener invoke];
    }
    [self._popupBaseSprite removeAllChildren];
    [self removeFromParentAndCleanup:NO];    
}

@end
