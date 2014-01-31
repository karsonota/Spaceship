//
//  LevelSelect.m
//  Spaceship
//
//  Created by James Balchunas on 1/30/14.
//
//

#import "LevelSelect.h"
#import "Level1.h"
#import "Level2.h"
#import "Level3.h"
#import "Level4.h"
#import "Level5.h"


CCMenu * levelSelectMenu;
CCSprite * background;

@implementation LevelSelect

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
        CCMenuItemFont * menuItem1 = [CCMenuItemFont itemWithString:@"Select a level:"];
        CCMenuItemImage * menuItem2 = [CCMenuItemImage itemWithNormalImage:@"Level1Button.png"
                                                             selectedImage: @"Level1Button.png"
                                                                    target:self
                                                                  selector:@selector(goToLevelOne:)];
        CCMenuItemImage * menuItem3 = [CCMenuItemImage itemWithNormalImage:@"Level2Button.png"
                                                             selectedImage: @"Level2Button.png"
                                                                    target:self
                                                                  selector:@selector(goToLevelTwo:)];
        CCMenuItemImage * menuItem4 = [CCMenuItemImage itemWithNormalImage:@"Level3Button.png"
                                                             selectedImage: @"Level3Button.png"
                                                                    target:self
                                                                  selector:@selector(goToLevelThree:)];
        CCMenuItemImage * menuItem5 = [CCMenuItemImage itemWithNormalImage:@"Level4Button.png"
                                                             selectedImage: @"Level4Button.png"
                                                                    target:self
                                                                  selector:@selector(goToLevelFour:)];
        CCMenuItemImage * menuItem6 = [CCMenuItemImage itemWithNormalImage:@"Level5Button.png"
                                                             selectedImage: @"Level5Button.png"
                                                                    target:self
                                                                  selector:@selector(goToLevelFive:)];
        levelSelectMenu  = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, menuItem4, menuItem5, menuItem6, nil];
        [levelSelectMenu alignItemsVertically];
        [self addChild: levelSelectMenu];
        
        //SCHEDULE UPDATE
        [self scheduleUpdate];
	}
	return self;
}

- (void) goToLevelOne: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: [[Level1 alloc] init]];
}
- (void) goToLevelTwo: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: [[Level2 alloc] init]];
}
- (void) goToLevelThree: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: [[Level3 alloc] init]];
}
- (void) goToLevelFour: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: [[Level4 alloc] init]];
}
- (void) goToLevelFive: (CCMenuItem  *) menuItem
{
    [[CCDirector sharedDirector] replaceScene: [[Level5 alloc] init]];
}


@end
