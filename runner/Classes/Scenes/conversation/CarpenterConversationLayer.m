//
//  CarpenterConversationLayer.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/19.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "CarpenterConversationLayer.h"

@implementation CarpenterConversationLayer

- (void)_showWindow {
    [super showWindow];
    self.isSuccessful = false;
}

- (void)executeYes {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    int gold = [[userDefaults objectForKey:@"gold"] intValue];
    if (gold >= self.price) {
        
        // ゴールド・進捗更新
        gold -= self.price;
        [self._coinNumLabel setString:[NSString stringWithFormat:@"%d", gold]];
        [userDefaults setObject:[NSNumber numberWithInt:gold] forKey:@"gold"];
        int nextStep = [[userDefaults objectForKey:@"homeStep"] intValue] + 1;
        [userDefaults setObject:[NSNumber numberWithInt:nextStep] forKey:@"homeStep"];
        [userDefaults synchronize];
        
        //　テキスト設定
        [self._texts addObject:@"*「よっしゃ、まかせとけ。次きたときまでにつくっておくからよ！」"];
        self.isSuccessful = true;
        
    } else {
        [self._texts addObject:@"*「おい、ゴールドがたりねぇみてぇだぞ。」"];
    }
    [self fowardConversation];
}

- (void)executeNo {
    [self._texts addObject:@"*「そうか、つまんねぇこと言ってすまなかったな。気が変わったらまた声かけてくれや。」"];
    [self fowardConversation];
}
@end
