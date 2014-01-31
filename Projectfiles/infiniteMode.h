/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim.
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "kobold2d.h"





@interface infiniteMode : CCLayer
{
    int newScore;
    int timerHelper;
    float shipSpeed;
    CCLabelTTF * scoreLabel;
    CCAction *spinningCoin;
    NSMutableArray* spinningFrames;
    
    
    
    
    
    
}
typedef NS_ENUM(unsigned short, PowerUpWaiting) {
    PowerUpWaiting_Level0,
    PowerUpWaiting_Level1,
    PowerUpWaiting_Level2,
    PowerUpWaiting_Level3
};

typedef NS_ENUM(unsigned short, PowerUpActive) {
    PowerUpActive_Level0,
    PowerUpActive_Level1,
    PowerUpActive_Level2,
    PowerUpActive_Level3
};




@property (nonatomic, assign) PowerUpWaiting powerUpWaiting;

@property (nonatomic, assign) PowerUpActive powerUpActive;

-(void) updateScore:(int) newScore;




@end
