// ===========================================================
// Common Defines

// 肌の色
color SkinColor = color(255, 222, 205);

// アウトラインの太さ
int StrokeWeight = 3;


// ===========================================================

Pipimi pipimi;

void setup()
{
  size(500, 700);
  pipimi = new Pipimi(new PVector(width/2, height/2));
}

void draw()
{
  background(255);
  pipimi.display();
}