//
//  StageLayer.h
//  runner
//
//  Created by Ayumi Otomo on 2013/07/13.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface StageLayer : CCLayer {
    
}

// ステージ選択レイヤーを含むシーンオブジェクトを返すメソッド
+ (CCScene *)scene;

// エリアを指定してステージ選択シーンオブジェクトを返すメソッド
+ (CCScene *)scene:(int)worldId areaId:(int)areaId;

// エリアを指定して初期化する
- (id)initWithArea:(int)worldId areaId:(int)areaId;

@end
