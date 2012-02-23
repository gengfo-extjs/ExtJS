import java.applet.*;
import java.awt.*;

public class JavaApplet extends Applet
{
  private String _s = "Welcome!";
  
  public void paint(Graphics g) {
    g.setColor(Color.black);
    g.drawString(_s, 20, 20);
  }
  
  public void setString(String s) {
    this._s = s;
    this.repaint();
  }
}
