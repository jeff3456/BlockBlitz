import processing.core.PApplet;
public class BlockBlitz extends PApplet
{
	int numBlocks = 1;
	Blocks [] a = new Blocks[300];
	boolean gameOver = false;
	long startTime =  System.currentTimeMillis();
	int timeElasped;
	int previousTime = 0;


	public void setup()
	{
		size(500,1000);
		for(int i = 0; i < 300; i++)
		{
			a[i] = new Blocks(this);
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
		if(timeElasped != previousTime)
		{
			numBlocks++;
			previousTime = timeElasped;
		}
		
		
		for(int i = 0; i < numBlocks; i++)
		{
			int xPos = (int)(a[i].xpos * 500);
			if(xPos > (500 - a[i].size))
			{
				xPos = xPos - a[i].size;
			}
			int yPos = (int)(a[i].ypos);
			fill(a[i].colora, a[i].colorb , a[i].colorc);
			rect(xPos, yPos, a[i].size, a[i].size);
			a[i].move();
			a[i].resetBlock(1000, this);
			if((mouseX <= xPos +  a[i].size && mouseX >= xPos - 10) && (mouseY <= yPos + a[i].size && mouseY >= yPos - 10))
			{
				gameOver = true;
			}
		}
		
		if(gameOver)
		{
			timeElasped = (int) (System.currentTimeMillis() / 1000 - startTime / 1000);
			println("you survived " + timeElasped + " seconds");
			println("you died on level " + numBlocks);
			println("you dodged " + Blocks.score + " blocks");
		}
	}
	public void keyPressed()
	{
		numBlocks++;
	}
}
