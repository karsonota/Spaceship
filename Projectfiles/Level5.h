//
//  Level5.h
//  Spaceship
//
//  Created by Karson Ota on 1/22/14.
//
//

#import "kobold2d.h"
@interface Level5 : CCLayer
{
    int newScoreLevel5;
    CCLabelTTF * scoreLabel;
    CCAction *spinningCoin;
    NSMutableArray* spinningFrames;
    
}
-(void) updateScore:(int) newScore;

@end
