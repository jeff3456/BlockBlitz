
public class Bullet 
{
	int xPos;
	int yPos;
	int ySpeed = 7;
	static int size = 4;
	boolean active;
	static int numActive = 0;
	static int numKilled = 0;
	
	public Bullet(int x, int y)
	{
		
		xPos = x;
		yPos = y;
		active = true;
		numActive++;
		
	}
	public void move()
	{
		if(active)
			{
			yPos -= ySpeed;
			
			}
	}
	public boolean checkHit( int length, int y, int x)
	{
		if( y + length > yPos && x + length > xPos && yPos + 4 > y && xPos + 4 > x && active)
		{
			active = false;
			numActive--;
			numKilled++;
			return true;
		}
		return false;
	}
	
	public void reset()
	{
		if (yPos < 0)
		{
			active = false;
			numActive --;
		}
	}
	
}
