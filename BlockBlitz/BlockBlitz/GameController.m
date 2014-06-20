//
//  SKPMyScene.m
//  Cube_Smash_2014
//
//  Copyright (c) 2014 Joshua Howland. All rights reserved.
//

/*
 Swipe down: other powerup
 
 */

/*
 TODO
 (1) Get button textures
 (2) Finish menu
 (3) Add global tree counter thats saved like high score
 (4) Add tree counter display
 (5) Add secondary powerup activated by swiping down
 (6) Make settings on the menu that allows you to select it
 (by default no powerup)
 (7) Add slow time powerup
 (8) Make it so that if you get 10,000 trees you can pick this
 as your secondary powerup
 (9) Add shooting powerup
 (10) If you have 30,000+ trees you can pick this
 (11) Come up with another
 (12) Implement adds
 (13) Make ads a global variable that can be turned off
 (14) That way app can be repackaged as a lite version
 (15) Or ads can be a 99 cent in app purchase
 >>Do 15 instead of 14.  Global variable for ads = false
 if payed
 (16) Come up with good app icon
 (17) Try to get gamecenter support for high score?
 
 
 BUGS:
 
 -Menu score goes past button
 */

#import "GameController.h"
#import "Block.h"
#import "MenuScene.h"

@interface GameController()

@property int time;
@property int score;
@property int highScore;
@property BOOL playing;
@property BOOL pause;
@property SKSpriteNode *pauseButton;
@property SKSpriteNode *resumeButton;
@property SKSpriteNode *menuButton;
@property int secondaryPowerup;
@property SKSpriteNode *sheildPowerup;
@property bool using2ndPowerup;
@property int eligiblefor2ndPowerup;
@property int powerup2Timer;

@property SKSpriteNode *background;
@property SKSpriteNode *player;
@property NSMutableArray *blocks;
@property int powerUpTimer;

@property CGPoint lastTouch;

@property SKLabelNode *tapToStart;
@property SKLabelNode *countLabel;
@property SKLabelNode *scoreLabel;
@property SKLabelNode *priceLabel;

@property NSData* bitdata;

@end

@implementation GameController

/*
 Init method.  Initialized most game objects and sets up
 scene.
 @param CGSize size: Size of current frame to work with.
 @return id: id of scene created
 */
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        /* Setup your scene here */
        
        self.backgroundColor = [SKColor colorWithRed:0 green:0 blue:0 alpha:1.0];
        self.physicsWorld.gravity = CGVectorMake(0, -2);
        
        _player = [[SKSpriteNode alloc] initWithColor:[UIColor purpleColor] size:CGSizeMake(self.size.width/20, self.size.width/20)];
        //_player.physicsBody = [SKPhysicsBody bodyWithRectangleOfSize:_player.size];
        _player.name = @"Player";
        [self addChild:_player];
        
        _tapToStart = [SKLabelNode labelNodeWithFontNamed:@"Georgia-Bold"];
        _tapToStart.text = @"Tap To Start!";
        _tapToStart.fontSize = self.size.width/10;
        _tapToStart.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame));
    
        
        _scoreLabel = [SKLabelNode labelNodeWithFontNamed:@"Georgia-Bold"];
        _scoreLabel.text = [NSString stringWithFormat:@"%i",(int)_score];
        _scoreLabel.fontSize = self.size.width/10;
        [self addChild:_scoreLabel];
        _scoreLabel.zPosition = 100;
        
        _pause = false;
        
        
        [self reset];
        _player.position = CGPointMake(self.size.width/2, ((int)self.size.height*.2));
        _countLabel.position = CGPointMake(CGRectGetMidX(self.frame),self.size.height*17/20);
        _scoreLabel.position = CGPointMake(CGRectGetMidX(self.frame),self.size.height*15/20);
        
        
        _pauseButton = [[SKSpriteNode alloc] initWithImageNamed:@"Pause_Button"];
        _pauseButton.size = CGSizeMake(self.size.width/8,self.size.width/8);
        _pauseButton.position = CGPointMake(_pauseButton.size.width, -_pauseButton.size.width+self.size.height-self.size.width/10);
        [self addChild:_pauseButton];
        _pauseButton.zPosition = 100;
        _pauseButton.name = @"Pause_Button";
        
        _resumeButton = [[SKSpriteNode alloc] initWithImageNamed:@"Play_Button"];
        _resumeButton.position = CGPointMake(self.size.width/2, self.size.height*1/3);
        _resumeButton.size = CGSizeMake(self.size.width*3/4, self.size.height/5);
        _resumeButton.zPosition = 10000;
        _resumeButton.name = @"Resume_Button";
        
        _menuButton = [[SKSpriteNode alloc] initWithImageNamed:@"Menu_Button"];
        _menuButton.position = CGPointMake(self.size.width/2, self.size.height*2/3);
        _menuButton.size = _resumeButton.size;
        _menuButton.zPosition = 10000;
        _menuButton.name = @"Menu_Button";
        
        _background = [[SKSpriteNode alloc] initWithImageNamed:@"SplashScreen"];
        _background.position = CGPointMake(self.size.width/2,self.size.height/2);
        _background.size = self.size;
        
    }
    return self;
}

