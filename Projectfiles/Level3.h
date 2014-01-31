//
//  Level3.h
//  Spaceship
//
//  Created by Karson Ota on 1/22/14.
//
//

#import "kobold2d.h"
@interface Level3 : CCLayer
{
    int newScoreLevel3;
    CCLabelTTF * scoreLabel;
    CCAction *spinningCoin;
    NSMutableArray* spinningFrames;
    
}
-(void) updateScore:(int) newScore;

@end
