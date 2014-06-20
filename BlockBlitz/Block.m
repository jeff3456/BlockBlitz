//
//  Block.m
//  Cube_Smash_2014
//
//  Copyright (c) 2014 Joshua Howland. All rights reserved.
//

#import "Block.h"

@implementation Block

-(id)initWithScreenSize:(CGSize)screenSize{
    self = [super init];
    _screenSize = screenSize;
    
    _width = screenSize.width/20;
    
    _blockSprite = [[SKSpriteNode alloc] initWithColor:[UIColor greenColor] size:CGSizeMake(_width, _width)];
    _blockSprite.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_blockSprite.size];
    _xPos = arc4random() % (NSInteger)( screenSize.width);
    _blockSprite.position = CGPointMake(_xPos,screenSize.height*1.1);
    _blockSprite.size = CGSizeMake(_width, _width);
    NSLog(@"creating new block");
    return self;
}

-(void)update{
    
    
}

@end
