//
//  Victory.m
//  Spaceship
//
//  Created by James Balchunas on 1/30/14.
//
//

#import "Victory.h"
#import "Menu.h"

CCMenu * victoryMenu;
CCSprite * background;

@implementation Victory

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
        CCMenuItemFont * menuItem1 = [CCMenuItemFont itemWithString:@"Victory"];
        CCMenuItemImage * menuItem2 = [CCMenuItemImage itemWithNormalImage:@"MainMenuButton.png"
                                                             selectedImage: @"MainMenuButton.png"
                                                                    target:self
                                                                  selector:@selector(goToMainMenu:)];
        victoryMenu  = [CCMenu menuWithItems:menuItem1, menuItem2, nil];
        [victoryMenu alignItemsVertically];
        [self addChild: victoryMenu];
        
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
