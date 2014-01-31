//
//  Level1.m
//  Spaceship
//
//  Created by Karson Ota on 1/22/14.
//
//

#import "Level1.h"
#include <stdlib.h>
#include <math.h>
#import "Victory.h"
#import "GameOver.h"


//DEFINE OBJECTS
CCSprite * background;
CCSprite * ship;
CCSprite * fire;
CCSprite * coin;
CCSprite * fastForward;
CCSprite * asteroid;
CCRepeatForever * spinCoin;
NSMutableArray * coins;
NSMutableArray * asteroids;
NSMutableArray * fires;
CCSprite * coinHelper;
CCSprite * asteroidHelper;
CCSprite * fireHelper;
CCSprite * ast;
CCSprite * ast1;
CCSprite * ast2;
CCSprite * fire1;
CCSprite * fire2;
int * coinCount;

@interface Level1 (PrivateMethods)
@end

@implementation Level1
-(id) init
{
	if ((self = [super init]))
	{
        //Dimensions
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        //INITIALIZE THE ARRAY TO KEEP TRACK OF COINS AND ASTEROIDS
        coins = [[NSMutableArray alloc] init];
        asteroids = [[NSMutableArray alloc] init];
        fires = [[NSMutableArray alloc] init];
        
        //CREATE BACKDROP
        background = [CCSprite spriteWithFile:@"spaceBackground.png"];
        background.anchorPoint = CGPointZero;
        [self addChild:background];
        
        //CREATE SHIP
        ship = [CCSprite spriteWithFile:@"blackship.png"];
        ship.position = ccp(screenWidth/2, screenHeight/2);
        [self addChild:ship];
        
        //Coins
        int coinCount = 0;
        
        //ASTEROID
        fire1 = [CCParticleSystemQuad particleWithFile:@"burning_star_v1.plist"];
        [self addChild:fire1];
        ast1  = [CCSprite spriteWithFile: @"asteroid1.png"];
        ast1.position = ccp(screenWidth/2, screenHeight/4);
        [self addChild: ast1];
        [asteroids addObject:ast1];
        fire1.position = ast1.position;
        [fires addObject:fire1];
        
        fire2 = [CCParticleSystemQuad particleWithFile:@"burning_star_v1.plist"];
        [self addChild:fire2];
        ast2  = [CCSprite spriteWithFile: @"asteroid1.png"];
        ast2.position = ccp(screenWidth/2, 3 * screenHeight/4);
        [self addChild: ast2];
        [asteroids addObject:ast2];
        fire2.position = ast2.position;
        [fires addObject:fire2];
        
        //TEMPORARY MAKE POWERUP
        fastForward = [CCSprite spriteWithFile:@"fastForward.png"];
        fastForward.position = ccp(200, 200);
        [self addChild:fastForward];
        
        //KEEP TRACK OF SCORE
        newScoreLevel1 = 0;
        
        //ADD THE SCORE LABEL
        scoreLabel = [CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(200,30) alignment:UITextAlignmentRight fontName:@"Marker Felt" fontSize:30];
        scoreLabel.position = ccp(winSize.width - 110, winSize.height - 30); //Middle of the screen...
        [self addChild:scoreLabel z:1];
        
        //SCHEDULE UPDATE
        [self scheduleUpdate];
	}
	return self;
}

-(void) createCoins
{
    int timer = arc4random() % 1000;//makes coins appear randomly
    if (coinCount < 50)
    {
        if ([coins count] < 5)
        {
            if (timer < 20)
            {
                CGRect screenRect = [[UIScreen mainScreen] bounds];
                int screenWidth = screenRect.size.width;
                int screenHeight = screenRect.size.height;
                
                int xcoin = arc4random() % screenWidth;
                int ycoin = arc4random() % screenHeight;
                
                //MAKE THE COINS SPIN
                [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"spinningCoin.plist"];
                CCSpriteBatchNode * spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"spinningCoin.png"];
                [self addChild:spriteSheet];
                spinningFrames = [NSMutableArray array];
                for(int i = 1; i <= 9; ++i)
                {
                    [spinningFrames addObject:
                     [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName: [NSString stringWithFormat:@"goldCoin%d.png", i]]];
                }
                
                //CREATE SINGLE COIN
                coin = [CCSprite spriteWithSpriteFrameName: @"goldCoin1.png"];
                coin.anchorPoint = CGPointZero;
                coin.position = CGPointMake(xcoin, ycoin);
                CCAnimation * spinning = [CCAnimation animationWithFrames: spinningFrames delay:.1];
                spinCoin = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:spinning restoreOriginalFrame:NO]];
                [coin runAction: spinCoin];
                //new CCaction here
                [coin runAction:[CCSequence actions:[CCDelayTime actionWithDuration:10], [CCCallFuncN actionWithTarget:self selector:@selector(removeOldCoins:)], nil]];
                [self addChild:coin z:0];
                coinCount ++;
                [coins addObject:coin];//Array keeps track of coins
            }
        }
    }
    
}

