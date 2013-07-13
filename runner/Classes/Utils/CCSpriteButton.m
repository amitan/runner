//
//  CCSpriteButton.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/12.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "CCSpriteButton.h"
#import "GameUtil.h"
#import "ColorUtil.h"
#import "PointUtil.h"

@interface CCSpriteButton ()
@property (nonatomic, readwrite)BOOL _isTouch;
@property (nonatomic, retain)NSInvocation* _listener;
@property (nonatomic, retain)CCLabelTTF* _label;
@end

@implementation CCSpriteButton
@synthesize _isTouch;
@synthesize _listener;
@synthesize isEnabled;
@synthesize property;


- (id)initWithSpriteFrame:(CCSpriteFrame *)spriteFrame {
    self = [super initWithSpriteFrame:spriteFrame];
    if (self) {
        property = BUTTON_PRIORITY;
        isEnabled = YES;
    }
    return self;
}

- (void)dealloc {
    self._listener = nil;
    [super dealloc];
}

- (void)setIsEnabled:(BOOL)_isEnabled {
    isEnabled = _isEnabled;
    if (isEnabled) {
        self.color = [ColorUtil getDefaultFontColor];
    } else {
//        [GameUtil disabled:self];
    }
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
    CGPoint localLocation = [[self parent] convertToNodeSpace:touchLocation];
    if (CGRectContainsPoint(self.boundingBox, localLocation)) {
        if (!self._isTouch) {
            self._isTouch = YES;
            [self onPress];
            return YES;
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
        CGPoint localLocation = [[self parent] convertToNodeSpace:touchLocation];
        if (CGRectContainsPoint(self.boundingBox, localLocation)) {
            if (self._listener) {
//                [[Audio sharedInstance] playEffect:@"button.mp3"]; TODO:: 効果音実装
                [self._listener invoke];
            }
        }
    }
}

- (void)onPress {
    if (self._label) self._label.color = [ColorUtil getTouchedFontColor];
}

- (void)onRelease {
    if (self._label) self._label.color = [ColorUtil getDefaultFontColor];
}

- (void)addLabel:(CCLabelTTF *)label {
    [self addLabel:label offsetX:0 offsetY:0];
}

- (void)addLabel:(CCLabelTTF *)label offsetX:(int)x offsetY:(int)y {
    int dx = [PointUtil getPoint:x];
    int dy = [PointUtil getPoint:y];
    label.position = ccp(self.contentSize.width / 2 + dx, self.contentSize.height / 2 + dy);
    [self addChild:label];
    self._label = label;
}

@end
