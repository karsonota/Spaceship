//
//  Instructions.m
//  Spaceship
//
//  Created by James Balchunas on 1/30/14.
//
//

#import "Instructions.h"
#import "Menu.h"

CCMenu * instructionsMenu;
CCSprite * background;

@implementation Instructions

-(id) init
{
	if ((self = [super init]))
	{
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        //GET SCREEN DIMENSIONS
        CGRect screenRect = [[UIScreen mainScreen] bounds];
        CGFloat screenWidth = screenRect.size.width;
        CGFloat screenHeight = screenRect.size.height;
        
        
        //CREATE BACKDROP
        background = [CCSprite spriteWithFile:@"spaceBackground.png"];
        background.anchorPoint = CGPointZero;
        [self addChild:background];
        
        
        
        //INITIALIZE MENU
        CCMenuItemImage * menuItem1 = [CCMenuItemFont itemWithString:@"Tap to move"];
        CCMenuItemImage * menuItem2 = [CCMenuItemFont itemWithString:@"2 Finger Tap 4 power up"];
        CCMenuItemImage * menuItem3 = [CCMenuItemFont itemWithString:@"Collect coins" ];
        CCMenuItemImage * menuItem4 = [CCMenuItemFont itemWithString:@"Don't die" ];
        CCMenuItemImage * menuItem5 = [CCMenuItemImage itemWithNormalImage:@"MainMenuButton.png"
                                                             selectedImage: @"MainMenuButton.png"
                                                                    target:self
                                                                  selector:@selector(goToMainMenu:)];
        instructionsMenu  = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, menuItem4, menuItem5, nil];
        [instructionsMenu alignItemsVertically];
        [self addChild: instructionsMenu];
        
        //SCHEDULE UPDATE
        [self scheduleUpdate];
	}
	return self;
}

- (void) goToMainMenu: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: [[Menu alloc] init]];
}

@end
