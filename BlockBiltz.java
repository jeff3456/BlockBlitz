import processing.core.PApplet;
public class Dot extends PApplet
{
	// how to make the white block move with arrow keys
	// how to change up the movement of the red blocks
	// how to add michaels face to the flappy bird
	// how to add sounds to my game
	int numBlocks = 1;
	Blocks [] a = new Blocks[150];
	boolean gameOver = false;
	long startTime =  System.currentTimeMillis();
	int timeElasped;
	int previousTime = 0;


	public void setup()
	{
		size(500,1000);
		for(int i = 0; i < 150; i++)
		{
			a[i] = new Blocks();
		}
		
	}
	
	public void draw()
	{
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
		if( (timeElasped != previousTime))
		{
			numBlocks++;
			previousTime = timeElasped;
		}

		for(int i = 0; i < numBlocks; i++)
		{
			int xPos = (int)(a[i].xpos * 500);
			int yPos = (int)(a[i].ypos);
			fill(a[i].r, a[i].g , a[i].b);
			rect(xPos, yPos, a[i].size, a[i].size);
			a[i].move();
			a[i].resetBlock(1000);
			if((mouseX <= xPos +  a[i].size && mouseX >= xPos - 10) && (mouseY <= yPos + a[i].size && mouseY >= yPos - 10))
			{
				gameOver = true;
			}
		}
		
		if(gameOver)
		{
			timeElasped = (int) (System.currentTimeMillis() / 1000 - startTime / 1000);
			println("your survived " + timeElasped + " seconds");
			println("you dodged " + Blocks.score + " blocks");
		}
	}
}