-(void) removeOldCoins:(id)sender
{
    [self removeChild:sender cleanup:YES];
    [coins removeObjectIdenticalTo:sender];
}


-(void) detectCollisions
{
    for(int i = 0; i < [coins count]; i++)
    {
        if ([coins count] > 0)
        {
            NSInteger first = i;
            coinHelper = [coins objectAtIndex: first];
            if (coinHelper.position.x < (ship.position.x + 40) && coinHelper.position.x > ship.position.x - 40)
            {
                if (coinHelper.position.y < (ship.position.y + 60) && coinHelper.position.y > ship.position.y - 80)
                {
                    [self removeChild:coinHelper cleanup:YES];
                    [coins removeObjectAtIndex:first];
                    newScoreLevel1++;
                    [self updateScore:newScoreLevel1];
                }
            }
        }
    }
    for(int i = 0; i < [asteroids count]; i++)
    {
        if ([asteroids count] > 0)
        {
            NSInteger first = i;
            asteroidHelper = [asteroids objectAtIndex: first];
            fireHelper = [fires objectAtIndex:first];
            if (asteroidHelper.position.x < (ship.position.x + 40) && asteroidHelper.position.x > ship.position.x - 40)
            {
                if (asteroidHelper.position.y < (ship.position.y + 60) && asteroidHelper.position.y > ship.position.y - 80)
                {
                    [self removeChild:asteroidHelper cleanup:YES];
                    [self removeChild:fireHelper cleanup:YES];
                    [self removeChild:ship cleanup:YES];
                    [asteroids removeObjectAtIndex:first];
                    
                    if (newScoreLevel1 > 1)
                    {
                        [[CCDirector sharedDirector] replaceScene: [[Victory alloc] init]];
                    }
                    else
                    {
                        [[CCDirector sharedDirector] replaceScene: [[GameOver alloc] init]];
                    }
                }
            }
        }
    }
    
    
}

- (void)updateScore:(int)newScoreLevel1
{
    [scoreLabel setString: [NSString stringWithFormat:@"%d", newScoreLevel1]];
}

-(void) update:(ccTime)dt
{
    
    //MAKES SHIP MOVE TO TAP LOCATION
    KKInput * input = [KKInput sharedInput];
    CGPoint tap = [input locationOfAnyTouchInPhase:KKTouchPhaseBegan];
    ship.position = ccp( ship.position.x, ship.position.y);
    if (tap.x != 0 && tap.y != 0)
    {
        [ship stopAllActions]; // Nullifies previous actions
        int addedx = tap.x - ship.position.x;
        int addedy = tap.y - ship.position.y;
        int squaredx = pow(addedx, 2);
        int squaredy = pow(addedy, 2);
        int addedSquares = squaredx + squaredy;
        int distance = pow(addedSquares, 0.5);
        [ship runAction: [CCMoveTo actionWithDuration:distance/100 position:tap]];//makes ship move at a constant speed
        
    }
    
    if (coinCount == 50 && [coins count] == 0)
    {
        if (newScoreLevel1 > 25)
        {
            [[CCDirector sharedDirector] replaceScene: [[Victory alloc] init]];
        }
        else
        {
            [[CCDirector sharedDirector] replaceScene: [[GameOver alloc] init]];
        }
    }
    
    [self createCoins];
    [self detectCollisions];
}

@end
