//
//  SkyMap.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/29.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Map.h"

@interface SkyMap : Map {
    
}

// 指定したマップを生成する
+ (SkyMap*)createMap:(int)stageId;

// ステージを指定してマップを初期化する
- (id)initWithStageId:(int)stageId;

@end
