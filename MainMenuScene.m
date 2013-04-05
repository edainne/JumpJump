//
//  MainMenuScene.m
//  JumpJump
//
//  Created by Edainne Ladys S. Silva on 4/5/13.
//  Copyright (c) 2013 Edainne Ladys S. Silva. All rights reserved.
//

#import "MainMenuScene.h"
#import "AppDelegate.h"

@implementation MainMenuScene
+ (CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainMenuScene *layer1 = [MainMenuScene node];
	
	// add layer as a child to scene
	[scene addChild: layer1];
	
	// return the scene
	return scene;
}
-(id) init
{
    if (self = [super init]) {
        CCLayer *menuLayer = [[CCLayer alloc]init];
        [self addChild:menuLayer];
        
        [CCMenuItemFont setFontName:@"Marker Felt"];
        
        CCMenuItemFont *startGame = [CCMenuItemFont itemWithString:@"Play" target:self selector:@selector(startGame)];
        startGame.fontSize = 10;
        startGame.position = ccp(100, 30);
        [startGame setColor:ccc3(255, 255, 255)];
        
        CCMenu *mainMenu = [CCMenu menuWithItems:startGame, nil];
        [menuLayer addChild:mainMenu];

    }
    
    return self;
}
-(void) startGame
{
    [SceneManager goToHelloWorldScene];
}
@end
