//
//  Level1.h
//  Spaceship
//
//  Created by Karson Ota on 1/22/14.
//
//

#import "kobold2d.h"
@interface Level1 : CCLayer
{
    int newScoreLevel1;
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
