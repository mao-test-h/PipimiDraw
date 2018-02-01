class Hair
{
  // ===========================================================

  // 髪の色
  color HairColor = color(78, 75, 140);

  // リボンの色
  color RibbonColor = color(205, 92, 48);


  // ===========================================================
  // Private Memvers

  // 位置
  PVector location;

  // サイズ
  PVector localScale;


  // ===========================================================
  // Functions

  // コンストラクタ
  Hair(PVector location_, PVector scale_)
  {
    location = location_.get();
    localScale = scale_.get();
  }


  // 表示
  void display()
  {
    pushMatrix();
    translate(location.x, location.y);
    scale(localScale.x, localScale.y);

    // リボンの描画
    drawRibbon();

    // サイドヘアーの塗りつぶし描画
    drawSideHairFill();
    // サイドヘアーのアウトライン描画
    drawSideHairOutline();

    // 前髪の塗りつぶし描画
    drawBangsFill();
    // 前髪のアウトライン描画
    drawBangsOutline();

    // 頭頂部付近のアウトライン描画
    drawHeadOutline();

    popMatrix();
  }


  // 先行表示処理
  void preDisplay()
  {    
    pushMatrix();
    translate(location.x, location.y);
    scale(localScale.x, localScale.y);

    // 後ろ髪の描画
    drawBackhair();

    popMatrix();
  }


  // ===========================================================
  // Private Functions

  // リボンの描画
  void drawRibbon()
  {
    fill(RibbonColor);  
    strokeWeight(StrokeWeight);

    // 両サイド
    for (int i = 0; i < 2; ++i)
    {
      int sign = (i == 0) ? -1 : 1;
      PVector BothSides_BeginningControlPoint = new PVector(-127 * sign, -190);
      PVector BothSides_FirstPoint = new PVector(5 * sign, -310);
      PVector BothSides_SecondPoint = new PVector(90 * sign, -280);  // lineの後者と同一
      PVector BothSides_EndingControlPoint = new PVector(-30 * sign, 495);
      curve(
          BothSides_BeginningControlPoint.x, BothSides_BeginningControlPoint.y, 
          BothSides_FirstPoint.x, BothSides_FirstPoint.y, 
          BothSides_SecondPoint.x, BothSides_SecondPoint.y, 
          BothSides_EndingControlPoint.x, BothSides_EndingControlPoint.y); 

      // しわ
      PVector Wrinkle_Position = new PVector(35 * sign, -300);
      PVector Wrinkle_Size = new PVector(60 * sign, -310);
      line(Wrinkle_Position.x, Wrinkle_Position.y, Wrinkle_Size.x, Wrinkle_Size.y);
    }

    // 中央部分
    PVector Center_Position = new PVector(-25, -325);
    PVector Center_Size = new PVector(50, 30);
    float radius = 30;
    rect(Center_Position.x, Center_Position.y,Center_Size.x, Center_Size.y, radius, radius, radius, radius);
  }


  // サイドヘアーの塗りつぶし描画
  void drawSideHairFill()
  {
    float ArcStrokeWeight = 35;
    noFill();
    stroke(HairColor);
    strokeWeight(ArcStrokeWeight);
    strokeCap(SQUARE);

    PVector FillArcPosition = new PVector(-62, -65);
    PVector FillArcSize = new PVector(160, 680);
    float FillArcStart = 125;  // 円弧の開始する角度(deg)
    float FillArcEnd = 201; // 円弧の停止する角度(deg)
    for (int i = 0; i < 2; ++i)
    {
      int sign = (i == 0) ? -1 : 1;
      pushMatrix();
      // もう片方はScaleを反転させて描画
      scale(sign, 1);
      // arcのアウトラインを塗りつぶし部として適用
      arc(
          FillArcPosition.x, FillArcPosition.y,
          FillArcSize.x, FillArcSize.y,
          radians(FillArcStart),
          radians(FillArcEnd));     
      popMatrix();
    }
  }


  // サイドヘアーのアウトライン描画
  void drawSideHairOutline()
  {
    noFill();
    stroke(0);
    strokeWeight(StrokeWeight);

    for (int i = 0; i < 2; ++i)
    {
      int sign = (i == 0) ? -1 : 1;

      // 内側
      PVector Inside_BeginningControlPoint = new PVector(10 * sign, -600);
      PVector Inside_FirstPoint = new PVector(120 * sign, -185);
      PVector Inside_SecondPoint = new PVector(91 * sign, 207);  // 下端(line)の終了点
      PVector Inside_EndingControlPoint = new PVector(-50 * sign, 390);
      curve(
          Inside_BeginningControlPoint.x, Inside_BeginningControlPoint.y, 
          Inside_FirstPoint.x, Inside_FirstPoint.y, 
          Inside_SecondPoint.x, Inside_SecondPoint.y, 
          Inside_EndingControlPoint.x, Inside_EndingControlPoint.y); 

      // 外側
      PVector Outside_BeginningControlPoint = new PVector(25 * sign, -750);
      PVector Outside_FirstPoint = new PVector(155 * sign, -185);
      PVector Outside_SecondPoint = new PVector(125 * sign, 218);  // 下端(line)の開始点
      PVector Outside_EndingControlPoint = new PVector(10 * sign, 130);
      curve(
          Outside_BeginningControlPoint.x, Outside_BeginningControlPoint.y, 
          Outside_FirstPoint.x, Outside_FirstPoint.y, 
          Outside_SecondPoint.x, Outside_SecondPoint.y, 
          Outside_EndingControlPoint.x, Outside_EndingControlPoint.y);

      // 下端
      line(Outside_SecondPoint.x, Outside_SecondPoint.y, Inside_SecondPoint.x, Inside_SecondPoint.y);
    }   
  }


  // 前髪の塗りつぶし描画
  void drawBangsFill()
  {
    // 前髪中央部分の塗りつぶし
    fill(HairColor);
    noStroke();
    PVector Center_Position = new PVector(-60, -290);
    PVector Center_Size = new PVector(120, 40);
    rect(Center_Position.x, Center_Position.y, Center_Size.x, Center_Size.y);

    // 前髪両サイドの塗りつぶし
    float BothSides_ArcStrokeWeight = 26;
    PVector BothSides_ArcPosition = new PVector(-85, -185);
    PVector BothSides_ArcSize = new PVector(110, 33);
    float BothSides_ArcStart = 205;  // 円弧の開始する角度(deg)
    float BothSides_ArcEnd = 265; // 円弧の停止する角度(deg)
    noFill();
    stroke(HairColor);
    strokeWeight(BothSides_ArcStrokeWeight);
    strokeCap(SQUARE);
    for (int i = 0; i < 2; ++i)
    {
      int sign = (i == 0) ? -1 : 1;
      pushMatrix();
      // もう片方はScaleを反転させて描画
      scale(sign, 1);
      arc(
          BothSides_ArcPosition.x, BothSides_ArcPosition.y,
          BothSides_ArcSize.x, BothSides_ArcSize.y,
          radians(BothSides_ArcStart),
          radians(BothSides_ArcEnd));     
      popMatrix();
    }

    // 前髪上部の塗りつぶし補完
    float Top_ArcStrokeWeight = 35;
    PVector Top_ArcPosition = new PVector(0, -150);
    stroke(HairColor);
    noFill();
    strokeWeight(Top_ArcStrokeWeight);
    strokeCap(SQUARE);

    // 前髪上部(上段)
    PVector TopOne_ArcSize = new PVector(280, 280);
    float TopOne_ArcStart = 194;  // 円弧の開始する角度(deg)
    float TopOne_ArcEnd = 346; // 円弧の停止する角度(deg)
    arc(
        Top_ArcPosition.x, Top_ArcPosition.y,
        TopOne_ArcSize.x, TopOne_ArcSize.y,
        radians(TopOne_ArcStart),
        radians(TopOne_ArcEnd));

    // 前髪上部(下段)
    PVector TopTwo_ArcSize = new PVector(210, 270);
    float TopTwo_ArcStart = 199;  // 円弧の開始する角度(deg)
    float TopTwo_ArcEnd = 341; // 円弧の停止する角度(deg)
    arc(
        Top_ArcPosition.x, Top_ArcPosition.y,
        TopTwo_ArcSize.x, TopTwo_ArcSize.y,
        radians(TopTwo_ArcStart),
        radians(TopTwo_ArcEnd));
  }


  // 前髪のアウトライン描画
  void drawBangsOutline()
  {
    strokeWeight(StrokeWeight);

    // 中央の矩形
    // ※こちらのみ塗りつぶしも描画
    fill(HairColor);
    stroke(0);
    float CenterOutline_Top = -250;
    float CenterOutline_Bottom = -190;
    float CenterOutline_Left = -50;
    float CenterOutline_Right = 50;
    beginShape();
    vertex(CenterOutline_Left, CenterOutline_Top);
    vertex(CenterOutline_Left, CenterOutline_Bottom);
    vertex(CenterOutline_Right, CenterOutline_Bottom);
    vertex(CenterOutline_Right, CenterOutline_Top);
    endShape();

    // アウトライン
    noFill();
    for(int j = 0; j < 2; ++j)
    {
      int sign = (j == 0) ? -1 : 1;

      // 内側
      PVector Inside_BeginningControlPoint = new PVector(50 * sign, -240);
      PVector Inside_FirstPoint = new PVector(50 * sign, -250);
      PVector Inside_SecondPoint = new PVector(85 * sign, -190);
      PVector Inside_EndingControlPoint = new PVector(50 * sign, -190);
      curve(
          Inside_BeginningControlPoint.x, Inside_BeginningControlPoint.y, 
          Inside_FirstPoint.x,Inside_FirstPoint.y, 
          Inside_SecondPoint.x, Inside_SecondPoint.y, 
          Inside_EndingControlPoint.x, Inside_EndingControlPoint.y);

      // 外側
      PVector Outside_BeginningControlPoint = new PVector(20 * sign, -180);
      PVector Outside_FirstPoint = new PVector(85 * sign, -190);
      PVector Outside_SecondPoint = new PVector(130 * sign, -180);
      PVector Outside_EndingControlPoint = new PVector(90 * sign, -180);
      curve(
          Outside_BeginningControlPoint.x, Outside_BeginningControlPoint.y, 
          Outside_FirstPoint.x,Outside_FirstPoint.y, 
          Outside_SecondPoint.x, Outside_SecondPoint.y, 
          Outside_EndingControlPoint.x, Outside_EndingControlPoint.y);
    }
  }


  // 頭頂部付近のアウトライン描画
  void drawHeadOutline()
  {
    strokeWeight(StrokeWeight);

    PVector BeginningControlPoint = new PVector(-135, 800);
    PVector FirstPoint = new PVector(-155, -184);
    PVector SecondPoint = new PVector(155, -184);
    PVector EndingControlPoint = new PVector(135, 800);
    curve(
        BeginningControlPoint.x, BeginningControlPoint.y, 
        FirstPoint.x, FirstPoint.y, 
        SecondPoint.x, SecondPoint.y, 
        EndingControlPoint.x, EndingControlPoint.y);
  }


  // 後ろ髪の描画
  void drawBackhair()
  {
    strokeWeight(StrokeWeight);
    fill(HairColor);

    PVector LeftTop_Position = new PVector(-145, 35);
    PVector LeftBottom_Position = new PVector(-150, 255);
    PVector RightBottom_Position = new PVector(150, 255);
    PVector RightTop_Position = new PVector(145, 35);
    quad(
        LeftTop_Position.x, LeftTop_Position.y,
        LeftBottom_Position.x, LeftBottom_Position.y,
        RightBottom_Position.x, RightBottom_Position.y,
        RightTop_Position.x, RightTop_Position.y);
  }

}
