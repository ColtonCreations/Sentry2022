
/**************************************************************************************************
 ********************  START  GAME STAGE/ GAME PLAY FUNCTIONS  ***********************************
 *************************************************************************************************/

/***************** SAVED PLANET - WINNING CONDITION *************/
void savedPlanet() { // fix - get matrix gif anim
  if (memAccess == false) { // memaccess true is the condition that wins the game
    return;
  }
  if (memAccess == true) {
    pauseAll();
    engage();
    background(planet);
    noStroke();
    translate(width/2.0, height/2.0, -100);
    kinect.update();
    PImage rgbImage = kinect.rgbImage(); 
    translate(width/4, height/5, +150);
    rotateX(radians(180));
    translate(0, 0, 1000);
    rotateY(radians(rotation));
    rotation++;
    stroke(255);

    PVector[] depthPoints = kinect.depthMapRealWorld();
    // don't skip any depth points
    for (int i = 0; i < depthPoints.length; i+=1) {
      PVector currentPoint = depthPoints[i];
      // set the stroke color based on the color pixel
      stroke(rgbImage.pixels[i]);
      // have each hotpoint check to see
      // if it includes the currentPoint
      pipeT.check(currentPoint);
      point(currentPoint.x, currentPoint.y, currentPoint.z);
    }
    println(pipeT.pointsIncluded);

    if (pipeT.isHit()) {
      pipe.play();
      reset();
      memAccess = false;
    }  
    if (!pipe.isPlaying()) {
      pipe.rewind();
      pipe.pause();
    }
    pipeT.draw();
    pipeT.clear();
  }
}

/* MarkVI addition insert endTime reset (resetTimer();)function just in front of gameOver(); 
 so it's reset right before it's actually used */
void resetTimer() {
  if (alive == false) {
     startTime = millis() + timer;
    // set reference time and bail
    println("startTime", startTime);
    // increment mode to 1 to go to gameOver();
    mode = 1;
    println("mode =", mode);
    return;
  } else if (sane == false) {
   startTime = millis() + madtimer;
    // set reference time and bail
    println("startTime", startTime);
    // increment mode to 1 to go to goneMad();
    madmode = 1; 
    println("madmode = ", madmode);
    return;
  }
}


void goneMad() {
  endTime = millis();
  println("endTime", endTime);
  /* displays scrolling "Quest Failed" text for about two loop thrus 
   then increments changes catatonic to true for gameOverDead()
   that allows manual reset of game with pipe trigger hotpoint */
  if (madmode == 1) {
    pauseAll();
    if (!engage.isPlaying()) {
      engage.rewind();
      engage.play();
    }
       background(standby);
     // animationTe.display(xxpos, yypos);
      fill(0);
      textFont(font, 16);
      textAlign(LEFT);
      textSize(128);
      fill(#00FF00);  // green
      text(madman[ind], x, 640);
      x = x - 9; // speed of scrolling
      float w = textWidth(madman[ind]);
      if (x < -w) {
        x = width;
        ind = (ind + 1) % madman.length;
      }
    }
    // break conditions once timer expires
    if (startTime < endTime) {
      madmode = 2;
      if (madmode == 2) {
        cleanScreen();
        return;
      }
    }
  }


void gameOver() {
  endTime = millis();
  println("endTime", endTime);
  /* displays scrolling "Quest Failed" text for about two loop thrus (29.5 sec)
   then increments mode tri-state from 1 to 2 to go to next gameover screen stage
   that allows manual reset of game with pipe trigger hotpoint */
  if (mode == 1) {
    pauseAll();
    if (!engage.isPlaying()) {
      engage.rewind();
      engage.play();
    }
     background(standby);
  // animationTe.display(xxpos, yypos);
    fill(0);
    textFont(font, 16);
    textAlign(LEFT);
    textSize(128);
    fill(#00FF00);  // green
    text(headlines[index], x, 640);
    x = x - 9; // speed of scrolling // dfault x = x - 9;
    float w = textWidth(headlines[index]);
    if (x < -w) {
      x = width;
      index = (index + 1) % headlines.length;
    }
  }
   // break conditions once timer expires
  if (startTime < endTime) {
    mode = 2;
    if (mode == 2) {
      cleanScreen();
      return;
    }
  }
}

void gameOverMad(){
   if (sane == true) {
    cleanScreen();
    return;
  }
  pauseAll();
  engage();
  background(standby);
  noStroke();
  translate(width/2.0, height/2.0, -100);
  kinect.update();
  PImage rgbImage = kinect.rgbImage(); 
  translate(width/4, height/5, +150);
  rotateX(radians(180));
  translate(0, 0, 1000);
  rotateY(radians(rotation));
  rotation++;
  stroke(255);

  PVector[] depthPoints = kinect.depthMapRealWorld();
  // don't skip any depth points
  for (int i = 0; i < depthPoints.length; i+=1) {
    PVector currentPoint = depthPoints[i];
    // set the stroke color based on the color pixel
    stroke(rgbImage.pixels[i]);
    // have each hotpoint check to see
    // if it includes the currentPoint
    pipeT.check(currentPoint);
    point(currentPoint.x, currentPoint.y, currentPoint.z);
  }
  println(pipeT.pointsIncluded);
  if (pipeT.isHit()) {
    pipe.play();
    reset();
  }  
  if (!pipe.isPlaying()) {
    pipe.rewind();
    pipe.pause();
  }
  pipeT.draw();
  pipeT.clear();
}

void gameOverDead() {
  if (alive == true) {
    cleanScreen();
    return;
  }
  pauseAll();
  engage();
  background(standby);
  noStroke();
  translate(width/2.0, height/2.0, -100);
  kinect.update();
  PImage rgbImage = kinect.rgbImage(); 
  translate(width/4, height/5, +150);
  rotateX(radians(180));
  translate(0, 0, 1000);
  rotateY(radians(rotation));
  rotation++;
  stroke(255);

  PVector[] depthPoints = kinect.depthMapRealWorld();
  // don't skip any depth points
  for (int i = 0; i < depthPoints.length; i+=1) {
    PVector currentPoint = depthPoints[i];
    // set the stroke color based on the color pixel
    stroke(rgbImage.pixels[i]);
    // have each hotpoint check to see
    // if it includes the currentPoint
    pipeT.check(currentPoint);
    point(currentPoint.x, currentPoint.y, currentPoint.z);
  }
  println(pipeT.pointsIncluded);
  if (pipeT.isHit()) {
    pipe.play();
    reset();
  }  
  if (!pipe.isPlaying()) {
    pipe.rewind();
    pipe.pause();
  }
  pipeT.draw();
  pipeT.clear();
}

/**************************************************************************************************
 ********************  END GAME STAGE/ GAME PLAY FUNCTIONS  ***********************************
 *************************************************************************************************/
