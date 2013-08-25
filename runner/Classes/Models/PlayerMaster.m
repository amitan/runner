//
//  PlayerMaster.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/18.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "PlayerMaster.h"

@interface PlayerMaster ()
@property (nonatomic, retain)NSMutableDictionary *_masterDictionary;
@property (nonatomic, retain)NSMutableDictionary *_specialDictionary;
@end

@implementation PlayerMaster
static PlayerMaster *_master = nil;

+ (PlayerMaster *)getInstance {
    if (_master == nil) {
        _master = [[[self alloc] init] autorelease];
    }
	return _master;
}

- (id)init {
    self = [super init];
	if (self) {
        self._masterDictionary = [NSMutableDictionary dictionary];
        [self._masterDictionary setObject:@{ @"name": @"ゆうしゃ", @"maxLevel": @99, @"specialType": @0, @"frameNum": @2} forKey:@"1001001"];
        [self._masterDictionary setObject:@{ @"name": @"スライム", @"maxLevel": @15, @"specialType": @1, @"frameNum": @3} forKey:@"2001001"];
        
        self._specialDictionary = [NSMutableDictionary dictionary];
        [self._specialDictionary setObject:@"特になし" forKey:@"0"];
        [self._specialDictionary setObject:@"2段ジャンプ" forKey:@"1"];
    }
    return self;
}

- (void)dealloc {
    self._masterDictionary = nil;
    self._specialDictionary = nil;
    _master = nil;
    [super dealloc];
}

- (NSString*)getName:(int)playerId {
    NSDictionary *player = self._masterDictionary[[NSString stringWithFormat:@"%d", playerId]];
    return player[@"name"];
}

- (int)getFrameNum:(int)playerId {
    NSDictionary *player = self._masterDictionary[[NSString stringWithFormat:@"%d", playerId]];
    return [player[@"frameNum"] intValue];
}

- (int)getMaxLevel:(int)playerId {
    NSDictionary *player = self._masterDictionary[[NSString stringWithFormat:@"%d", playerId]];
    return [player[@"maxLevel"] intValue];
}

- (int)getSpecialType:(int)playerId {
    NSDictionary *player = self._masterDictionary[[NSString stringWithFormat:@"%d", playerId]];
    return [player[@"specialType"] intValue];    
}

- (int)getJumpNum:(int)playerId {
    int specialType = [[PlayerMaster getInstance] getSpecialType:playerId];
    switch (specialType) {
        case 1:
            return 2;
        default:
            return 1;
    }
}

- (NSString*)getSpecialName:(int)typeId {
    return self._specialDictionary[[NSString stringWithFormat:@"%d", typeId]];
}

- (int)getNextGold:(int)playerId currentLevel:(int)level {
    if (level <= 10) { // 100 - 1000
        return level * 100;
    } else if (level <= 29){ // 2000 - 20000
        return 1000 + 1000 * (level - 10);
    } else  { // 30000 - 10100000
        return 20000 + 10000 * (level - 29);
    }
}

- (int)getGoldBonus:(int)playerId currentLevel:(int)level {
    return level * 9;
}

@end
