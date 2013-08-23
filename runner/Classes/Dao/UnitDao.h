//
//  UnitDao.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/21.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnitDao : NSObject

// 指定した所持キャラが編成中からどうか
+ (BOOL)isUnit:(int)sequenceId;

// 編成プレイヤーを取得
+ (int)getUnitSequenceId:(int)order;

@end
