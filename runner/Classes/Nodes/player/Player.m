//
//  Player.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Player.h"
#import "GameScene.h"
#import "PointUtil.h"
#import "PlayerAnimation.h"
#import "CommonAnimation.h"
#import "Enemy.h"
#import "PointUtil.h"
#import "GameUtil.h"
#import "PlayerMaster.h"
#import "Crystal.h"
#import "PlayerState.h"
#import "Bullet.h"

@interface Player ()
@property (nonatomic, readwrite)int _monsterId;
@property (nonatomic, readwrite)BOOL _isStaged, _isBulletHit, _isInvisible, _isTouching, _isPlaying;
@property (nonatomic, readwrite)int _currentJumpNum, _jumpSpeed, _crystalId;
@property (nonatomic, retain)CCSprite *_playerSprite, *_effectSprite, *_itemEffectSprite;
@property (nonatomic, readwrite)BOOL _onGround, _isForwardAdjusting, _isBackAdjusting, _isReverse, _onTopBlock, _onRailed;
@property (nonatomic, readwrite)float _vx, _vy, _invisibleTime, _limitY;
@property (nonatomic, readwrite)CGPoint _properPosition;
@property (nonatomic, retain)Rail *_currentRail;
@property (nonatomic, retain)PlayerState *_state;
@property (nonatomic, readwrite)float _currentItemTime;
@property (nonatomic, readwrite)int _currentItemId;
@end

@implementation Player
const int INIT_SCROLL_SPEED = 400;
const int BLOCK_TOP_REFLECTION = -10;
const float INVISIBLE_TIME = 2;


+ (Player*)createPlayer:(int)monsterId {
    return [[[self alloc] initWithMonsterId:monsterId isReverse:false] autorelease];
}

+ (Player*)createPlayer:(int)monsterId isReverse:(BOOL)isReverse {
    return [[[self alloc] initWithMonsterId:monsterId isReverse:isReverse] autorelease];
}

- (id)initWithMonsterId:(int)monsterId isReverse:(BOOL)isReverse {
    self = [super init];
	if (self) {
        
        // 初期値設定
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        self._monsterId = monsterId;
        self._isReverse = isReverse;
        self._isStaged = false;
        self._isBulletHit = false;
        self._isInvisible = false;
        self._onGround = true;
        self._vx = [PointUtil getPoint:INIT_SCROLL_SPEED];
        self._isForwardAdjusting = false;
        self._isBackAdjusting = false;
        self._limitY = winSize.height / 2 - [PointUtil getPoint:BASE_HEIGHT / 2];
        self._onTopBlock = false;
        self._onRailed = false;
        self._crystalId = [[PlayerMaster getInstance] getCrystalId:monsterId];
        self._invisibleTime = 0;
        self._isPlaying = false;
        self._currentItemTime = 0;
        self._currentItemId = 0;
        
        // アニメーションの最初のコマを読み込む
        NSString *direction = (isReverse) ? @"left" : @"right";
        NSString* fileName = [NSString stringWithFormat:@"player%d_%@1.png", self._monsterId, direction];
        self._playerSprite = [CCSprite spriteWithSpriteFrameName:fileName];
        [self addChild:self._playerSprite];
        self._effectSprite = [CCSprite spriteWithSpriteFrameName:@"none.png"];
        [self addChild:self._effectSprite];
        
        self._state = [PlayerState create:self._monsterId crystalId:self._crystalId];
        self._jumpSpeed = [PointUtil getPoint:[[PlayerMaster getInstance] getJumpSpeed:self._monsterId]];
    }
    return self;
}

- (void)dealloc {
    [super dealloc];
}

- (void)stageOn {
    self._isStaged = true;
    [PointUtil setPosition:self x:INIT_PLAYER_X y:520 offsetX:0 offsetY:-[self getHeight] / 2];
    self._properPosition = self.position;
    [[GameScene sharedInstance].gameLayer addChild:self z:INIT_PLAYER_Z];
}

- (BOOL)isReverse {
    return self._isReverse;
}

