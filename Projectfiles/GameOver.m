//
//  GameOver.m
//  Spaceship
//
//  Created by James Balchunas on 1/30/14.
//
//

#import "GameOver.h"
#import "Menu.h"

CCMenu * gameOverMenu;
CCSprite * background;

@implementation GameOver

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
        CCMenuItemFont * menuItem1 = [CCMenuItemFont itemWithString:@"Game Over"];
        CCMenuItemImage * menuItem2 = [CCMenuItemImage itemWithNormalImage:@"MainMenuButton.png"
                                                             selectedImage: @"MainMenuButton.png"
                                                                    target:self
                                                                  selector:@selector(goToMainMenu:)];
        gameOverMenu  = [CCMenu menuWithItems:menuItem1, menuItem2, nil];
        [gameOverMenu alignItemsVertically];
        [self addChild: gameOverMenu];
        
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
