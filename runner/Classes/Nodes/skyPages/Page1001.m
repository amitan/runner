//
//  Page1001.m
//  runner
//
//  Created by Ayumi Otomo on 2013/08/30.
//  Copyright 2013年 Ayumi Otomo. All rights reserved.
//

#import "Page1001.h"
#import "Coin.h"
#import "Enemy.h"

@implementation Page1001


- (id)init {
    self = [super init];
	if (self) {
        
        // コインを追加
        self._coins = @[
                        [Coin createCoin:C_STANDARD x:50 y:-50],
                        [Coin createCoin:C_STANDARD x:100 y:-50],
                        [Coin createCoin:C_STANDARD x:150 y:-50],
                        [Coin createCoin:C_STANDARD x:200 y:-50],
                        [Coin createCoin:C_STANDARD x:250 y:-50],
                        [Coin createCoin:C_STANDARD x:300 y:-50],
                        [Coin createCoin:C_STANDARD x:350 y:-50],
                        [Coin createCoin:C_STANDARD x:400 y:-50],
                        [Coin createCoin:C_STANDARD x:450 y:-50],
                        [Coin createCoin:C_STANDARD x:500 y:-50],
                        [Coin createCoin:C_STANDARD x:550 y:-50],
                        [Coin createCoin:C_STANDARD x:600 y:-50],
                        [Coin createCoin:C_STANDARD x:650 y:-50],
                        [Coin createCoin:C_STANDARD x:700 y:-50],
                        [Coin createCoin:C_STANDARD x:750 y:-50],
                        [Coin createCoin:C_STANDARD x:800 y:-50],
                        [Coin createCoin:C_STANDARD x:850 y:-50],
                        [Coin createCoin:C_STANDARD x:900 y:-50],
                        [Coin createCoin:C_STANDARD x:950 y:-50],
                        [Coin createCoin:C_STANDARD x:50 y:-100],
                        [Coin createCoin:C_STANDARD x:100 y:-100],
                        [Coin createCoin:C_STANDARD x:150 y:-100],
                        [Coin createCoin:C_STANDARD x:200 y:-100],
                        [Coin createCoin:C_STANDARD x:250 y:-100],
                        [Coin createCoin:C_STANDARD x:300 y:-100],
                        [Coin createCoin:C_STANDARD x:350 y:-100],
                        [Coin createCoin:C_STANDARD x:400 y:-100],
                        [Coin createCoin:C_STANDARD x:450 y:-100],
                        [Coin createCoin:C_STANDARD x:500 y:-100],
                        [Coin createCoin:C_STANDARD x:550 y:-100],
                        [Coin createCoin:C_STANDARD x:600 y:-100],
                        [Coin createCoin:C_STANDARD x:650 y:-100],
                        [Coin createCoin:C_STANDARD x:700 y:-100],
                        [Coin createCoin:C_STANDARD x:750 y:-100],
                        [Coin createCoin:C_STANDARD x:800 y:-100],
                        [Coin createCoin:C_STANDARD x:850 y:-100],
                        [Coin createCoin:C_STANDARD x:900 y:-100],
                        [Coin createCoin:C_STANDARD x:950 y:-100],
                        [Coin createCoin:C_STANDARD x:50 y:-150],
                        [Coin createCoin:C_STANDARD x:100 y:-150],
                        [Coin createCoin:C_STANDARD x:150 y:-150],
                        [Coin createCoin:C_STANDARD x:200 y:-150],
                        [Coin createCoin:C_STANDARD x:250 y:-150],
                        [Coin createCoin:C_STANDARD x:300 y:-150],
                        [Coin createCoin:C_STANDARD x:350 y:-150],
                        [Coin createCoin:C_STANDARD x:400 y:-150],
                        [Coin createCoin:C_STANDARD x:450 y:-150],
                        [Coin createCoin:C_STANDARD x:500 y:-150],
                        [Coin createCoin:C_STANDARD x:550 y:-150],
                        [Coin createCoin:C_STANDARD x:600 y:-150],
                        [Coin createCoin:C_STANDARD x:650 y:-150],
                        [Coin createCoin:C_STANDARD x:700 y:-150],
                        [Coin createCoin:C_STANDARD x:750 y:-150],
                        [Coin createCoin:C_STANDARD x:800 y:-150],
                        [Coin createCoin:C_STANDARD x:850 y:-150],
                        [Coin createCoin:C_STANDARD x:900 y:-150],
                        [Coin createCoin:C_STANDARD x:950 y:-150],
                        [Coin createCoin:C_STANDARD x:50 y:-200],
                        [Coin createCoin:C_STANDARD x:100 y:-200],
                        [Coin createCoin:C_STANDARD x:150 y:-200],
                        [Coin createCoin:C_STANDARD x:200 y:-200],
                        [Coin createCoin:C_STANDARD x:250 y:-200],
                        [Coin createCoin:C_STANDARD x:300 y:-200],
                        [Coin createCoin:C_STANDARD x:350 y:-200],
                        [Coin createCoin:C_STANDARD x:400 y:-200],
                        [Coin createCoin:C_STANDARD x:450 y:-200],
                        [Coin createCoin:C_STANDARD x:500 y:-200],
                        [Coin createCoin:C_STANDARD x:550 y:-200],
                        [Coin createCoin:C_STANDARD x:600 y:-200],
                        [Coin createCoin:C_STANDARD x:650 y:-200],
                        [Coin createCoin:C_STANDARD x:700 y:-200],
                        [Coin createCoin:C_STANDARD x:750 y:-200],
                        [Coin createCoin:C_STANDARD x:800 y:-200],
                        [Coin createCoin:C_STANDARD x:850 y:-200],
                        [Coin createCoin:C_STANDARD x:900 y:-200],
                        [Coin createCoin:C_STANDARD x:950 y:-200],
                        [Coin createCoin:C_STANDARD x:50 y:-250],
                        [Coin createCoin:C_STANDARD x:100 y:-250],
                        [Coin createCoin:C_STANDARD x:150 y:-250],
                        [Coin createCoin:C_STANDARD x:200 y:-250],
                        [Coin createCoin:C_STANDARD x:250 y:-250],
                        [Coin createCoin:C_STANDARD x:300 y:-250],
                        [Coin createCoin:C_STANDARD x:350 y:-250],
                        [Coin createCoin:C_STANDARD x:400 y:-250],
                        [Coin createCoin:C_STANDARD x:450 y:-250],
                        [Coin createCoin:C_STANDARD x:500 y:-250],
                        [Coin createCoin:C_STANDARD x:550 y:-250],
                        [Coin createCoin:C_STANDARD x:600 y:-250],
                        [Coin createCoin:C_STANDARD x:650 y:-250],
                        [Coin createCoin:C_STANDARD x:700 y:-250],
                        [Coin createCoin:C_STANDARD x:750 y:-250],
                        [Coin createCoin:C_STANDARD x:800 y:-250],
                        [Coin createCoin:C_STANDARD x:850 y:-250],
                        [Coin createCoin:C_STANDARD x:900 y:-250],
                        [Coin createCoin:C_STANDARD x:950 y:-250],
                        [Coin createCoin:C_STANDARD x:50 y:-300],
                        [Coin createCoin:C_STANDARD x:100 y:-300],
                        [Coin createCoin:C_STANDARD x:150 y:-300],
                        [Coin createCoin:C_STANDARD x:200 y:-300],
                        [Coin createCoin:C_STANDARD x:250 y:-300],
                        [Coin createCoin:C_STANDARD x:300 y:-300],
                        [Coin createCoin:C_STANDARD x:350 y:-300],
                        [Coin createCoin:C_STANDARD x:400 y:-300],
                        [Coin createCoin:C_STANDARD x:450 y:-300],
                        [Coin createCoin:C_STANDARD x:500 y:-300],
                        [Coin createCoin:C_STANDARD x:550 y:-300],
                        [Coin createCoin:C_STANDARD x:600 y:-300],
                        [Coin createCoin:C_STANDARD x:650 y:-300],
                        [Coin createCoin:C_STANDARD x:700 y:-300],
                        [Coin createCoin:C_STANDARD x:750 y:-300],
                        [Coin createCoin:C_STANDARD x:800 y:-300],
                        [Coin createCoin:C_STANDARD x:850 y:-300],
                        [Coin createCoin:C_STANDARD x:900 y:-300],
                        [Coin createCoin:C_STANDARD x:950 y:-300],
                        [Coin createCoin:C_STANDARD x:50 y:-350],
                        [Coin createCoin:C_STANDARD x:100 y:-350],
                        [Coin createCoin:C_STANDARD x:150 y:-350],
                        [Coin createCoin:C_STANDARD x:200 y:-350],
                        [Coin createCoin:C_STANDARD x:250 y:-350],
                        [Coin createCoin:C_STANDARD x:300 y:-350],
                        [Coin createCoin:C_STANDARD x:350 y:-350],
                        [Coin createCoin:C_STANDARD x:400 y:-350],
                        [Coin createCoin:C_STANDARD x:450 y:-350],
                        [Coin createCoin:C_STANDARD x:500 y:-350],
                        [Coin createCoin:C_STANDARD x:550 y:-350],
                        [Coin createCoin:C_STANDARD x:600 y:-350],
                        [Coin createCoin:C_STANDARD x:650 y:-350],
                        [Coin createCoin:C_STANDARD x:700 y:-350],
                        [Coin createCoin:C_STANDARD x:750 y:-350],
                        [Coin createCoin:C_STANDARD x:800 y:-350],
                        [Coin createCoin:C_STANDARD x:850 y:-350],
                        [Coin createCoin:C_STANDARD x:900 y:-350],
                        [Coin createCoin:C_STANDARD x:950 y:-350],
                        [Coin createCoin:C_STANDARD x:50 y:-400],
                        [Coin createCoin:C_STANDARD x:100 y:-400],
                        [Coin createCoin:C_STANDARD x:150 y:-400],
                        [Coin createCoin:C_STANDARD x:200 y:-400],
                        [Coin createCoin:C_STANDARD x:250 y:-400],
                        [Coin createCoin:C_STANDARD x:300 y:-400],
                        [Coin createCoin:C_STANDARD x:350 y:-400],
                        [Coin createCoin:C_STANDARD x:400 y:-400],
                        [Coin createCoin:C_STANDARD x:450 y:-400],
                        [Coin createCoin:C_STANDARD x:500 y:-400],
                        [Coin createCoin:C_STANDARD x:550 y:-400],
                        [Coin createCoin:C_STANDARD x:600 y:-400],
                        [Coin createCoin:C_STANDARD x:650 y:-400],
                        [Coin createCoin:C_STANDARD x:700 y:-400],
                        [Coin createCoin:C_STANDARD x:750 y:-400],
                        [Coin createCoin:C_STANDARD x:800 y:-400],
                        [Coin createCoin:C_STANDARD x:850 y:-400],
                        [Coin createCoin:C_STANDARD x:900 y:-400],
                        [Coin createCoin:C_STANDARD x:950 y:-400],
                        [Coin createCoin:C_STANDARD x:50 y:-450],
                        [Coin createCoin:C_STANDARD x:100 y:-450],
                        [Coin createCoin:C_STANDARD x:150 y:-450],
                        [Coin createCoin:C_STANDARD x:200 y:-450],
                        [Coin createCoin:C_STANDARD x:250 y:-450],
                        [Coin createCoin:C_STANDARD x:300 y:-450],
                        [Coin createCoin:C_STANDARD x:350 y:-450],
                        [Coin createCoin:C_STANDARD x:400 y:-450],
                        [Coin createCoin:C_STANDARD x:450 y:-450],
                        [Coin createCoin:C_STANDARD x:500 y:-450],
                        [Coin createCoin:C_STANDARD x:550 y:-450],
                        [Coin createCoin:C_STANDARD x:600 y:-450],
                        [Coin createCoin:C_STANDARD x:650 y:-450],
                        [Coin createCoin:C_STANDARD x:700 y:-450],
                        [Coin createCoin:C_STANDARD x:750 y:-450],
                        [Coin createCoin:C_STANDARD x:800 y:-450],
                        [Coin createCoin:C_STANDARD x:850 y:-450],
                        [Coin createCoin:C_STANDARD x:900 y:-450],
                        [Coin createCoin:C_STANDARD x:950 y:-450],
                        [Coin createCoin:C_STANDARD x:50 y:-500],
                        [Coin createCoin:C_STANDARD x:100 y:-500],
                        [Coin createCoin:C_STANDARD x:150 y:-500],
                        [Coin createCoin:C_STANDARD x:200 y:-500],
                        [Coin createCoin:C_STANDARD x:250 y:-500],
                        [Coin createCoin:C_STANDARD x:300 y:-500],
                        [Coin createCoin:C_STANDARD x:350 y:-500],
                        [Coin createCoin:C_STANDARD x:400 y:-500],
                        [Coin createCoin:C_STANDARD x:450 y:-500],
                        [Coin createCoin:C_STANDARD x:500 y:-500],
                        [Coin createCoin:C_STANDARD x:550 y:-500],
                        [Coin createCoin:C_STANDARD x:600 y:-500],
                        [Coin createCoin:C_STANDARD x:650 y:-500],
                        [Coin createCoin:C_STANDARD x:700 y:-500],
                        [Coin createCoin:C_STANDARD x:750 y:-500],
                        [Coin createCoin:C_STANDARD x:800 y:-500],
                        [Coin createCoin:C_STANDARD x:850 y:-500],
                        [Coin createCoin:C_STANDARD x:900 y:-500],
                        [Coin createCoin:C_STANDARD x:950 y:-500],
                        [Coin createCoin:C_STANDARD x:50 y:-550],
                        [Coin createCoin:C_STANDARD x:100 y:-550],
                        [Coin createCoin:C_STANDARD x:150 y:-550],
                        [Coin createCoin:C_STANDARD x:200 y:-550],
                        [Coin createCoin:C_STANDARD x:250 y:-550],
                        [Coin createCoin:C_STANDARD x:300 y:-550],
                        [Coin createCoin:C_STANDARD x:350 y:-550],
                        [Coin createCoin:C_STANDARD x:400 y:-550],
                        [Coin createCoin:C_STANDARD x:450 y:-550],
                        [Coin createCoin:C_STANDARD x:500 y:-550],
                        [Coin createCoin:C_STANDARD x:550 y:-550],
                        [Coin createCoin:C_STANDARD x:600 y:-550],
                        [Coin createCoin:C_STANDARD x:650 y:-550],
                        [Coin createCoin:C_STANDARD x:700 y:-550],
                        [Coin createCoin:C_STANDARD x:750 y:-550],
                        [Coin createCoin:C_STANDARD x:800 y:-550],
                        [Coin createCoin:C_STANDARD x:850 y:-550],
                        [Coin createCoin:C_STANDARD x:900 y:-550],
                        [Coin createCoin:C_STANDARD x:950 y:-550],
                        [Coin createCoin:C_STANDARD x:50 y:-600],
                        [Coin createCoin:C_STANDARD x:100 y:-600],
                        [Coin createCoin:C_STANDARD x:150 y:-600],
                        [Coin createCoin:C_STANDARD x:200 y:-600],
                        [Coin createCoin:C_STANDARD x:250 y:-600],
                        [Coin createCoin:C_STANDARD x:300 y:-600],
                        [Coin createCoin:C_STANDARD x:350 y:-600],
                        [Coin createCoin:C_STANDARD x:400 y:-600],
                        [Coin createCoin:C_STANDARD x:450 y:-600],
                        [Coin createCoin:C_STANDARD x:500 y:-600],
                        [Coin createCoin:C_STANDARD x:550 y:-600],
                        [Coin createCoin:C_STANDARD x:600 y:-600],
                        [Coin createCoin:C_STANDARD x:650 y:-600],
                        [Coin createCoin:C_STANDARD x:700 y:-600],
                        [Coin createCoin:C_STANDARD x:750 y:-600],
                        [Coin createCoin:C_STANDARD x:800 y:-600],
                        [Coin createCoin:C_STANDARD x:850 y:-600],
                        [Coin createCoin:C_STANDARD x:900 y:-600],
                        [Coin createCoin:C_STANDARD x:950 y:-600],
                        ];
        for (Coin *coin in self._coins) {
            [coin stageOn:self];
        }        
    }
    return self;
}

