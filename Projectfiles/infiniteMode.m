/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim.
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "infiniteMode.h"
#include <stdlib.h>
#include <math.h>
#import "SimpleAudioEngine.h"





//DEFINE OBJECTS
CCSprite * background;
CCSprite * ship;
CCSprite * fire;
CCSprite * coin;
CCSprite * asteroid;
CCSprite * fastForward;
CCRepeatForever * spinCoin;
CCSprite * fastForwardWaiting;
NSMutableArray * coins;
NSMutableArray * asteroids;
NSMutableArray * powerups;
CCSprite * coinHelper;
CCSprite * asteroidHelper;
CCSprite * powerupHelper;
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

@interface infiniteMode (PrivateMethods)
@end

@implementation infiniteMode



-(id) init
{
	if ((self = [super init]))
	{
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        
        //GET SCREEN DIMENSIONS
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        //INITIALIZE THE ARRAY TO KEEP TRACK OF COINS AND ASTEROIDS
        coins = [[NSMutableArray alloc] init];
        asteroids = [[NSMutableArray alloc] init];
        powerups = [[NSMutableArray alloc] init];
        
        //CREATE BACKDROP
        background = [CCSprite spriteWithFile:@"spaceBackground.png"];
        background.anchorPoint = CGPointZero;
        [self addChild:background];
        
        //CREATE SHIP
        ship = [CCSprite spriteWithFile:@"blackship.png"];
        ship.position = ccp(screenWidth/2, screenHeight/2);
        [self addChild:ship];
        
        //KEEP TRACK OF SCORE
        newScore = 0;
        
        //DEFINE POWERUP STATUS
        self.powerUpWaiting = PowerUpWaiting_Level0;
        self.powerUpActive = PowerUpActive_Level0;
        
        //MAKE ASTEROIDS MORE FREQUENT
        timerHelper = 15000;
        
        //ADD THE SCORE LABEL
        scoreLabel = [CCLabelTTF labelWithString:@"0" dimensions:CGSizeMake(200,30) hAlignment:UITextAlignmentRight fontName:@"Marker Felt" fontSize:30];
        scoreLabel.position = ccp(winSize.width - 110, winSize.height - 30); //Middle of the screen...
        [self addChild:scoreLabel z:1];
        
        //LOAD SOUND
        
        [[SimpleAudioEngine sharedEngine] preloadEffect:@"DeathFlash.wav"];
        
        
        //SCHEDULE UPDATE
        [self scheduleUpdate];
	}
	return self;
}


-(void) createCoins
{
    int timer = arc4random() % 1000;//makes coins appear randomly
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
        [coin runAction:[CCSequence actions:[CCDelayTime actionWithDuration:5], [CCCallFuncN actionWithTarget:self selector:@selector(removeOldCoins:)], nil]];
        [self addChild:coin z:0];
        [coins addObject:coin];//Array keeps track of coins
    }
}

-(void) removeOldCoins:(id)sender
{
    [self removeChild:sender cleanup:YES];
    [coins removeObjectIdenticalTo:sender];
}

-(void) createAsteroids
{
    
    int timer = arc4random() % timerHelper;//makes coins appear randomly
    
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
    if (timer < 50)
    {
        if (timerHelper > 200)
        {
            timerHelper -= 150;
        }
    }
}

-(void) createPowerups
{
    if ([powerups count] == 0 && self.powerUpWaiting == PowerUpWaiting_Level0)
    {
        //WHERE TO RANDOMLY PLACE THE POWERUPS
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        int screenWidth = screenRect.size.width;
        int screenHeight = screenRect.size.height;
        
        int xPowerup = arc4random() % screenWidth;
        int yPowerup = arc4random() % screenHeight;
        
        int timer = arc4random() % 100;
        if (timer == 1)
        {
            fastForward = [CCSprite spriteWithFile:@"fastForward.png"];
            fastForward.position = ccp(xPowerup, yPowerup);
            [self addChild:fastForward];
            [powerups addObject:fastForward];
            [fastForward runAction:[CCSequence actions:[CCDelayTime actionWithDuration:5], [CCCallFuncN actionWithTarget:self selector:@selector(removeOldPowerups:)], nil]];
        }
    }
    
}

