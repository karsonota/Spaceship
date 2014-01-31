//
//  Level4.h
//  Spaceship
//
//  Created by Karson Ota on 1/22/14.
//
//

#import "kobold2d.h"
@interface Level4 : CCLayer
{
    int newScoreLevel4;
    CCLabelTTF * scoreLabel;
    CCAction *spinningCoin;
    NSMutableArray* spinningFrames;
    
}
-(void) updateScore:(int) newScore;

@end
