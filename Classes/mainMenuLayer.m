//
//  Traffic
//  Car Project
//
//  Created by iD Student Account on 7/5/11.
//  Copyright __MyCompanyName__ 2011. All rights reserved.
//
//MAKE SURE TO INCLUDE THE BOOLEANS FOR THE CHEATS! I have them as comments so that the program will run smoothly

// Import the interfaces
#import "mainMenuLayer.h"
#import "CCTouchDispatcher.h"
#import "HelloWorldLayer.h"
#import "GameKitConnector.h"

// HelloWorldLayer implementation
@implementation MainMenuLayer

@synthesize connection;

+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	MainMenuLayer *layer = [MainMenuLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init {
	if( (self=[super init])) {
		
		CCMenuItem *item = [CCMenuItemImage itemFromNormalImage:@"BUTTON-FOR-THE-OBESE-KID.png" selectedImage:@"BUTTON-FOR-THE-OBESE-KID.png" target: self selector:@selector(startGame:)];
		item.position = ccp(155, 300);
		
    
    CCMenuItem *item2 = [CCMenuItemImage itemFromNormalImage:@"Multiplayer.png" selectedImage:@"Multiplayer.png" target: self selector:@selector(start2Player:)];
		item2.position = ccp(155, 75);

    
		CCMenu *menu = [CCMenu menuWithItems:item, item2, nil];
		menu.position = CGPointZero;
		[self addChild:menu];
		CCLabelTTF *welcome = [CCLabelTTF labelWithString:@"Welcome to Traffic" fontName:@"Marker Felt" fontSize:40];
		// position the label on the center of the screen
		welcome.position =  ccp(160, 455);
		
		// add the label as a child to this Layer
		[self addChild: welcome];
		
		self.isTouchEnabled=YES;
	}
	
	return self;
}

-(void)startGame: (id)sender{
	CCScene * newScene = [HelloWorldLayer scene];
	[[CCDirector sharedDirector] replaceScene:newScene];
}

-(void)start2Player: (id)sender {
  connection = [[[GameKitConnector alloc] init] retain];
  connection.delegate = self;
  [connection startPeerToPeer];
}

-(void) connected {
  if (connected) return;
  connected = true;

  CCScene * newScene = [HelloWorldLayer scene];
  HelloWorldLayer *layer =  [[newScene children] objectAtIndex:0];
  [layer setGameKitConnection:connection];  
	[[CCDirector sharedDirector] replaceScene:newScene];
}

-(void)recievedCommand:(NSString *)command withArgument:(NSString *)arguments{
  // do nothing
}
@end