- (void)getOff:(CGPoint)position func:(id)func {
    [self removeFromParentAndCleanup:NO];
    self.position = ccpAdd(position, ccp(0, [self getHeight] / 2));
    [[GameScene sharedInstance].gameLayer addChild:self z:INIT_PLAYER_Z];
    [self runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.2f position:ccp(0, [PointUtil getPoint:100])], func, nil]];
}

- (void)goDown:(id)func {
    id moveDown = [CCMoveTo actionWithDuration:1.0f position:ccpAdd(self._properPosition, ccp(0, -[self getHeight] / 2))];
    id backRotate = [CCRotateBy actionWithDuration:0.8f angle:-720];
    id knockBack = [CCSpawn actions:moveDown, backRotate, nil];
    [self runAction:[CCSequence actions:knockBack, func, nil]];
}

- (void)stageOff {
    [self removeFromParentAndCleanup:NO];
}

- (void)start {
    self._isPlaying = true;
    [self._playerSprite runAction:[PlayerAnimation getWalkAction:self._monsterId isReverse:self._isReverse frameNum:3]];
    [self scheduleUpdate];
}

- (void)invisibleStart {
    self._isPlaying = true;
    self._isInvisible = true;
    self._invisibleTime = INVISIBLE_TIME;
    self._playerSprite.opacity = 128;
    [self._playerSprite runAction:[PlayerAnimation getDamagedAction]];
    [self start];
}

- (void)stop {
    self._isPlaying = false;
    [self unscheduleUpdate];
    [self._playerSprite stopAllActions];
    [self._state reset:self._playerSprite];
}

- (void)touchBegan {
    self._isTouching = true;

    if (self._onRailed) { // レールジャンプ
        self._vy = self._jumpSpeed * 0.8;
        self._onRailed = false;
        [self._playerSprite resumeSchedulerAndActions];

    } else { // ジャンプ
        [self jump];
    }
}

- (void)touchEnd {
    self._isTouching = false;
    self._vy = [self._state touchEnd:self._playerSprite vy:self._vy onGround:self._onGround isReverse:self._isReverse isRunning:self._isPlaying];
}

- (void)jump {
    self._vy = [self._state jump:self._playerSprite num:self._currentJumpNum vy:self._vy onGroud:self._onGround];
    self._currentJumpNum++;
}

- (void)speedUp {
    [[GameScene sharedInstance].hudController showSpeedUpEffect];
    self._vx *= 1.1;
}

- (void)trampoline {
    self._vy = self._jumpSpeed * 1.5;
}

- (BOOL)deadIfBulletCollided:(Bullet*)bullet {
    if (self._isInvisible) {
        return false;
    }
    if (CGRectContainsPoint([self getRect], bullet.position)) {
        if ([self._state ignoreEnemy]) {
            [bullet clear];
        } else {
            self._isBulletHit = true;
        }
        return true;
    }
    return false;
}

- (void)useItem:(Item*)item {
    if (self._currentItemTime <= 0) {
        self._currentItemTime = [item getItemTime];
        self._itemEffectSprite = [CCSprite spriteWithSpriteFrameName:@"none.png"];
        [self addChild:self._itemEffectSprite];
        self._currentItemId = [item getItemId];
        switch (self._currentItemId) {
            case ITEM_MAGNET:
                [self._itemEffectSprite runAction:[CommonAnimation getFrameRepeatAction:@"item1_" frameNum:3 duration:0.3f]];
                break;
        }
    }
}

