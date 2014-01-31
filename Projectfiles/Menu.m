//
//  Menu.m
//  Spaceship
//
//  Created by James Balchunas on 1/30/14.
//
//

#import "Menu.h"
#import "infiniteMode.h"
#import "LevelSelect.h"

CCMenu * mainMenu;
CCSprite * background;

@implementation Menu

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
        CCMenuItemFont * menuItem1 = [CCMenuItemFont itemWithString:@"Spaceship"];
        CCMenuItemImage * menuItem2 = [CCMenuItemImage itemWithNormalImage:@"InfiniteModeButton.png"
                                                             selectedImage: @"InfiniteModeButton.png"
                                                                    target:self
                                                                  selector:@selector(goToInfiniteMode:)];
        CCMenuItemImage * menuItem3 = [CCMenuItemImage itemWithNormalImage:@"LevelModeButton.png"
                                                             selectedImage: @"LevelModeButton.png"
                                                                    target:self
                                                                  selector:@selector(goToLevelSelect:)];
        mainMenu  = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, nil];
        [mainMenu alignItemsVertically];
        [self addChild: mainMenu];
        
        //SCHEDULE UPDATE
        [self scheduleUpdate];
	}
	return self;
}

- (void) goToInfiniteMode: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: [[infiniteMode alloc] init]];
}
- (void) goToLevelSelect: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: [[LevelSelect alloc] init]];
}

@end
