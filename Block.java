public class Blocks 
{
	int r;
	int g;
	int b;
	double xpos;
	double ypos;
	double speed;
	int size;
	static int score = 0;
	public Blocks()
	{
		
		this.speed = (Math.random() * 5 + 1);
		this.xpos = Math.random();
		this.ypos = 0;
		if (this.speed > 4.5)
		{
			this.r = 255;
			this.g = 0;
			this.b = 0;
			this.size = 10;
		}
		else if(this.speed > 2.5)
		{
			this.r = 0;
			this.g = 255;
			this.b = 0;
			this.size = 20;
		}
		else
		{
			this.r = 0;
			this.g = 0;
			this.b = 255;
			this.size = 35;
		}
	}
	public void move()
	{
		this.ypos += this.speed;
	}
	public void resetBlock(int endOfScreen)
	{
		if(this.ypos > endOfScreen)
		{
			this.ypos = 0;
			this.xpos = Math.random();
			this.speed = (Math.random() * 7.5 + 1);
			this.score++;
			
			if (this.speed > 4.5)
			{
				this.r = 255;
				this.g = 0;
				this.b = 0;
				this.size = 10;

			}
			else if(this.speed > 2.5)
			{
				this.r = 0;
				this.g = 255;
				this.b = 0;
				this.size = 20;

			}
			else
			{
				this.r = 0;
				this.g = 0;
				this.b = 255;
				this.size = 35;
			}
		}
	}
}