- (void)update:(ccTime)dt {

    // ステージ上にいなければ何も処理しない
    if (!self._isStaged) return;

    ///////////////////////////////////////////////////////////////
    // 点滅判定
    ///////////////////////////////////////////////////////////////
    if (self._isInvisible) {
        self._invisibleTime -= dt;
        if (self._invisibleTime <= 0) {
            self._isInvisible = false;
            self._invisibleTime = 0;
            self._playerSprite.opacity = 255;
        }
    }

    ///////////////////////////////////////////////////////////////
    // アイテム効果判定
    ///////////////////////////////////////////////////////////////
    if (self._currentItemTime > 0) {
        self._currentItemTime -= dt;
        if (self._currentItemTime <= 0) {
            [self clearItemEffect];
        }
    }
    
    ///////////////////////////////////////////////////////////////
    // 死亡判定
    ///////////////////////////////////////////////////////////////
    MapController *mapController = [GameScene sharedInstance].mapController;

    if (!self._isInvisible) {
        
        // 弾丸判定
        if (self._isBulletHit) {
            self._isBulletHit = false;
            [self dead:false];
            return;
        }

        // 敵との当たり判定
        if (![self._state ignoreEnemy]) {
            float bufferX = [PointUtil getPoint:10];
            if ([mapController.landMap isEnemyHit:ccpAdd([self getCenterRightPosition], ccp(-bufferX, 0)) direction:LEFT]
                || [mapController.landMap isEnemyHit:[self getCenterBottomPosition] direction:TOP]
                || [mapController.landMap isEnemyHit:[self getCenterTopPosition] direction:BOTTOM]) {
                [self dead:false];
                return;
            }
            if (self._isReverse && [mapController.landMap isEnemyHit:ccpAdd([self getCenterLeftPosition], ccp(bufferX, 0)) direction:RIGHT]) {
                [self dead:false];
                return;
            }
        }
    }
    
    // 落下判定
    if (self.position.y < self._limitY) {
        [self dead:true];
        return;
    }
    
    ///////////////////////////////////////////////////////////////
    // 当たり判定用座標計算
    ///////////////////////////////////////////////////////////////
    if (!self._onRailed) {
        self._vy = [self._state calcGravity:self._playerSprite vy:self._vy touch:self._isTouching];
    }

    ///////////////////////////////////////////////////////////////
    // コイン/アイテム判定
    ///////////////////////////////////////////////////////////////
    BOOL isMagnet = self._currentItemId == ITEM_MAGNET;
    [mapController.landMap takeCoinsIfCollided:[self getRect] magnet:isMagnet];
    if ([mapController.landMap jumpIfCollided:[self getRect]]) {
        return;
    }
    Item *item = [mapController.landMap takeItemIfCollided:[self getRect]];
    if (item) {
        [self useItem:item];
    }
    Crystal *crystal = [mapController.landMap takeCrystalIfCollided:[self getRect]];
    if (crystal) {
        if (self._crystalId != [crystal getCrystalId]) {
            [self stop];
            [[GameScene sharedInstance].playerController changePlayer:[crystal getCrystalId]];
        }
    }
    [mapController.landMap takeOthersIfCollided:[self getRect]];
    
    ///////////////////////////////////////////////////////////////
    // 横軸の判定
    ///////////////////////////////////////////////////////////////
    BOOL currentReverse = self._isReverse;
    float dx = self._vx * dt;
    float x = [self _checkX:dx];
    
    ///////////////////////////////////////////////////////////////
    // 縦軸の判定
    ///////////////////////////////////////////////////////////////
    float y = [self _checkY:dt reverse:currentReverse];
    
    ///////////////////////////////////////////////////////////////
    // 位置更新
    ///////////////////////////////////////////////////////////////
    if (self._currentRail) {
        if (![self._currentRail isRopeMovable]) {
            self._onRailed = false;
            self._currentRail = nil;
            [self._playerSprite resumeSchedulerAndActions];
        } else {
            CGPoint diff = [self._currentRail moveRope:dx];
            if (self._onRailed) {
                y = self.position.y + diff.y;
            }
        }
    }
    self.position = ccp(x, y);
    
    ///////////////////////////////////////////////////////////////
    // スピードアップ判定
    ///////////////////////////////////////////////////////////////
    if ([mapController.landMap checkSpeedUp:self.position]) {
        [self speedUp];
    }

    ///////////////////////////////////////////////////////////////
    // 炎判定
    ///////////////////////////////////////////////////////////////
    if ([mapController.landMap checkFire1:dt]) {
        [mapController.landMap fire1];
    }
    if ([mapController.landMap checkFire2:dt]) {
        [mapController.landMap fire2];
    }
}

