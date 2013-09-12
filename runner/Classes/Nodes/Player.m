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
#import "Enemy.h"
#import "PointUtil.h"
#import "GameUtil.h"
#import "PlayerMaster.h"

@interface Player ()
@property (nonatomic, readwrite)int _monsterId;
@property (nonatomic, readwrite)BOOL _isStaged, _isBulletHit;
@property (nonatomic, readwrite)int _jumpNum, _currentJumpNum, _jumpSpeed;
@property (nonatomic, retain)CCSprite *_playerSprite;
@property (nonatomic, readwrite)BOOL _onGround, _isAdjusting, _isReverse, _onTopBlock, _onRailed;
@property (nonatomic, readwrite)float _vx, _vy;
@property (nonatomic, readwrite)CGPoint _properPosition;
@property (nonatomic, readwrite)float _limitLeftX, _limitRightX, _limitY;
@property (nonatomic, retain)Rail *_currentRail;
@end

@implementation Player
const int INIT_SCROLL_SPEED = 600;
const int BLOCK_TOP_REFLECTION = -10;


+ (Player*)createPlayer:(int)monsterId {
    return [[[self alloc] initWithMonsterId:monsterId] autorelease];
}

- (id)initWithMonsterId:(int)monsterId {
    self = [super init];
	if (self) {
        
        // 初期値設定
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        self._monsterId = monsterId;
        self._isStaged = false;
        self._isBulletHit = false;
        self._jumpNum = [[PlayerMaster getInstance] getJumpNum:self._monsterId];
        self._onGround = true;
        self._vx = [PointUtil getPoint:INIT_SCROLL_SPEED];
        self._isAdjusting = false;
        self._isReverse = false;
        self._limitY = winSize.height / 2 - [PointUtil getPoint:BASE_HEIGHT / 2];
        self._jumpSpeed = [PointUtil getPoint:[[PlayerMaster getInstance] getJumpSpeed:self._monsterId]];
        self._onTopBlock = false;
        self._onRailed = false;
        
        // アニメーションの最初のコマを読み込む
        NSString* fileName = [NSString stringWithFormat:@"player%d_right1.png", self._monsterId];
        self._playerSprite = [CCSprite spriteWithSpriteFrameName:fileName];
        [self addChild:self._playerSprite];
        self._limitLeftX = winSize.width / 2 - [PointUtil getPoint:BASE_WIDTH / 2] - [self getWidth] / 2;
        self._limitRightX = winSize.width / 2 + [PointUtil getPoint:BASE_WIDTH / 2] + [self getWidth] / 2;
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

- (void)getOff:(CGPoint)position func:(id)func {
    [self removeFromParentAndCleanup:NO];
    self.position = ccpAdd(position, ccp(0, self._playerSprite.contentSize.height / 2));
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
    [self._playerSprite runAction:[PlayerAnimation getWalkAction:self._monsterId isReverse:self._isReverse frameNum:self.frameNum]];
    [self scheduleUpdate];
}

- (void)stop {
    [self unscheduleUpdate];
    [self._playerSprite stopAllActions];
}

- (void)jump {
    if (self._onRailed) {
        self._vy = self._jumpSpeed * 0.8;
        self._onRailed = false;
        [self._playerSprite resumeSchedulerAndActions];
        
    } else if (self._currentJumpNum == 0 && self._onGround) { // 初回ジャンプ
        self._vy = self._jumpSpeed;
        
    } else if (self._currentJumpNum != 0 && self._currentJumpNum < self._jumpNum) { // 2回目以降ジャンプ
        [self._playerSprite runAction:[CCRotateBy actionWithDuration:0.2f angle:360]];
        self._vy = self._jumpSpeed;
    }
    self._currentJumpNum++;
}

- (void)speedUp {
    [[GameScene sharedInstance].hudController showSpeedUpEffect];
    self._vx *= 1.1;
}

- (void)trampoline {
    self._vy = self._jumpSpeed * 1.5;
}

- (BOOL)deadIfBulletCollided:(CGPoint)position {
    if (CGRectContainsPoint([self getRect], position)) {
        self._isBulletHit = true;
        return true;
    }
    return false;
}

- (void)update:(ccTime)dt {

    // ステージ上にいなければ何も処理しない
    if (!self._isStaged) return;
    
    ///////////////////////////////////////////////////////////////
    // 死亡判定
    ///////////////////////////////////////////////////////////////
    MapController *mapController = [GameScene sharedInstance].mapController;
    
    // 弾丸判定
    if (self._isBulletHit) {
        [self dead];
        return;
    }
    
    // 圧死判定
    if ([self getCenterRightPosition].x < self._limitLeftX || [self getCenterLeftPosition].x > self._limitRightX) {
        [self dead];
        return;
    }
    
    // 落下判定
    if (self.position.y < self._limitY) {
        [self dead];
        return;        
    }
    
    // 敵との当たり判定
    if ([mapController.landMap isEnemyHit:[self getCenterRightPosition] direction:LEFT]
        || [mapController.landMap isEnemyHit:[self getCenterBottomPosition] direction:TOP]
        || [mapController.landMap isEnemyHit:[self getCenterTopPosition] direction:BOTTOM]) {
        [self dead];
        return;
    }
    if (self._isReverse && [mapController.landMap isEnemyHit:[self getCenterLeftPosition] direction:RIGHT]) {
        [self dead];
        return;        
    }
    
    ///////////////////////////////////////////////////////////////
    // 当たり判定用座標計算
    ///////////////////////////////////////////////////////////////
    if (!self._onRailed) {
        self._vy -= [PointUtil getPoint:GRAVITY];
    }

    ///////////////////////////////////////////////////////////////
    // コイン/アイテム判定
    ///////////////////////////////////////////////////////////////
    [mapController.landMap takeItemsIfCollided:[self getRect]];
    if ([mapController.landMap jumpIfCollided:[self getRect]]) {
        return;
    }

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
    if ([mapController.landMap checkFire:dt]) {
        [mapController.landMap fire];
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
                x = [blockX getLeftPoint] - self._playerSprite.contentSize.width / 2;
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
                x = [blockX getRightPoint] + self._playerSprite.contentSize.width / 2;
                isXHit = true;
            }
        }
    }
    
    if (!isXHit) {
        if (self._isAdjusting) { // 場所調整中
            if (self._properPosition.x <= self.position.x) {
                self._isAdjusting = false;
                x = self._properPosition.x;
            } else {
                x = self.position.x + [PointUtil getPoint:1];
            }
        } else { // 規定値より後ろにいる場合
            if (self._properPosition.x - [PointUtil getPoint:50] > self.position.x) {
                self._isAdjusting = true;
            }
        }
    }
    
    // マップスクロール
    if (self._isReverse) dx *= -1;
    [mapController scroll:dx];
    return x;
}

