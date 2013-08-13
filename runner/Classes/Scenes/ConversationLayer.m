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
@property (nonatomic, retain)CCSprite* _talkBaseSprite;
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
        self._talkBaseSprite = [CCSprite spriteWithSpriteFrameName:@"talk_base.png"];
        [PointUtil setCenterPosition:self._talkBaseSprite x:320 y:800];
        [self addChild:self._talkBaseSprite];

        // 詳細ラベル
        self._talkLabel = [LabelUtil createLabel:@"" fontSize:30 dimensions:CGSizeMake(554, 264) hAlignment:kCCTextAlignmentLeft vAlignment:kCCVerticalTextAlignmentTop];
        self._talkLabel.anchorPoint = ccp(0, 0);
        self._talkLabel.position = [PointUtil getPosition:24 y:-24];
        [self._talkBaseSprite addChild:self._talkLabel];

        // タイトル追加
//        CCSprite *titleSprite = [CCSprite spriteWithSpriteFrameName:@"title_over.png"];
//        [GameUtil setWindowPosition:titleSprite base:self._baseSprite x:125 y:270];
//        [self._baseSprite addChild:titleSprite];
//        
//        // 原因追加
//        self._gameOverDesc = [GameUtil createLabel:@"" fontSize:22];
//        self._gameOverDesc.position = ccp(self._baseSprite.contentSize.width / 2, [GameUtil getPoint:360]);
//        [self._baseSprite addChild:self._gameOverDesc];
//        
//        // 区切り線追加
//        CCSprite *lineSprite = [CCSprite spriteWithSpriteFrameName:@"window_line.png"];
//        lineSprite.position = ccp(self._baseSprite.contentSize.width / 2, self._baseSprite.contentSize.height / 2);
//        [self._baseSprite addChild:lineSprite];
//        
//
//        self._enemyResult = [GameUtil createLabel:@"" fontSize:22];
//        self._enemyResult.anchorPoint = ccp(0, 0.5f);
//        self._enemyResult.position = [GameUtil getCCP:130 y:210];
//        [self._baseSprite addChild:self._enemyResult];
//        
//        self._hpResult = [GameUtil createLabel:@"" fontSize:22];
//        self._hpResult.anchorPoint = ccp(0, 0.5f);
//        self._hpResult.position = [GameUtil getCCP:130 y:160];
//        [self._baseSprite addChild:self._hpResult];
//        
//        // 戻るボタン追加
//        CCSpriteButton *backButton = [CCSpriteButton spriteWithSpriteFrameName:@"btn_back.png"];
//        [backButton addClickListner:self selector:@selector(clickRetryButton:)];
//        [GameUtil setWindowPosition:backButton base:self._baseSprite x:95 y:627];
//        [self._baseSprite addChild:backButton];
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
    
//    // 表示項目を設定
//    Dungeon *dungeon = [GameScene sharedInstance].dungeon;
//    HeaderController *headerController = [GameScene sharedInstance].headerController;
//    int moves = dungeon.maxMoves - [headerController getRemainMoves];
//    [self._tileResult setString:[NSString stringWithFormat:@"パネル移動回数: %d / %d", moves, dungeon.maxMoves]];
//    int killedEnemyNum = [headerController getKilledEnemyNum];
//    [self._enemyResult setString:[NSString stringWithFormat:@"倒したモンスターの数: %d / %d", killedEnemyNum, dungeon.maxEnemyNum]];
//    int hp = [GameScene sharedInstance].player.hp;
//    [self._hpResult setString:[NSString stringWithFormat:@"HP: %d / %d", hp, [GameScene sharedInstance].player.maxHp]];
//    
//    if (moves >= dungeon.maxMoves) {
//        [self._gameOverDesc setString:@"移動回数がオーバーしました"];
//    } else if (hp <= 0){
//        [self._gameOverDesc setString:@"HPがゼロになりました"];
//    } else {
//        [self._gameOverDesc setString:@"ゲームを途中で終了してしまいました"];
//    }
//    
//    // ウィンドウを表示
//    [self._baseSprite runAction:[CommonAnimation getWindowShow:nil]];
}

- (void)onExit {
    [super onExit];
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}

- (void)setTexts:(NSArray *)texts {
    self._texts = texts;
}

- (void)addClickListner:(id)target selector:(SEL)selector;
{
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
