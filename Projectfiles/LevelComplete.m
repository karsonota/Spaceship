//
//  LevelComplete.m
//  Spaceship
//
//  Created by James Balchunas on 1/30/14.
//
//

#import "LevelComplete.h"

CCMenu * levelCompleteMenu;
CCSprite * background;

@implementation LevelComplete

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
        CCMenuItemFont * menuItem1 = [CCMenuItemFont itemWithString:@"Level Complete"];
        CCMenuItemImage * menuItem2 = [CCMenuItemImage itemWithNormalImage:@"IconWide_Off.bmp"
                                                             selectedImage: @"IconWide_Off.bmp"
                                                                    target:self
                                                                  selector:@selector(goToNextLevel:)];
        CCMenuItemImage * menuItem3 = [CCMenuItemImage itemWithNormalImage:@"IconWide_Off.bmp"
                                                             selectedImage: @"IconWide_Off.bmp"
                                                                    target:self
                                                                  selector:@selector(goToMainMenu:)];
        
        levelCompleteMenu  = [CCMenu menuWithItems:menuItem1, menuItem2, nil];
        [levelCompleteMenu alignItemsVertically];
        [self addChild: levelCompleteMenu];
        
        //SCHEDULE UPDATE
        [self scheduleUpdate];
	}
	return self;
}

- (void) goToNextLevel: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: [[Menu alloc] init]];
}
- (void) goToMainMenu: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: [[Menu alloc] init]];
}



@end