- (float)_checkY:(ccTime)dt reverse:(BOOL)currentReverse {
    MapController *mapController = [GameScene sharedInstance].mapController;
    float dy = self._vy * dt;
    float y = self.position.y;

    CGPoint nextCenterBottomYPosition = ccpAdd([self getCenterBottomPosition], ccp(0, dy));
    CGPoint nextCenterTopYPosition = ccpAdd([self getCenterTopPosition], ccp(0, dy));

    // 敵チェック
    Enemy *enemy1 = [mapController.landMap attackEnemyIfCollided:nextCenterBottomYPosition direction:TOP];
    if (enemy1) {
        self._vy = self._jumpSpeed * 0.6;
        y += self._vy * dt;
        [[GameScene sharedInstance].hudController addExp:[enemy1 getExp]];
        return y;
    }
    Enemy *enemy2 = [mapController.landMap attackEnemyIfCollided:nextCenterTopYPosition direction:BOTTOM];
    if (enemy2) {
        [[GameScene sharedInstance].hudController addExp:[enemy2 getExp]];
        self._vy = 0;
        return y;
    }
        
    // 着地判定
    Block *blockY = [mapController getHitBlock:nextCenterBottomYPosition];
    float dw = (currentReverse) ? [self getWidth] / 2 : -[self getWidth] / 2;
    if (!blockY) blockY = [mapController getHitBlock:ccpAdd(nextCenterBottomYPosition, ccp(dw, 0))];
    if (blockY) {
        if (self._vy < 0) {
            self._onGround = true;
            y = [blockY getLandPoint] + self._playerSprite.contentSize.height / 2;
            self._vy = 0;
            self._currentJumpNum = 0;
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
        y = [topBlock getBottomPoint] - self._playerSprite.contentSize.height / 2;
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
    [self._playerSprite runAction:[PlayerAnimation getWalkAction:self._monsterId isReverse:isReverse frameNum:self.frameNum]];
    self._isReverse = isReverse;
}

- (void)dead {
    self._isStaged = false;
    [self stop];
    CCParticleSystem *deadParticle = [PlayerAnimation getDeadParticle];
    deadParticle.position = self.position;
    [[GameScene sharedInstance].effectLayer addChild:deadParticle];
    [self removeFromParentAndCleanup:NO];
    [[GameScene sharedInstance] finishGame];
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

@end
