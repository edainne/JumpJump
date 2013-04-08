//
//  SceneManager.h
//  JumpJump
//
//  Created by Edainne Ladys S. Silva on 4/5/13.
//  Copyright (c) 2013 Edainne Ladys S. Silva. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "MainMenuScene.h"
#import "HelloWorldLayer.h"
#import "GameOverScene.h"
#import "PauseLayer.h"

@interface SceneManager : NSObject
{
    
}

+(void) goToMainMenuScene;
+(void) goToHelloWorldScene;
+(void) goToGameOverScene;
+(void) gotoPauseLayer;

+(void) go : (CCLayer*) layer;
+(CCScene *) wrap : (CCLayer *) layer;
@end
