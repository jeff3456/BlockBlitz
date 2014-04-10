
public class Blocks 
{
	int colora;
	int colorb;
	int colorc;
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
			this.colora = 255;
			this.colorb = 0;
			this.colorc = 0;
			this.size = 10;
		}
		else if(this.speed > 2.5)
		{
			this.colora = 0;
			this.colorb = 255;
			this.colorc = 0;
			this.size = 20;
		}
		else
		{
			this.colora = 0;
			this.colorb = 0;
			this.colorc = 255;
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
				this.colora = 255;
				this.colorb = 0;
				this.colorc = 0;
				this.size = 10;

			}
			else if(this.speed > 2.5)
			{
				this.colora = 0;
				this.colorb = 255;
				this.colorc = 0;
				this.size = 20;

			}
			else
			{
				this.colora = 0;
				this.colorb = 0;
				this.colorc = 255;
				this.size = 35;
			}
		}
	}
}
