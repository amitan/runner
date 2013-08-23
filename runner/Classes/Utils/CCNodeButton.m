//
//  CCNodeButton.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/13.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "CCNodeButton.h"
#import "GameUtil.h"
#import "ColorUtil.h"

@interface CCNodeButton ()
@property (nonatomic, readwrite)BOOL _isTouch;
@property (nonatomic, retain)NSInvocation* _listener;
@end

@implementation CCNodeButton
@synthesize _isTouch;
@synthesize _listener;
@synthesize isEnabled;
@synthesize property;


- (id)init {
    self = [super init];
	if (self) {
        self._sprites = [CCArray arrayWithCapacity:1];
        property = BUTTON_PRIORITY;
        isEnabled = YES;
    }
    return self;
}

- (void)dealloc {
    self._listener = nil;
    self._sprites = nil;
    [super dealloc];
}

- (void)setIsEnabled:(BOOL)_isEnabled {
    isEnabled = _isEnabled;
}

- (void)onEnter {
    [super onEnter];
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:self.property swallowsTouches:YES];
}

- (void)onExit {
    [super onExit];
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
}

- (void)addClickListner:(id)target selector:(SEL)selector;
{
	if( target && selector ) {
		NSMethodSignature *signature = [[target class] instanceMethodSignatureForSelector:selector];
		self._listener = [NSInvocation invocationWithMethodSignature:signature];
		[self._listener setTarget:target];
		[self._listener setSelector:selector];
        [self._listener setArgument:&self atIndex:2];
	}
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    
    if (!self.isEnabled) {
        return NO;
    }
    
    // タッチ座標をcocos2d座標に変換
    CGPoint locationInView = [touch locationInView: [touch view]];
	CGPoint touchLocation = [[CCDirector sharedDirector] convertToGL:locationInView];
    
    // タッチ判定
    CGPoint localLocation = [self convertToNodeSpace:touchLocation];
    for (CCSprite *sprite in self._sprites) {
        if (CGRectContainsPoint(sprite.boundingBox, localLocation)) {
            if (!self._isTouch) {
                self._isTouch = YES;
                [self onPress];
                return YES;
            }
        }
    }
    return NO;
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    
    // タッチ座標をcocos2d座標に変換
    CGPoint locationInView = [touch locationInView: [touch view]];
	CGPoint touchLocation = [[CCDirector sharedDirector] convertToGL:locationInView];
    
    if (self._isTouch) {
        self._isTouch = NO;
        [self onRelease];
        
        // タッチ判定
        CGPoint localLocation = [self convertToNodeSpace:touchLocation];
        for (CCSprite *sprite in self._sprites) {
            if (CGRectContainsPoint(sprite.boundingBox, localLocation)) {
                if (self._listener) {
                    //                [[Audio sharedInstance] playEffect:@"button.mp3"]; TODO:: 効果音実装
                    [self._listener invoke];
                    return;
                }
            }
        }
    }
}

- (void)onPress {
    for (CCSprite *sprite in self._sprites) {
        sprite.color = [ColorUtil getTouchedColor];
    }
}

- (void)onRelease {
    for (CCSprite *sprite in self._sprites) {
        sprite.color = [ColorUtil getDefaultColor];
    }
}

@end
