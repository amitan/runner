//
//  ConversationLayer.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/13.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CCSpriteButton.h"

@interface ConversationLayer : CCLayer {
    
}
// 継承先で利用するため
@property (nonatomic, retain)CCLabelTTF *_talkLabel, *_coinNumLabel, *_yesLabel, *_noLabel;
@property (nonatomic, retain)CCSpriteButton *_yesButton, *_noButton;
@property (nonatomic, retain)NSMutableArray *_texts;

// 会話を設定実行
- (void)setTexts:(NSMutableArray *)texts;
- (void)showWindow;
- (void)fowardConversation;

// 会話完了時の処理を設定
- (void)closeConversation;
- (void)addCompleteListner:(id)target selector:(SEL)selector;

// 確認フレームの設定
- (void)setConfirmCommand:(int)step;
- (void)setConfirmButtonName:(NSString*)yesName noName:(NSString*)noName;

// 確認後の処理を実行する
- (void)executeYes;
- (void)executeNo;


@end
