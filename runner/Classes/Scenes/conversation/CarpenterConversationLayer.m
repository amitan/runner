//
//  CarpenterConversationLayer.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/19.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "CarpenterConversationLayer.h"
#import "GameDao.h"

@implementation CarpenterConversationLayer

- (void)_showWindow {
    [super showWindow];
    self.isSuccessful = false;
}

- (void)executeYes {
    int gold = [GameDao getGold];
    if (gold >= self.price) {
        
        // ゴールド・進捗更新
        [GameDao useGold:gold];
        [GameDao incrementHoemStep];
        [self._coinWindow sync];
        
        //　テキスト設定
        [self._texts addObject:@"大工「よっしゃ、まかせとけ。次きたときまでにつくっておくからよ！」"];
        self.isSuccessful = true;
        
    } else {
        [self._texts addObject:@"大工「おい、ゴールドがたりねぇみてぇだぞ。」"];
    }
    [self fowardConversation];
}

- (void)executeNo {
    [self._texts addObject:@"大工「そうか、つまんねぇこと言ってすまなかったな。気が変わったらまた声かけてくれや。」"];
    [self fowardConversation];
}
@end