-(void) removeOldPowerups:(id)sender
{
    [self removeChild:sender cleanup:YES];
    [powerups removeObjectIdenticalTo:sender];
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
                    
                    [[SimpleAudioEngine sharedEngine] playEffect:@"DeathFlash.wav"];
                    
                }
            }
        }
    }
    for(int i = 0; i < [powerups count]; i++)
    {
        NSInteger first = i;
        powerupHelper = [powerups objectAtIndex: first];
        if (powerupHelper.position.x < (ship.position.x + 40) && powerupHelper.position.x > ship.position.x - 40)
        {
            if (powerupHelper.position.y < (ship.position.y + 60) && powerupHelper.position.y > ship.position.y - 80)
            {
                [self removeChild:powerupHelper cleanup:YES];
                [powerups removeObjectAtIndex:first];
                self.powerUpWaiting = PowerUpWaiting_Level1;
<<<<<<< HEAD
                
                fastForwardWaiting = [CCSprite spriteWithFile:@"fastForwardWaiting.png"];
                fastForwardWaiting.position = ccp(scoreLabel.position.x + 100, scoreLabel.position.y - 25);
                [self addChild:fastForwardWaiting];
=======
//                [self performSelector:@selector(resetPowerUp) withObject:nil afterDelay:5.0f];

>>>>>>> 862dd192d4057a67a5f6a92afcd81b47d238d557
                
            }
        }
    }
}

- (void)resetPowerUp {
    self.powerUpActive = PowerUpActive_Level0;
}

- (void)updateScore:(int)newScore
{
    [scoreLabel setString: [NSString stringWithFormat:@"%d", newScore]];
}

-(void) update:(ccTime)dt
{
    CCArray* touches = [KKInput sharedInput].touches;
    if ([touches count] > 1)
<<<<<<< HEAD
=======
    {
        if (self.powerUpWaiting == PowerUpWaiting_Level1)
        {
            self.powerUpWaiting = PowerUpWaiting_Level0;
            self.powerUpActive = PowerUpActive_Level1;
            [self performSelector:@selector(resetPowerUp) withObject:nil afterDelay:5.0f];
        }
        
        

        [[SimpleAudioEngine sharedEngine] playEffect:@"DeathFlash.wav"];
    }
    
    
    if (self.powerUpActive == PowerUpActive_Level0)
    {
        shipSpeed = 100;
    }
    if (self.powerUpActive == PowerUpActive_Level1)
>>>>>>> 862dd192d4057a67a5f6a92afcd81b47d238d557
    {
        if (self.powerUpWaiting == PowerUpWaiting_Level1)
        {
            self.powerUpWaiting = PowerUpWaiting_Level0;
            self.powerUpActive = PowerUpActive_Level1;
            [self performSelector:@selector(resetPowerUp) withObject:nil afterDelay:5.0f];
            [self removeChild:fastForwardWaiting cleanup:YES];

        }
    }
    
    
<<<<<<< HEAD
    if (self.powerUpActive == PowerUpActive_Level0)
    {
        shipSpeed = 100;
    }
    if (self.powerUpActive == PowerUpActive_Level1)
    {
        shipSpeed = 200;
    }

=======
    
>>>>>>> 862dd192d4057a67a5f6a92afcd81b47d238d557
    
    if ([touches count] == 1)
    {
        //MAKES SHIP MOVE TO TAP LOCATION
        KKInput * input = [KKInput sharedInput];
        CGPoint tap = [input locationOfAnyTouchInPhase:KKTouchPhaseBegan];
        if (tap.x != 0 && tap.y != 0)
        {
            [ship stopAllActions]; // Nullifies previous actions
            int addedx = tap.x - ship.position.x;
            int addedy = tap.y - ship.position.y;
            int squaredx = pow(addedx, 2);
            int squaredy = pow(addedy, 2);
            int addedSquares = squaredx + squaredy;
            int distance = pow(addedSquares, 0.5);
            [ship runAction: [CCMoveTo actionWithDuration:distance/shipSpeed position:tap]];//makes ship move at a constant speed
        }
    }
    
    if(ast1.position.x > 0 && ast1.position.x < 1600)
        
    {
        ast1.position =ccp(ast1.position.x + 3, ast1.position.y + 3);
        fire1.position = ast1.position;
    }
    
    else if(ast2.position.x > 0 && ast2.position.x < 1600)
        
    {
        ast2.position =ccp(ast2.position.x + 5, ast2.position.y);
        fire2.position = ast2.position;
    }
    
    else if(ast3.position.x > 0 && ast3.position.x < 1600)
        
    {
        ast3.position =ccp(ast3.position.x + 5, ast3.position.y);
        fire3.position = ast3.position;
    }
    
    else if(ast4.position.y > 0 && ast4.position.y < 2000)
        
    {
        ast4.position =ccp(ast4.position.x - 3, ast4.position.y + 4);
        fire4.position = ast4.position;
    }
    
    else if(ast5.position.y > 0 && ast5.position.y < 2000)
        
    {
        ast5.position = ccp(ast5.position.x, ast5.position.y + 5);
        fire5.position = ast5.position;
    }
    
    else
        
    {
        [self createAsteroids];
    }
    [self createCoins];
    [self createPowerups];
    [self detectCollisions];
}



@end
