//
//  Level3.h
//  Spaceship
//
//  Created by Karson Ota on 1/22/14.
//
//

#import "kobold2d.h"
#import "Level1.h"

@interface Level3 : CCLayer
{
    int newScoreLevel3;
    float shipSpeed;

    CCLabelTTF * scoreLabel;
    CCAction *spinningCoin;
    NSMutableArray* spinningFrames;
    
}





@property (nonatomic, assign) PowerUpWaiting powerUpWaiting;

@property (nonatomic, assign) PowerUpActive powerUpActive;

-(void) updateScore:(int) newScore;

@end
