//
//  SceneManager.m
//  JumpJump
//
//  Created by Edainne Ladys S. Silva on 4/5/13.
//  Copyright (c) 2013 Edainne Ladys S. Silva. All rights reserved.
//

#import "SceneManager.h"

@implementation SceneManager
+(void) goToMainMenuScene;
{
    CCLayer *layer = [MainMenuScene node];
    [SceneManager go:layer];
}
+(void) goToHelloWorldScene
{
    CCLayer *layer = [HelloWorldLayer node];
    [SceneManager go:layer];
}
+(void) gotoPauseLayer
{
    CCLayer *layer = [PauseLayer node];
    [SceneManager go:layer];

}
+(void) goToGameOverScene
{
    CCLayer *layer = [GameOverScene node];
    [SceneManager go:layer];
}

+(void) go : (CCLayer*) layer
{
    CCDirector *director = [CCDirector sharedDirector];
	CCScene *newScene = [SceneManager wrap:layer];
	if ([director runningScene]) {
		[director replaceScene:newScene];
	}else {
		[director runWithScene:newScene];
	}
}
+(CCScene *) wrap : (CCLayer *) layer
{
    CCScene *newScene = [CCScene node];
	[newScene addChild: layer];
	return newScene;
}
@end
