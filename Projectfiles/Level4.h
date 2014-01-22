//
//  Level4.h
//  Spaceship
//
//  Created by Karson Ota on 1/22/14.
//
//

//#import <SpriteKit/SpriteKit.h>
#import "kobold2d.h"
@interface Level4 : CCLayer
{
    int newScore;
    CCLabelTTF * scoreLabel;
    CCAction *spinningCoin;
    NSMutableArray* spinningFrames;
    
}
-(void) updateScore:(int) newScore;

@end
