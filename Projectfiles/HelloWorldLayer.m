/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "HelloWorldLayer.h"
#include <stdlib.h>
#include <math.h>


//DEFINE OBJECTS
CCSprite * ship;
CCSprite * coin;
CCRepeatForever * spinCoin;
NSMutableArray *coins;
CCSprite * projectile;

@interface HelloWorldLayer (PrivateMethods)
@end

@implementation HelloWorldLayer

-(id) init
{
	if ((self = [super init]))
	{
        
        //INITIALIZE THE ARRAY TO KEEP TRACK OF COINS
        coins = [[NSMutableArray alloc] init];

        
        //CREATE SHIP
        ship = [CCSprite spriteWithFile:@"darkship.png"];
        ship.position = ccp(50, 50);
        [self addChild:ship];
        
        
        //SCHEDULE UPDATE
        [self scheduleUpdate];
	}
	return self;
}

-(void) createCoins
{
    int timer = arc4random() % 1000;//makes coins appear randomly
    if (timer < 10)
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
        [self addChild:coin z:0];
        [coins addObject:coin];//Array keeps track of coins
    }
    
    
}

-(void) detectCollisions
{
    for(int i = 0; i < [coins count]; i++)
    {
        if ([coins count] > 0)
        {
            NSInteger first = i;
            projectile = [coins objectAtIndex: first];
            if (projectile.position.x < (ship.position.x + 40) && projectile.position.x > ship.position.x - 40)
            {
                if (projectile.position.y < (ship.position.y + 60) && projectile.position.y > ship.position.y - 80)

                if (projectile.position.y == projectile.position.y)
                {
                    [self removeChild:projectile cleanup:YES];
                    [coins removeObjectAtIndex:first];
                }
            }
        }
    }
    
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
