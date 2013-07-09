//
//  Block.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/09.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Block.h"
#import "ScaleUtil.h"
#import "GameScene.h"

@interface Block ()
@property (nonatomic, retain)CCSprite *_sprite;
@end

@implementation Block

- (id)init {
    self = [super init];
	if (self) {

        // TODO:: 画像の切り替え
        self._sprite = [CCSprite spriteWithSpriteFrameName:@"land1.png"];
        [self addChild:self._sprite];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (float)getWidth {
    return self._sprite.contentSize.width;
}

- (float)getHeight {
    return self._sprite.contentSize.height;
}

- (CGRect)getBox {
    return CGRectMake(self.position.x - [self getWidth] / 2, self.position.y - [self getHeight] / 2, [self getWidth], [self getHeight]);
}
@end