- (void)clear {
    [super clear];
    for (Enemy *enemy in self._enemies) {
        [enemy stageOff];
    }
    self._enemies = NULL;    
}

- (void)reset {
    [self clear];
    
    int index = floor(CCRANDOM_0_1() * 10);
    if (index == 1) {
        self._enemies = @[[Enemy createEnemy:E_NEEDLE x:100 y:-660],
                          [Enemy createEnemy:E_NEEDLE x:100 y:-570]];
    } else if (index == 2) {
        self._enemies = @[[Enemy createEnemy:E_NEEDLE x:100 y:-200],
                          [Enemy createEnemy:E_NEEDLE x:100 y:-110]];
    } else if (index == 3) {
        self._enemies = @[[Enemy createEnemy:E_NEEDLE x:100 y:-480],
                          [Enemy createEnemy:E_NEEDLE x:100 y:-390]];
        
    } else if (index == 4) {
        self._enemies = @[[Enemy createEnemy:E_NEEDLE x:400 y:-660],
                          [Enemy createEnemy:E_NEEDLE x:400 y:-570]];
    } else if (index == 5) {
        self._enemies = @[[Enemy createEnemy:E_NEEDLE x:400 y:-200],
                          [Enemy createEnemy:E_NEEDLE x:400 y:-110]];
    } else if (index == 6) {
        self._enemies = @[[Enemy createEnemy:E_NEEDLE x:400 y:-480],
                          [Enemy createEnemy:E_NEEDLE x:400 y:-390]];
    } else if (index == 7) {
        self._enemies = @[[Enemy createEnemy:E_NEEDLE x:800 y:-660],
                          [Enemy createEnemy:E_NEEDLE x:800 y:-570]];
    } else if (index == 8) {
        self._enemies = @[[Enemy createEnemy:E_NEEDLE x:800 y:-200],
                          [Enemy createEnemy:E_NEEDLE x:800 y:-110]];
    } else if (index == 9) {
        self._enemies = @[[Enemy createEnemy:E_NEEDLE x:800 y:-480],
                          [Enemy createEnemy:E_NEEDLE x:800 y:-390]];
    }
    for (Enemy *enemy in self._enemies) {
        [enemy stageOn:self];
        enemy.zOrder = 10;
    }
    [super reset];
}

@end