- (float)_checkX:(float)dx {
    float x = self.position.x;
    BOOL isXHit = false;
    MapController *mapController = [GameScene sharedInstance].mapController;
    CGPoint nextRightXPosition = ccpAdd([self getCenterRightPosition], ccp(dx, 0));

    // ブロックに衝突している場合はプレイヤーも一緒に移動
    if (!self._isReverse) {
        Block *blockX = [mapController getHitBlock:nextRightXPosition]; // 右端判定
        if (blockX) {
            if (blockX.isLeftReverse) {
                [self changeDirection:true];
            } else {
                x = [blockX getLeftPoint] - [self getWidth] / 2;
                isXHit = true;
            }
        }
    } else {
        CGPoint nextLeftXPosition = ccpAdd([self getCenterLeftPosition], ccp(-dx, 0));
        Block *blockX = [mapController getHitBlock:nextLeftXPosition]; // 左端判定
        if (blockX) {
            if (blockX.isRightReverse) {
                [self changeDirection:false];
            } else {
                x = [blockX getRightPoint] + [self getWidth] / 2;
                isXHit = true;
            }
        }
    }
    
    if (!isXHit) {
        if (self._isForwardAdjusting) { // 場所調整中
            if (self._properPosition.x <= self.position.x) {
                self._isForwardAdjusting = false;
                x = self._properPosition.x;
            } else {
                x = self.position.x + [PointUtil getPoint:2];
            }
        } else if (self._isBackAdjusting) { // 場所調整中
                if (self._properPosition.x >= self.position.x) {
                    self._isBackAdjusting = false;
                    x = self._properPosition.x;
                } else {
                    x = self.position.x - [PointUtil getPoint:2];
                }
        } else {
            // 規定値より後ろにいる場合
            if (self._properPosition.x - [PointUtil getPoint:50] > self.position.x) {
                self._isForwardAdjusting = true;
            
            // 規定値より前にいる場合
            } else if (self._properPosition.x + [PointUtil getPoint:50] < self.position.x) {
                self._isBackAdjusting = true;
            }
        }
    }
    
    // マップスクロール
    if (!isXHit) {
        [self scroll:dx];
    } else {
        if (!self._isReverse && self._properPosition.x - [PointUtil getPoint:180] < self.position.x) {
            [self scroll:dx];
        } else if (self._isReverse && self._properPosition.x + [PointUtil getPoint:150] > self.position.x) {
            [self scroll:dx];
        }
    }
    
    return x;
}

- (void)scroll:(float)dx {
    MapController *mapController = [GameScene sharedInstance].mapController;
    if (self._isReverse) dx *= -1;
    [mapController scroll:dx];    
}

- (float)_checkY:(ccTime)dt reverse:(BOOL)currentReverse {
    MapController *mapController = [GameScene sharedInstance].mapController;
    float dy = self._vy * dt;
    float y = self.position.y;

    CGPoint nextCenterBottomYPosition = ccpAdd([self getCenterBottomPosition], ccp(0, dy));
    CGPoint nextCenterTopYPosition = ccpAdd([self getCenterTopPosition], ccp(0, dy));

    // 敵チェック
    Enemy *enemy = [mapController.landMap attackEnemyIfCollided:nextCenterBottomYPosition direction:TOP isForce:[self._state isForce]];
    if (enemy) {
        if (![self._state ignoreEnemyJump]) {
            self._vy = self._jumpSpeed * 0.6;
            y += self._vy * dt;
        }
        [[GameScene sharedInstance].hudController addExp:[enemy getExp]];
        return y;
    }
    
    // 着地判定
    Block *blockY = [mapController getHitBlock:nextCenterBottomYPosition];
    float dw = (currentReverse) ? [self getWidth] / 2 : -[self getWidth] / 2;
    if (!blockY) blockY = [mapController getHitBlock:ccpAdd(nextCenterBottomYPosition, ccp(dw, 0))];
    if (blockY) {
        if (self._vy < 0) {
            self._onGround = true;
            y = [blockY getLandPoint] + [self getHeight] / 2;
            self._vy = 0;
            self._currentJumpNum = 0;
            [self._state gotDown:self._playerSprite];
            return y;
        }
    }
    self._onGround = false; // 着地していないので空中

    // レール判定
    if (!self._onRailed && !(self._currentRail.isSwitched && self._vy > 0)) {
        Rail *rail = [mapController.landMap getHitRail:[self getRect]];
        if (rail && [rail isRopeMovable]) {
            self._currentRail = rail;
            self._onRailed = true;
            self._vy = 0;
            [self._playerSprite pauseSchedulerAndActions];
        }
    }
    
    // 上ブロック衝突判定
    Block *topBlock = [mapController getHitBlock:nextCenterTopYPosition];
    if (!self._onTopBlock && topBlock) {
        y = [topBlock getBottomPoint] - [self getHeight] / 2;
        self._vy = 0;
        self._onTopBlock = true;
    } else {
        y += dy;
        self._onTopBlock = false;
    }
    
    return y;
}

