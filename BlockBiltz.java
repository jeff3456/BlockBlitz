import ddf.minim.AudioPlayer;
import ddf.minim.Minim;
import processing.core.PApplet;
public class BlockBlitz extends PApplet
{
	int numBlocks = 10;
	Blocks [] a = new Blocks[1000];
	boolean gameOver = false;
	long startTime =  System.currentTimeMillis();
	int timeElasped;
	int previousTime = 0;
	int numBullets = 0;
	Bullet [] bullet = new Bullet[15];
	
	//counter for the bullet position
	int counter = 0;

	// audio framework object
	private Minim minim;
	
	// audio players - we need one for each sound we plan on playing
	private AudioPlayer fireSound;

	public void setup()
	{
		size(500,1000);
		for(int i = 0; i < 1000; i++)
		{
			a[i] = new Blocks(this);
		}
		
		// create a new audio player
		this.minim = new Minim(this);
		
		// load in the sound
		this.fireSound = minim.loadFile("missile.mp3");
		
		for( int i = 0; i < 3; i++)
		{
			bullet[i] = new Bullet(0,0);
			bullet[i].active = false;
		}
	}
	
	public void draw()
	{
		// make sure the gameOver is false so loop of draw() keeps running
		if(!gameOver)
		{
			background(0);
			drawBlocks();
			fill(255,255,255);
			rect(mouseX,mouseY,10,10);
		}
		
	}
	public void drawBlocks()
	{
		timeElasped = (int) (System.currentTimeMillis() / 1000 - startTime / 1000);
		//Spawn block if 1 second has passed
		if(timeElasped != previousTime)
		{
			numBlocks += 3;
			previousTime = timeElasped;
		}
		
		//iterate over Bullets
		for(int i = 0; i < numBullets; i++ )
		{
			// if bullet is active then you can draw it
			if(bullet[i].active)
			{
				fill(255,255,255);
				rect(bullet[i].xPos, bullet[i].yPos, bullet[i].size, bullet[i].size);
				bullet[i].move();
				bullet[i].reset();
			}
		}

		
		//iterate over blocks
		if(timeElasped >= 3)
		{
			for(int i = 0; i < numBlocks; i++)
			{
	
				if(a[i].alive)
				{
					// set xPos of Block
					int xPos = (int) a[i].xpos;
					// set xPos not off the edge of the screen
					if(xPos > (500 - a[i].size))
					{
						xPos = xPos - a[i].size;
					}
					// set yPos of Block
					int yPos = (int)(a[i].ypos);
	
					// color of block is filled in
					fill(a[i].colora, a[i].colorb , a[i].colorc);
					// draw block
					rect(xPos, yPos, a[i].size, a[i].size);
					// move block
					a[i].move();
					a[i].resetBlock(1000, this);
					
					// if a block is hit by a bullet then the block dies
					for(int k = 0; k < numBullets; k++)
					{
						a[i].hitByBullet(bullet[k]);
					}
					
					// game is over if mouse touches a block
	
					if((mouseX <= xPos +  a[i].size && mouseX >= xPos - 10) && (mouseY <= yPos + a[i].size && mouseY >= yPos - 10))
					{
						gameOver = true;
					}
				}
			}
		}
		// if the game is over you print the score and the facts about the round
		if(gameOver)
		{
			timeElasped = (int) (System.currentTimeMillis() / 1000 - startTime / 1000);
			println("you survived " + timeElasped + " seconds");
			println("you dodged " + Blocks.score + " blocks");
		}
	}
	//if key is pressed increase the number of Block by 1
	public void keyPressed()
	{
		numBlocks++;
	}
	
	//if mouse is pressed spawn a new missile
	public void mousePressed()
	{
		this.fireSound.rewind();
		this.fireSound.play();
		bullet[counter++] = new Bullet(mouseX, mouseY);
		if (counter == 15)
		{
			counter = 0;
		}
		if(numBullets != 15)
		{
			numBullets++;
		}
	}
}
