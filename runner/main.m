//
//  main.m
//  runner
//
//  Created by Ayumi Otomo on 2013/07/08.
//  Copyright Ayumi Otomo 2013年. All rights reserved.
//

#import <UIKit/UIKit.h>

int main(int argc, char *argv[]) {
    
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    int retVal = UIApplicationMain(argc, argv, nil, @"AppController");
    [pool release];
    return retVal;
}
