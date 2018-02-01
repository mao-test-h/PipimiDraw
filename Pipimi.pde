class Pipimi
{
  // ===========================================================
  // Private Memvers

  // 位置
  PVector location;

  // 両目
  Eye eyes[] = new Eye[2];

  // 髪
  Hair hair;


  // ===========================================================
  // Functions

  // コンストラクタ
  Pipimi(PVector location_)
  {
    location = location_.get();
  }


  // 表示
  void display()
  {
    // 目のインスタンス化
    for(int i = 0; i < eyes.length; ++i)
    {
      float ipd = 60 * ((i == 0) ? -1 : 1); // 瞳孔間距離
      PVector EyePos = new PVector(0 + ipd, -70);
      PVector EyeSize = new PVector(0.45, 0.4);
      eyes[i] = new Eye(EyePos, EyeSize, (i == 0));
    }

    // 髪のインスタンス化
    PVector HairPos = new PVector(0, 73);
    PVector HairSize = new PVector(0.95, 1.0);
    hair = new Hair(HairPos, HairSize);


    pushMatrix();
    translate(location.x, location.y);

    // 髪の先行描画
    hair.preDisplay();

    // 輪郭の描画
    drawContour();

    // 髪の描画
    hair.display();


    for(int i = 0; i < 2; ++i)
    {
      int sign = ((i == 0) ? -1 : 1);

      // 口の描画
      drawMouth(sign);

      // 眉の描画
      drawEyebrows(sign);

      // 目の描画
      eyes[i].display();
    }

    popMatrix();
  }


  // ===========================================================
  // Private Functions

  // 眉の描画
  void drawEyebrows(int sign)
  {
    noFill();
    strokeWeight(StrokeWeight);
    stroke(0);
    strokeCap(SQUARE);

    PVector Eyebrows_Position = new PVector(60, -120);
    pushMatrix();
    translate((Eyebrows_Position.x * sign), Eyebrows_Position.y);

    PVector EyebrowsParts_Position = new PVector(0, 0);
    PVector EyebrowsParts_Size = new PVector(65, 40);
    float ArcStart = -160;  // 円弧の開始する角度(deg)
    float ArcEnd = -20; // 円弧の停止する角度(deg)
    arc(
        EyebrowsParts_Position.x, EyebrowsParts_Position.y,
        EyebrowsParts_Size.x, EyebrowsParts_Size.y,
        radians(ArcStart),
        radians(ArcEnd));

    popMatrix();
  }


  // 口の描画
  void drawMouth(int sign)
  {
    noFill();
    strokeWeight(StrokeWeight);
    stroke(0);
    strokeCap(SQUARE);

    PVector Mouth_Position = new PVector(10 * sign, -1);
    float Mouth_Angle = -14 * sign;  // 回転角度(deg)
    pushMatrix();
    translate(Mouth_Position.x, Mouth_Position.y);
    rotate(radians(Mouth_Angle));

    PVector MouthParts_Position = new PVector(0, 0);
    PVector MouthParts_Size = new PVector(26, 48);
    float ArcStart = 18;  // 円弧の開始する角度(deg)
    float ArcEnd = 160; // 円弧の停止する角度(deg)
    arc(
        MouthParts_Position.x, MouthParts_Position.y,
        MouthParts_Size.x, MouthParts_Size.y,
        radians(ArcStart),
        radians(ArcEnd));

    popMatrix();
  }


  // 輪郭の描画
  void drawContour()
  {
    strokeWeight(StrokeWeight);
    stroke(0);
    fill(SkinColor);

    // 輪郭
    PVector Contour_Position = new PVector(0, 0);
    PVector Contour_Size = new PVector(292, 470);
    ellipse(Contour_Position.x, Contour_Position.y, Contour_Size.x, Contour_Size.y);

    // 両耳
    PVector Ear_Position = new PVector(150, -15);
    PVector Ear_Size = new PVector(35, 75);
    for(int i = 0; i < 2; ++i)
    {
      int sign = (i == 0) ? -1 : 1;
      ellipse(Ear_Position.x * sign, Ear_Position.y, Ear_Size.x, Ear_Size.y);
    }
  }
}