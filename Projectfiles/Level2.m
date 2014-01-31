//
//  Level2.m
//  Spaceship
//
//  Created by Karson Ota on 1/22/14.
//
//

#import "Level2.h"
#include <stdlib.h>
#include <math.h>


//DEFINE OBJECTS
CCSprite * background;
CCSprite * ship;
CCSprite * fire;
CCSprite * coin;
CCSprite * asteroid;
CCRepeatForever * spinCoin;
NSMutableArray * coins;
NSMutableArray * asteroids;
CCSprite * coinHelper;
CCSprite * asteroidHelper;
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

@interface Level2 (PrivateMethods)
@end

@implementation Level2
-(id) init
{
	if ((self = [super init]))
	{
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        int shipPositionX = winSize.width / 2;
        int shipPositionY = winSize.height / 2;
        
        
        //INITIALIZE THE ARRAY TO KEEP TRACK OF COINS AND ASTEROIDS
        coins = [[NSMutableArray alloc] init];
        asteroids = [[NSMutableArray alloc] init];
        
        //CREATE BACKDROP
        background = [CCSprite spriteWithFile:@"spaceBackground.png"];
        background.anchorPoint = CGPointZero;
        [self addChild:background];
        
        //CREATE SHIP
        ship = [CCSprite spriteWithFile:@"blackship.png"];
        //ship.position = ccp(screenWidth/2, screenHeight/2);
        ship.position = ccp(shipPositionX, shipPositionY);
        [self addChild:ship];
        
        //KEEP TRACK OF SCORE
        newScoreLevel2 = 0;
        
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
    if ([coins count] < 50)
    {
        if (timer < 20)
        {
            
            //Dimensions
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
            [coin runAction:[CCSequence actions:[CCDelayTime actionWithDuration:5], [CCCallFuncN actionWithTarget:self selector:@selector(removeOldCoins:)], nil]];
            [self addChild:coin z:0];
            [coins addObject:coin];//Array keeps track of coins
        }
    }
}

-(void) removeOldCoins:(id)sender
{
    [self removeChild:sender cleanup:YES];
    [coins removeObjectIdenticalTo:sender];
}

-(void) createAsteroids
{
    
    int timer = arc4random() % 45000;//1 asteroid per 15 sec
    
    if (timer < 10)
        
    {
        
        fire1 = [CCParticleSystemQuad particleWithFile:@"burning_star_v1.plist"];
        [self addChild:fire1];
        ast1 = [CCSprite spriteWithFile: @"asteroid1.png"];
        ast1.position = ccp(0, 0);
        [self addChild: ast1];
        [asteroids addObject:ast1];
        ast1.position =ccp(ast1.position.x + 3, ast1.position.y + 3);
        fire1.position = ast1.position;
        
    }
    
    if (timer > 10 && timer <20)
        
    {
        fire2 = [CCParticleSystemQuad particleWithFile:@"burning_star_v1.plist"];
        [self addChild:fire2];
        ast2  = [CCSprite spriteWithFile: @"asteroid1.png"];
        ast2.position = ccp(0, 50);
        [self addChild: ast2];
        [asteroids addObject:ast2];
        ast2.position =ccp(ast2.position.x + 5, ast2.position.y);
        fire2.position = ast2.position;
        
    }
    
    if (timer > 20 && timer <30)
        
    {
        fire3 = [CCParticleSystemQuad particleWithFile:@"burning_star_v1.plist"];
        [self addChild:fire3];
        ast3  = [CCSprite spriteWithFile: @"asteroid1.png"];
        ast3.position = ccp(0, 300);
        [self addChild: ast3];
        [asteroids addObject:ast3];
        ast3.position =ccp(ast3.position.x + 5, ast3.position.y);
        fire3.position = ast3.position;
        
    }
    
    if (timer > 30 && timer <40)
        
    {
        fire4 = [CCParticleSystemQuad particleWithFile:@"burning_star_v1.plist"];
        [self addChild:fire4];
        ast4  = [CCSprite spriteWithFile: @"asteroid1.png"];
        ast4.position = ccp(330, 50);
        [self addChild: ast4];
        [asteroids addObject:ast4];
        ast4.position =ccp(ast4.position.x - 3, ast4.position.y + 4);
        fire4.position = ast4.position;
        
    }
    
    if (timer > 40 && timer <50)
        
    {
        
        fire5 = [CCParticleSystemQuad particleWithFile:@"burning_star_v1.plist"];
        [self addChild:fire5];
        ast5  = [CCSprite spriteWithFile: @"asteroid1.png"];
        ast5.position = ccp(100, 0);
        [self addChild: ast5];
        [asteroids addObject:ast5];
        ast5.position =ccp(ast5.position.x, ast5.position.y + 5);
        fire5.position = ast5.position;
    }
    
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
                    newScoreLevel2++;
                    [self updateScore:newScoreLevel2];
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
                    if(asteroidHelper == ast1){
                        [self removeChild:fire1 cleanup:YES];
                    }
                    if(asteroidHelper == ast2){
                        [self removeChild:fire2 cleanup:YES];
                    }
                    if(asteroidHelper == ast3){
                        [self removeChild:fire3 cleanup:YES];
                    }
                    if(asteroidHelper == ast4){
                        [self removeChild:fire4 cleanup:YES];
                    }
                    if(asteroidHelper == ast5){
                        [self removeChild:fire5 cleanup:YES];
                    }
                    
                    [self removeChild:asteroidHelper cleanup:YES];
                    [self removeChild:ship cleanup:YES];
                    [asteroids removeObjectAtIndex:first];
                    if (newScoreLevel2 > 25)
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

- (void)updateScore:(int)newScoreLevel2
{
    [scoreLabel setString: [NSString stringWithFormat:@"%d", newScoreLevel2]];
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
        if (newScoreLevel2 > 25)
        {
            [[CCDirector sharedDirector] replaceScene: [[Victory alloc] init]];
        }
        else
        {
            [[CCDirector sharedDirector] replaceScene: [[GameOver alloc] init]];
        }
    }
    
    if(ast1.position.x > 0 && ast1.position.x < 400)
        
    {
        
        ast1.position =ccp(ast1.position.x + 3, ast1.position.y + 3);
        fire1.position = ast1.position;
        
    }
    
    else if(ast2.position.x > 0 && ast2.position.x < 400)
        
    {
        
        ast2.position =ccp(ast2.position.x + 5, ast2.position.y);
        fire2.position = ast2.position;
        
        
    }
    
    else if(ast3.position.x > 0 && ast3.position.x < 400)
        
    {
        
        ast3.position =ccp(ast3.position.x + 5, ast3.position.y);
        fire3.position = ast3.position;
        
        
    }
    
    else if(ast4.position.y > 0 && ast4.position.y < 570)
        
    {
        
        ast4.position =ccp(ast4.position.x - 3, ast4.position.y + 4);
        fire4.position = ast4.position;
        
        
    }
    
    else if(ast5.position.y > 0 && ast5.position.y < 570)
        
    {
        
        ast5.position = ccp(ast5.position.x, ast5.position.y + 5);
        fire5.position = ast5.position;
        
        
    }
    
    else
        
    {
        
        [self createAsteroids];
        
    }
    [self createCoins];
    [self detectCollisions];
}

@end
