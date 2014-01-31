//
//  PauseScreen.m
//  Spaceship
//
//  Created by Karson Ota on 1/31/14.
//
//

#import "PauseScreen.h"
#import "Menu.h"

CCMenu * pauseMenu;
CCSprite * background;

@implementation PauseScreen

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
        CCMenuItemFont * menuItem1 = [CCMenuItemFont itemWithString:@"Pause"];
        CCMenuItemImage * menuItem2 = [CCMenuItemImage itemWithNormalImage:@"MainMenuButton.png"
                                                             selectedImage: @"MainMenuButton.png"
                                                                    target:self
                                                                  selector:@selector(goToMainMenu:)];
        CCMenuItemImage * menuItem3 = [CCMenuItemImage itemWithNormalImage:@"resumeButton.png"
                                                             selectedImage: @"resumeButton.png"
                                                                    target:self
                                                                  selector:@selector(resumeGame:)];
        pauseMenu  = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, nil];
        [pauseMenu alignItemsVertically];
        [self addChild: pauseMenu];
        
        //SCHEDULE UPDATE
        [self scheduleUpdate];
	}
	return self;
}

- (void) goToMainMenu: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: [[Menu alloc] init]];
}

- (void) resumeGame: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] popScene];
}


@end