/*
 Method called by system when a touch begins.
 @param NSSet touches: NSSet data type of all touches currently started
 @param UIEvent even: UIEvent marking touch beginining
 Both these parameters dont need to be worried about.
 @return: none
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    if(!_pause){
        for (UITouch *touch in touches) {
            CGPoint location = [touch locationInNode:self];
            _lastTouch = location;
            SKNode *na1 = [self nodeAtPoint:location];
            if([na1.name isEqualToString:_pauseButton.name]){
                //do some pause stuff
                [self pauseGame];
            }else{
                if(!_playing){
                    _playing = YES;
                    [_tapToStart removeFromParent];
                }
            }
        }
    }else{
        for (UITouch *touch in touches) {
            CGPoint location = [touch locationInNode:self];
            SKNode *na1 = [self nodeAtPoint:location];
            if([na1.name isEqualToString:_resumeButton.name]){
                [self resumeGame];
            }else if([na1.name isEqualToString:@"Menu_Button"]){
                [self returnToMenu];
            }
        }
    }
}

/*
 TO FIX:  HORIBLE CHECKING >> too many if statements, will process way to much
 Method called every time a touch is moved.  Contains nessesary updating to move
 players sprite.
 @param NSSet touches: NSSet data type of all touches currently started
 @param UIEvent even: UIEvent marking touch beginining
 Both these parameters dont need to be worried about.
 @return: none
 */
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    if(!_pause){
        for (UITouch *touch in touches) {
            CGPoint location = [touch locationInNode:self];
            //_player.position = CGPointMake(location.x, _player.position.y);
            int dX = -4.6*(_lastTouch.x-location.x);
            int newX = _player.position.x + dX;


                if(_player.position.x<self.size.width/10){
                    if(dX>0){
                        _player.position = CGPointMake(newX, _player.position.y);
                    }
                }else if(_player.position.x>self.size.width*.9){
                    if(dX<0){
                        _player.position = CGPointMake(newX, _player.position.y);
                    }
                }else{
                    if(newX>self.size.width*.9){
                        //do nothing
                    }else if(newX<self.size.width*.1){
                        //do nothing
                    }else{
                        _player.position = CGPointMake(newX, _player.position.y);
                    }
                }
            
            _lastTouch = location;
            
        }
        
    }
}

/*
 Method called every time a unique touch ends.
 @param NSSet touches: NSSet data type of all touches currently started
 @param UIEvent even: UIEvent marking touch beginining
 Both these parameters dont need to be worried about.
 @return: none
 */
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    //reset last touch?
}

/*
 Method that transitions current scene to menu scene.  Dealocates everything in GameController.
 */
-(void)returnToMenu{
    MenuScene *menuScene = [[MenuScene alloc] initWithSize:self.size];
    [self.view presentScene:menuScene transition:[SKTransition fadeWithColor:[UIColor clearColor] duration:1.0f]];
}

/*
 Method containing all game reset information.  Called each time a game ends
 and scene needs to be reset.
 @param: none
 @return: none
 */
-(void)reset{
    [self addChild:_tapToStart];
    
    _playing = NO;
    _score = 0;
    _time = 0;
    _blocks = [[NSMutableArray alloc] init];
    }


/*
 Method that takes care of all resume game procedures.
 Fades out the pause button, fades in the resume button.
 Also fades in dark background.
 */
-(void)pauseGame{
    [self fadeOut:_pauseButton];
    [self fadeIn:_resumeButton];
    [self fadeIn:_background];
    [self fadeIn:_menuButton];
    _pause = true;
}

