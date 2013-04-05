//
//  HelloWorldLayer.m
//  JumpJump
//
//  Created by Edainne Ladys S. Silva on 4/1/13.
//  Copyright Edainne Ladys S. Silva 2013. All rights reserved.
//


// Import the interfaces
#import "HelloWorldLayer.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"
#import <mach/mach_time.h>
#pragma mark - HelloWorldLayer

// HelloWorldLayer implementation
@implementation HelloWorldLayer
@synthesize scoreLabel;
// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
    platformsStartTag = 200;
	if(![super init]) return nil;
//    [super initWithColor:ccc4(255, 255, 255, 255)];
 
    [self createPlatforms];
    CCSprite *player = [CCSprite spriteWithFile:@"Icon.png"];

    [self addChild:player z:10 tag: playerTag];
        [self schedule:@selector(step:)];
        _accelerometerEnabled = YES;
        _touchEnabled = NO;
        [self startGame];
    
    playerPoints = 0;
    scoreLabel = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"%d", playerPoints] fontName:@"Marker Felt" fontSize:10.0];
    scoreLabel.position = ccp(self.contentSize.width/2, self.contentSize.height-20);
    [scoreLabel setColor:ccc3(255, 255, 255)];
    [self addChild:scoreLabel z:1000 tag:scoreTag];

    
    [[UIAccelerometer sharedAccelerometer] setUpdateInterval:(1.0 / 60.0)];
	return self;
}

- (void) dealloc
{
    [super dealloc];
    

}

-(void) initializePlatform
{
    CCSprite *platform = [CCSprite spriteWithFile:@"platform.png"];
    [self addChild:platform z: 3 tag:currentPlatformTag];
}

-(void) createPlatforms
{
	
    currentPlatformTag = platformsStartTag;
	while (currentPlatformTag < platformsStartTag + kNumPlatforms)
    {
		[self initializePlatform];
		currentPlatformTag++;
	}
	[self resetPlatforms];

}

-(void) resetPlatforms
{
    currentPlatformY = -1;
	currentPlatformTag = platformsStartTag;
	currentMaxPlatformStep = 60.0f;
	platformCount = 0;
    
	while(currentPlatformTag < platformsStartTag + kNumPlatforms)
    {
		[self resetPlatform];
		currentPlatformTag++;

	}
    NSLog(@"CPT %i", platformsStartTag);
}

-(void) resetPlatform
{
    if (currentPlatformY < 0)
    {
        currentPlatformY = 30.0f;
    }
    else
    {
        currentPlatformY += random() % (int)(currentMaxPlatformStep - kMinPlatformStep) + kMinPlatformStep;
        
		if(currentMaxPlatformStep < kMaxPlatformStep)
        {
			currentMaxPlatformStep += 0.5f;
        }
    }
    
    CCSprite *platform = [CCSprite spriteWithFile:@"platform.png"];
    platform = (CCSprite*)[self getChildByTag:currentPlatformTag];

	float x;
	CGSize size = platform.contentSize;
    
	if(currentPlatformY == 30.0f)
    {
		x = 160.0f;
	}
    else
    {
		x = random() % (320-(int)size.width) + size.width/2;
	}
	
	platform.position = ccp(x,currentPlatformY);
	platformCount++;
	

	}

- (void)startGame
{
    playerPoints = 0;
	[self resetPlatforms];
	[self resetPlayer];
    
    	
	[[UIApplication sharedApplication] setIdleTimerDisabled:YES];
}

-(void) resetPlayer
{
    CCSprite  *player = [CCSprite spriteWithFile:@"Icon.png"];
    player = (CCSprite *) [self getChildByTag:playerTag];
    playerPosition.x = 160;
    playerPosition.y = 160;
    player.position = playerPosition;
    
    playerVelocity.x = 0;
    playerVelocity.y = 0;
    
    playerAcc.x = 0;
    playerAcc.y = -550.0f;

}

-(void) step: (ccTime) dt
{
    playerPoints+=1;
    [self updateScore:playerPoints];
    
    CCSprite  *player = [CCSprite spriteWithFile:@"Icon.png"];
    player = (CCSprite *) [self getChildByTag:playerTag];
    
    playerPosition.x += playerVelocity.x * dt;
    
    CGSize playerSize = player.contentSize;
    float maximumX = 320 - playerSize.width/2;
    float minimumX = 0 + playerSize.width/2;
    
    if (playerPosition.x - 57 > maximumX) {
        playerPosition.x = minimumX;
    }
    if (playerPosition.x + 57 < minimumX) {
        playerPosition.x = maximumX;
    }
    
    playerVelocity.y += playerAcc.y * dt;
    playerPosition.y += playerVelocity.y * dt;
    
    int t;
    if (playerVelocity.y < 0) {
        t = platformsStartTag;
        for (t ; t < platformsStartTag + kNumPlatforms; t++) {
            CCSprite *platform = (CCSprite*)[self getChildByTag:t];
            
            CGSize platformSize = platform.contentSize;
            CGPoint platformPosition = platform.position;
            
            maximumX = platformPosition.x - platformSize.width/2 - 10;
            minimumX = platformPosition.x + platformSize.width/2 + 10;
            
            float minimumY = platformPosition.y + (platformSize.height + playerSize.height/2 - kPlatformTopPadding);
            
            if (playerPosition.x > maximumX &&
                playerPosition.x < minimumX &&
                playerPosition.y > platformPosition.y &&
                playerPosition.y < minimumY) {
                [self playerJump];
            }
        }
    }
    else if (playerPosition.y > 240){

        
        float delta = playerPosition.y - 240;
        playerPosition.y = 240;
        
        currentPlatformY -= delta;
    
    t = t = platformsStartTag;
        
    for(t; t < platformsStartTag + kNumPlatforms; t++) {
        CCSprite *platform = (CCSprite *)[self getChildByTag:t];
        CGPoint pos = platform.position;
        pos = ccp(pos.x, pos.y - delta);
        if (pos.y <-platform.contentSize.height/2) {
            currentPlatformTag = t;
            [self resetPlatform];
        } else {
            platform.position = pos;
            }
        }

    }
    player.position = playerPosition;
    
    [self updatePlayerPosition:playerPosition];

}

-(void) updatePlayerPosition : (CGPoint) pPosition
{
    CCSprite  *player = [CCSprite spriteWithFile:@"Icon.png"];
    playerPosition = pPosition;
    if (playerPosition.y + player.boundingBox.size.height/2 + 10 < 0) {
    NSLog(@"Death");
    [scoreLabel setString:[NSString stringWithFormat:@"%d", playerPoints]];
    [self unschedule:@selector(step:)];
    }
    
}

-(int) updateScore : (NSInteger) newScore
{

    playerPoints = newScore;
    [scoreLabel setString:[NSString stringWithFormat:@"%d", playerPoints]];
    return playerPoints;
}

- (void) playerJump
{
    NSLog(@"jump");
	playerVelocity.y = 350.0f + fabsf(playerVelocity.x);
    playerPoints+=1;
    NSLog(@"PLAYER POINTS: %d", playerPoints);
    [self updateScore:playerPoints];


}
- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{
	float accel_filter = 0.1f;
	playerVelocity.x = playerVelocity.x * accel_filter + acceleration.x * (1.0f - accel_filter) * 500.0f;
}
@end
