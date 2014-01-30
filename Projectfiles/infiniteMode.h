/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import <SpriteKit/SpriteKit.h>
#import "kobold2d.h"




@interface infiniteMode : CCLayer
{
    int newScore;
    int timerHelper;
    int shipSpeed;
    int powerupIdentifier;
    CCLabelTTF * scoreLabel;
    CCAction *spinningCoin;
    NSMutableArray* spinningFrames;
    
    
    
    
    
    
}
typedef NS_ENUM(unsigned short, PowerUp) {
    PowerUp_Level0,
    PowerUp_Level1,
    PowerUp_Level2,
    PowerUp_Level3
};


@property (nonatomic, assign) PowerUp powerUp;

-(void) updateScore:(int) newScore;




@end
