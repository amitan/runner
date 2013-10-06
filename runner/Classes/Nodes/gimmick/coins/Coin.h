//
//  Coin.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/16.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Gimmick.h"

@interface Coin : Gimmick {
    
}
@property (nonatomic, readwrite)int _coinId;
@property (nonatomic, readwrite)int _groupId;
@property (nonatomic, readwrite)BOOL _isStaged;
@property (nonatomic, readwrite)int _value;

typedef enum {
    C_STANDARD = 1,
    C_SWITCH = 4,
    C_100 = 5
} COIN_TYPE;

// 指定したコインを生成する
+ (Coin*)createCoin:(int)coinId;
+ (Coin*)createCoin:(int)coinId groupId:(int)groupId;
+ (Coin*)createCoin:(int)coinId x:(float)x y:(float)y;
+ (Coin*)createCoin:(int)coinId groupId:(int)groupId x:(float)x y:(float)y;
+ (Coin*)createCoin:(int)coinId bx:(float)bx by:(float)by;
+ (NSArray*)createCoins:(int)coinId bx:(float)bx by:(float)by num:(int)num;

// コインを指定して初期化する
-(id)initWithCoinId:(int)coinId groupId:(int)groupId;

// 座標がコインに含まれているか判定する
- (BOOL)takenIfCollided:(CGRect)rect magnet:(BOOL)isMagnet;
- (BOOL)takenIfCollided:(CGPoint)point radius:(float)radius;

// コインを取得済みか
- (BOOL)hasTaken;

// コインを表示する
- (void)appear:(int)groupId;

// コインを降らせる
- (void)drop;

@end