- (void)changeDirection:(BOOL)isReverse {
    [self._playerSprite stopAllActions];
    [self._playerSprite runAction:[PlayerAnimation getWalkAction:self._monsterId isReverse:isReverse frameNum:3]];
    self._isReverse = isReverse;
}

- (void)dead:(BOOL)isForce {
    if (!isForce) {
        if (self._isInvisible) { // 点滅状態
            return;
        } else if (self._crystalId != 0) { // クリスタル有
            [[GameScene sharedInstance].playerController backToDefaultPlayer];
            return;
        }
    }
    
    self._isStaged = false;
    [self stop];
    CCParticleSystem *deadParticle = [PlayerAnimation getDeadParticle];
    deadParticle.position = self.position;
    [[GameScene sharedInstance].effectLayer addChild:deadParticle];
    [self removeFromParentAndCleanup:NO];
    [[GameScene sharedInstance] finishGame];
}

- (void)runChangeEffect:(id)func {
    NSString *fileName = [NSString stringWithFormat:@"change%d_", self._crystalId];
    [self._effectSprite runAction:[CommonAnimation getFrameAction:fileName frameNum:8 duration:0.1f count:1 func:func]];
}

- (CGRect)getRect {
    return CGRectMake(self.position.x - [self getWidth] / 2, self.position.y - [self getHeight] / 2, [self getWidth], [self getHeight]);
}

- (CGPoint)getCenterBottomPosition {
    return ccp(self.position.x, self.position.y - [self getHeight] / 2);
}
- (CGPoint)getCenterTopPosition {
    return ccp(self.position.x, self.position.y + [self getHeight] / 2);
}
- (CGPoint)getCenterRightPosition {
    return ccp(self.position.x + [self getWidth] / 2, self.position.y);
}
- (CGPoint)getCenterLeftPosition {
    return ccp(self.position.x - [self getWidth] / 2, self.position.y);
}
- (CGPoint)getTopLeftPosition {
    return ccp(self.position.x - [self getWidth] / 2, self.position.y + [self getHeight] / 2);
}
- (CGPoint)getTopRightPosition {
    return ccp(self.position.x + [self getWidth] / 2, self.position.y + [self getHeight] / 2);
}
- (CGPoint)getBottomLeftPosition {
    return ccp(self.position.x - [self getWidth] / 2, self.position.y - [self getHeight] / 2);
}
- (CGPoint)getBottomRightPosition {
    return ccp(self.position.x + [self getWidth] / 2, self.position.y - [self getHeight] / 2);
}

- (float)getWidth {
    return self._playerSprite.contentSize.width;
}
- (float)getHeight {
    return self._playerSprite.contentSize.height;
}
- (BOOL)isItemEffecting {
    return self._currentItemTime > 0;
}
- (void)clearItemEffect {
    self._currentItemTime = 0;
    self._currentItemId = 0;
    [self._itemEffectSprite stopAllActions];
    [self._itemEffectSprite removeFromParentAndCleanup:YES];
}

@end
