//
//  Rail.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/12.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Gimmick.h"

@interface Rail : Gimmick {
    
}
@property (nonatomic, retain)CCSprite *_sprite;
@property (nonatomic, readwrite)int _railId;

// 指定したレールを生成する
+ (Rail*)createRail:(int)railId;
+ (Rail*)createRail:(int)railId x:(float)x y:(float)y;

// レールを指定して初期化する
-(id)initWithRailId:(int)railId;

@end
