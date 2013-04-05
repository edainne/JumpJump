//
//  HelloWorldLayer.h
//  JumpJump
//
//  Created by Edainne Ladys S. Silva on 4/1/13.
//  Copyright Edainne Ladys S. Silva 2013. All rights reserved.
//


#import <GameKit/GameKit.h>

// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

#define kMinPlatformStep	50
#define kMaxPlatformStep	100
#define kNumPlatforms		20
#define kPlatformTopPadding 10

@interface HelloWorldLayer : CCLayerColor <UIAccelerometerDelegate>
{
    CGPoint playerPosition;
	CGPoint playerVelocity;
	CGPoint playerAcc;
    
    CCLabelTTF* scoreLabel;
    
	float currentPlatformY;
	float currentMaxPlatformStep;
    
    int currentPlatformTag;
	int platformCount;
    int playerTag;
	int platformsStartTag;
    int scoreTag;
    
    int playerPoints;
    int playerPointsFinal;

    UIAccelerometer *accelerometer;
}
@property (retain, nonatomic) CCLabelTTF* scoreLabel;

- (void)createPlatforms;
- (void)initializePlatform;
- (void)startGame;

- (void)resetPlatforms;
- (void)resetPlatform;
- (void)resetPlayer;
- (void)step:(ccTime)dt;
- (void)playerJump;
- (int) updateScore : (NSInteger) newScore;
+(CCScene *) scene;

@end
