// Visualization using Perlin noise.
// Modified from http://www.openprocessing.org/sketch/1275 by Ryan Govostes and Jim Bumgardner
// Custom1: Perlin noise level; Custom2: Zoom in/out

class AlienBlob extends Drawer {
  float xoff = 0, yoff = 0, zoff = 0;
  float sineTable[];
  float dThresh, incr, xoffIncr, yoffIncr, zoffIncr, noiseMult;
  
  AlienBlob(Pixels p, Settings s) {
    super(p, s, JAVA2D, DrawType.MirrorSides);
    
    // precalculate 1 period of the sine wave (360 degrees)
    sineTable = new float[360];
    for (int i = 0; i < 360; i ++) sineTable[i] = sin(radians(i));
  }
  
  String getName() { return "AlienBlob"; }
  String getCustom1Label() { return "Noise Detail";}
  String getCustom2Label() { return "Multiplier";}
  
  
  void setup() {
    dThresh = 90;
    incr = 0.03125;
    xoffIncr = 0.003; //0.3;
    yoffIncr = 0.0007; //0.07;
    zoffIncr = 0.1;
    noiseMult = 5; //3
    
    settings.setParam(settings.keyBrightness, 0.5); // set brightness to 50%
  }
  
  void reset() {
    zoff = 0;
  }
  
  void draw() {
    float d, h, s, b, n;
    float xx;
    float yy = 0;
    int w2 = width / 2;
    int h2 = height / 2;
    int offset = 0;
    
    int nd = ceil(10.0 * settings.getParam(settings.keyCustom1));
    float multiplier = settings.getParam(settings.keyCustom2) * 10;
    noiseDetail(nd);
    pg.loadPixels();
    
    for (int y = 0; y < height; y++) {
      xx = 0;
      for (int x = 0; x < width; x++) {
        d = dist(x, y, w2, h2) * 0.025;
        if (d * 20 <= dThresh) {
          n = noise(xx*multiplier, yy*multiplier, zoff); // noise only needs to be computed once per pixel
          
          // use pre-calculated sine results
          h = 1 - sineTable[int(degrees(d + n * noiseMult)) % 360];// % 2;
          
          // determine pixel color
          pg.pixels[offset++] = getColor(int(h/2.0*(getNumColors()-1)));
        } else {
          pg.pixels[offset++] = getColor(0);
        }
        
        xx += incr;
      }
      
      yy += incr;
    }
    
    zoff += zoffIncr * settings.speedWithAudioSpeed();
    
    pg.updatePixels();
  }
}
