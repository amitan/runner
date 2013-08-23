//
//  PlayerMaster.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/18.
//  Copyright (c) 2013年 Ayumi Otomo. All rights reserved.
//

#import "PlayerMaster.h"

@interface PlayerMaster ()
@property (nonatomic, retain)NSMutableDictionary *_dictionary;
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
        self._dictionary = [NSMutableDictionary dictionary];
        [self._dictionary setObject:@{ @"name": @"ゆうしゃ", @"maxLevel": @99, @"specialType": @0 } forKey:@"1001001"];
    }
    return self;
}

- (void)dealloc {
    self._dictionary = nil;
    _master = nil;
    [super dealloc];
}

- (NSString*)getName:(int)playerId {
    NSDictionary *player = self._dictionary[[NSString stringWithFormat:@"%d", playerId]];
    return player[@"name"];
}

- (int)getMaxLevel:(int)playerId {
    NSDictionary *player = self._dictionary[[NSString stringWithFormat:@"%d", playerId]];
    return [player[@"maxLevel"] intValue];
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