/*
 Method that resumes the game.  Fades out the resume button
 and fades back in the pause button.  Removes the background
 black tint.
 */
-(void)resumeGame{
    [self fadeOut:_resumeButton];
    [self fadeIn:_pauseButton];
    [self fadeOut:_background];
    [self fadeOut:_menuButton];
    _pause = false;
}

/*
 Utility method that "blows" up sprte sent to it then removes.
 Also removes node from scene, with safety check that garentees
 it does not currently have a parent.
 @param SKSpriteNode node: node to be faded in to scene
 @return: none
 */
-(void)blowUp:(SKSpriteNode*)node{
    SKAction *expand = [SKAction resizeByWidth:3*node.size.width height:3*node.size.height duration:0.2];
    SKAction *fadeOut = [SKAction fadeOutWithDuration:0.15];
    SKAction *remove = [SKAction removeFromParent];
    if([node parent] != NULL)
        [node runAction:[SKAction sequence:@[expand,fadeOut,remove]]];
}



/*
 Utility method that fades in the sprite node sent to it.
 Also adds node to current scene, but only if the spritenode
 does not currenlty have a parent (safety check)
 @param SKSpriteNode node: node to be faded in to scene
 @return: none
 */
-(void)fadeIn:(SKSpriteNode*)node{
    if([node parent]==NULL)
        [self addChild:node];
    node.alpha = 0.0;
    SKAction *fadeIn = [SKAction fadeInWithDuration:0.14];
    [node runAction:[SKAction sequence:@[fadeIn]]];
}

/*
 Utility method that fades out sprites then removes the sprite
 if it has a parent.  Error checking in place so sprites without
 parents will not be removed.
 @param SKSpriteNode node: node to be faded out and removed
 @return: none
 */
-(void)fadeOut:(SKSpriteNode*)node{
    SKAction *fadeOut = [SKAction fadeOutWithDuration:0.14];
    SKAction *remove = [SKAction removeFromParent];
    if([node parent] != NULL)
        [node runAction:[SKAction sequence:@[fadeOut,remove]]];
}

/*
 Method that contains game over procedure.  Explodes all blocks and
 resets blocksprite.
 @param: none
 @return: none
 */
-(void)gameOver{
    for(int i=0;i<_blocks.count;i++){
        Block *tempBlock = _blocks[i];
        SKSpriteNode *nTemp = tempBlock.blockSprite;
        [self blowUp:nTemp];
    }
    
    
    int highScoreTemp = (int)[[NSUserDefaults standardUserDefaults] integerForKey:@"HighScore"];
    if(highScoreTemp<1){
        highScoreTemp = 0;
    }
    _highScore = highScoreTemp;
    if(_score>highScoreTemp){
        [[NSUserDefaults standardUserDefaults] setInteger:_score forKey:@"HighScore"];
        _highScore = _score;
    }
    [self reset];
}



/*
 Method that sprite kit calls to update game 60 times a second.
 Contains all update procedures nessesary, as well as collision
 checking.
 @param CFTimeInterval current time: Current time.  System calls
 so no need to ever call this method.
 @return: none
 */
-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
    if(_playing && !_pause){
        _time++;
        
        int x = _time/1400+1;
        if(x>10){
            x=10;
        }
        BOOL createone = false;

        if(arc4random()%20==0){
            createone=true;
        }
        
        if(createone){
            Block *blockTemp = [[Block alloc] initWithScreenSize:self.size];
            [_blocks addObject:blockTemp];
            [self addChild:blockTemp.blockSprite];
            NSLog(@"Adding block to scene");
            NSLog(@"blocksize: %i",_blocks.count);
        }

        for(int i=0;i<_blocks.count;i++){
            Block *tempBlock = _blocks[i];
            if(tempBlock.blockSprite.position.y<self.size.height/3)
                if([_player intersectsNode:tempBlock.blockSprite]){

                        [self gameOver];
                    
                }
            [tempBlock update];
            if(tempBlock.blockSprite.position.y<-100){NSLog(@"removing block");
                [tempBlock.blockSprite removeFromParent];
                [_blocks removeObject:tempBlock];
                _score++;
                _scoreLabel.text = [NSString stringWithFormat:@"%i",(int)_score];

                
            }
        }

        
    }
}

@end
