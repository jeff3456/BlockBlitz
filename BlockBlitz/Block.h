//
//  Block.h
//  Cube_Smash_2014
//
//  Copyright (c) 2014 Joshua Howland. All rights reserved.
//

#import "SpriteSuper.h"

@interface Block : SpriteSuper
-(id)initWithScreenSize:(CGSize)screenSize;
-(void)update;

@property SKSpriteNode *blockSprite;
@property CGSize screenSize;
@property double x;
@property double y;
@property double dy;
@property double over;
@property int a;
@property int b;
@property int op;
@property double rad;
@property CGPoint spawn;

@property int width;
@property int xPos;

@end
