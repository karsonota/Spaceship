/*
 * Kobold2D™ --- http://www.kobold2d.org
 *
 * Copyright (c) 2010-2011 Steffen Itterheim. 
 * Released under MIT License in Germany (LICENSE-Kobold2D.txt).
 */

#import "AppDelegate.h"

@implementation AppDelegate

-(void) initializationComplete
{
    NSLog(@"we are now here!!!!!!!");
#ifdef KK_ARC_ENABLED
	CCLOG(@"ARC is enabled");
#else
	CCLOG(@"ARC is either not available or not enabled");
#endif
    //self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"ship.png"]];
}

-(id) alternateView
{
	return nil;
}

@end
