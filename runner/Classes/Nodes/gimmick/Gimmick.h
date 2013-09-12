//
//  Gimmick.h
//  runner
//
//  Created by Ayumi Otomo on 2013/08/12.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Gimmick : CCNode {
    
}
@property (nonatomic, retain)CCSprite *_sprite;

// ギミック配置
- (void)stageOn:(CCNode*)page;
- (void)stageOff;
- (void)start;
- (void)stop;
- (void)reset;

// プロパティ取得
- (CGRect)getLayerBasedBox;
- (CGRect)getLayerBasedBox:(CCSprite*)sprite;
- (CGPoint)getLayerBasedPosition;
- (float)getWidth;
- (float)getHeight;

@end
