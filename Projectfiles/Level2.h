//
//  Level2.h
//  Spaceship
//
//  Created by Karson Ota on 1/22/14.
//
//

#import "kobold2d.h"
#import "Level1.h"
@interface Level2 : CCLayer
{
    int newScoreLevel2;
    int shipSpeed;

    CCLabelTTF * scoreLabel;
    CCAction *spinningCoin;
    NSMutableArray* spinningFrames;
    
}





@property (nonatomic, assign) PowerUpWaiting powerUpWaiting;

@property (nonatomic, assign) PowerUpActive powerUpActive;

-(void) updateScore:(int) newScore;

@end
