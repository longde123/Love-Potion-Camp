class CircularPong extends Drawer {
  private static final float HALF_PADDLE_SPAN = (float) (Math.PI / 6.0 / 2.0);
  private static final float PADDLE_STROKE_WIDTH = 3.0f;
  private static final float BALL_RADIUS = 2.0f;

  private float rollAngle;
  private int buttons;
  private int releasedButtons;

  private final int centerX = width/2;
  private final int centerY = (int) (height * 0.55);
  private final int diameter = (int)(Math.min(width, height) * 0.65);

  // Ball State

  CircularPong(Pixels p, Settings s) {
    super(p, s, JAVA2D, DrawType.RepeatingSides);
  }

  String getName() {
    return "Circular Pong";
  }

  void wiimoteAccel(float x, float y, float z, float pitch, float roll, float tilt) {
    this.rollAngle = (float) (-(roll + Math.PI));
  }

  void wiimoteButtons(int buttons) {
    this.releasedButtons = this.buttons & ~buttons;
    this.buttons = buttons;
  }

  void draw() {
    pg.background(0);
    pg.strokeWeight(PADDLE_STROKE_WIDTH);
    pg.stroke(255);
    pg.noFill();
    pg.arc(centerX, centerY, diameter, diameter, rollAngle - HALF_PADDLE_SPAN, rollAngle + HALF_PADDLE_SPAN);

    pg.fill(255);
    pg.ellipse(centerX, centerY, BALL_RADIUS, BALL_RADIUS);
  }
}
