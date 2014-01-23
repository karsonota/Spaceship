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
CCSprite * coinHelper;
CCSprite * asteroidHelper;
CCSprite * ast;
CCSprite * ast1;
CCSprite * ast2;
CCSprite * ast3;
CCSprite * ast4;
CCSprite * ast5;
CCSprite * fire1;
CCSprite * fire2;
CCSprite * fire3;
CCSprite * fire4;
CCSprite * fire5;
int * coinCount;

@interface Level1 (PrivateMethods)
@end

@implementation Level1
-(id) init
{
	if ((self = [super init]))
	{
        //Dimensions
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        //INITIALIZE THE ARRAY TO KEEP TRACK OF COINS AND ASTEROIDS
        coins = [[NSMutableArray alloc] init];
        asteroids = [[NSMutableArray alloc] init];
        
        //CREATE BACKDROP
        background = [CCSprite spriteWithFile:@"spaceBackground.png"];
        background.anchorPoint = CGPointZero;
        [self addChild:background];
        
        //CREATE SHIP
        ship = [CCSprite spriteWithFile:@"darkship.png"];
        ship.position = ccp(screenWidth/2, screenHeight/2);
        [self addChild:ship];
        
        //Coins
        int coinCount = 0;
        
        //ASTEROID
        fire = [CCParticleSystemQuad particleWithFile:@"burning_star_v1.plist"];
        [self addChild:fire];
        ast  = [CCSprite spriteWithFile: @"asteroid1.png"];
        ast.position = ccp(100, 50);
        [self addChild: ast];
        [asteroids addObject:ast];
        fire.position = ast.position;
        
        //TEMPORARY MAKE POWERUP
        fastForward = [CCSprite spriteWithFile:@"fastForward.png"];
        fastForward.position = ccp(200, 200);
        [self addChild:fastForward];
        
        //KEEP TRACK OF SCORE
        newScore = 0;
        
        //ADD THE SCORE LABEL
        scoreLabel = [CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(200,30) alignment:UITextAlignmentRight fontName:@"Marker Felt" fontSize:30];
        scoreLabel.position = ccp(220, 450); //Middle of the screen...
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
                int xcoin = arc4random() % 320;
                int ycoin = arc4random() % 480;
                
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
                    newScore++;
                    [self updateScore:newScore];
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
            if (asteroidHelper.position.x < (ship.position.x + 40) && asteroidHelper.position.x > ship.position.x - 40)
            {
                if (asteroidHelper.position.y < (ship.position.y + 60) && asteroidHelper.position.y > ship.position.y - 80)
                {
                    [self removeChild:asteroidHelper cleanup:YES];
                    [self removeChild:fire cleanup:YES];
                    [self removeChild:ship cleanup:YES];
                    [asteroids removeObjectAtIndex:first];
                }
            }
        }
    }
    
    
}

- (void)updateScore:(int)newScore
{
    [scoreLabel setString: [NSString stringWithFormat:@"%d", newScore]];
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
    
    [self createCoins];
    [self detectCollisions];
}

@end
