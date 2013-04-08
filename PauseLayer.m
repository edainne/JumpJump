//
//  PauseLayer.m
//  JumpJump
//
//  Created by Edainne Ladys S. Silva on 4/8/13.
//  Copyright (c) 2013 Edainne Ladys S. Silva. All rights reserved.
//

#import "PauseLayer.h"
#import "HelloWorldLayer.h"
#import "cocos2d.h"
#import "SceneManager.h"
@implementation PauseLayer

- (id) init
{
    	if(![super init]) return nil;
        
        CCSprite *paused = [CCSprite spriteWithFile:@"paused.jpg"];
        [paused setPosition:ccp(0,0)];
        [self addChild:paused];
        [self setTouchEnabled:YES];


    return self;
}
//- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
//{
//    [[CCDirector sharedDirector] resume];
//    [SceneManager goToHelloWorldScene];
//    [[CCDirector sharedDirector] startAnimation];
//    [self resumeSchedulerAndActions];
//}
@end
