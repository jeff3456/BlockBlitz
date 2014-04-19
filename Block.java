import processing.core.PApplet;


public class Blocks extends PApplet
{
	int colora;
	int colorb;
	int colorc;
	double xpos;
	double ypos;
	double speed;
	int size;
	boolean alive = true;
	static int score = 0;
	int hp;
	public Blocks(PApplet canvas)
	{
		
		this.speed = (Math.random() * 6.5 + 1);
		this.xpos = random(0,500);
		this.ypos = 0;
		if (this.speed > 5)
		{
			this.colora = 255;
			this.colorb = 0;
			this.colorc = 0;
			this.size = 10;
			this.hp  = 1;
		}
		else if(this.speed > 3)
		{
			this.colora = 0;
			this.colorb = 255;
			this.colorc = 0;
			this.size = 20;
			this.hp = 3;
		}
		else if(this.speed > 1.1)
		{
			this.colora = 0;
			this.colorb = 0;
			this.colorc = 255;
			this.size = 35;
			this.hp = 5;
		}
		else
		{
			this.colora = 255;
			this.colorb = 0;
			this.colorc = 255;
			this. size = 100;
			this.hp = 15;
		}
	}
	public void move()
	{
		this.ypos += this.speed;
	}
	public void hitByBullet(Bullet a)
	{
		if (a.checkHit(this.size, (int) this.ypos, (int) this.xpos))
		{
			hp--;
			if(hp <= 0)
			{
				alive = false;
			}
		}
	}
	public void resetBlock(int endOfScreen, PApplet canvas)
	{
		if(this.ypos > endOfScreen)
		{
			this.ypos = 0;
			this.xpos = random(0,500);
			this.speed = (Math.random() * 6.5 + 1);
			this.score++;
			
			if (this.speed > 5)
			{
				this.colora = 255;
				this.colorb = 0;
				this.colorc = 0;
				this.size = 10;
				this.hp = 1;

			}
			else if(this.speed > 3)
			{
				this.colora = 0;
				this.colorb = 255;
				this.colorc = 0;
				this.size = 20;
				this.hp = 3;
			}
			else if(this.speed > 1.1)
			{
				this.colora = 0;
				this.colorb = 0;
				this.colorc = 255;
				this.size = 35;
				this.hp = 5;
			}
			else
			{
				this.colora = 255;
				this.colorb = 0;
				this.colorc = 255;
				this. size = 100;
				this.hp = 15;
			}
		}
	}
}
