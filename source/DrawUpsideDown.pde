
//fix should this be int return mindcondition to a mindcondition flag handler funct?
void drawTheUpsideDown() {
  enterUpside(); // freeze robot movement with char 'u' SAFETY IMPORTANT
  pauseAll();

  if (firstTimeHere == true) {
    animationMf.display(xxpos, yypos);
    playUpside();
  } else if (firstTimeHere == false) {
    animationMf.display(xxpos, yypos);
    pauseUpside();
    playUpsideLow();
  }
  kinect.update();
  PImage rgbImage = kinect.rgbImage(); 
  translate(width/4, height/5, -500);
  rotateX(radians(180));
  translate(0, 0, 1000);
  rotateY(radians(rotation));
  // rotation++;
  PVector[] depthPoints = kinect.depthMapRealWorld();
  // don't skip any depth points
  for (int i = 0; i < depthPoints.length; i+=3) { 
    PVector currentPoint = depthPoints[i];
    // set the stroke color based on the color pixel
    stroke(rgbImage.pixels[i]);
    // have each hotpoint check to see
    // if it includes the currentPoint
    cbT.check(currentPoint);
    emfT.check(currentPoint);
    radioT.check(currentPoint);
    teleT.check(currentPoint);
    snake1T.check(currentPoint);
    snake2T.check(currentPoint);
    snake3T.check(currentPoint);
    snake4T.check(currentPoint);
    col1T.check(currentPoint);
    col2T.check(currentPoint);
    col3T.check(currentPoint);
    col4T.check(currentPoint);
    point(currentPoint.x, currentPoint.y, currentPoint.z);
  }
  /* memCounter for keeping track of number of unlocked mems (12, tele doesn't count)
   of USD, each respective mem is for unlocking unique clues */
  if (cbT.isHit()) {
    // basic radio freq effect
    // fix could have upgraded sounds for the perk class
    cb.play();
    //SPELLCASTER perk here
    if (spellcaster == true) { 
      cbMem += 1000 * 2;
    } else {
      cbMem += 1000;
    }
    score += 1000 * scoreMod;
  }  
  if (!cb.isPlaying()) {
    cb.rewind();
    cb.pause();
  }
  if (emfT.isHit()) {
    emf.play();
    // ROGUE perk here
    if (rogue == true) { 
      emfMem += 1000 * 2;
    } else {
      emfMem += 1000;
    }
    score += 1000 * scoreMod;
  }  
  if (!emf.isPlaying()) {
    emf.rewind();
    emf.pause();
  }
  if (radioT.isHit()) {
    radio.play();
    // HACKER perk here
    if (hacker == true) { 
      radioMem += 1000 * 2;
    } else {
      radioMem += 1000;
    }
    score += 1000 * scoreMod;
  }  
  if (!radio.isPlaying()) {
    radio.rewind();
    radio.pause();
  }
  if (teleT.isHit()) {
    tele.play();
    // WARRIOR perk here
    if (warrior == true) { 
      teleMem += 1000 * 2;
    } else {
      teleMem += 1000;
    }
    score += 2000 * scoreMod;
  }
  if (!tele.isPlaying()) {
    tele.rewind();
    tele.pause();
  }
  // reuse cb audio for snake hits, emf for col hits
  if (snake1T.isHit()) {
    if (s1 == false && ss2 == false) {
      cb.play();
      s1Mem +=1000;
      if (s1Mem >= 1500) {
        memSeeker = true;
        memCounter += 1; 
        firstTimeHere = false;
        endTime = millis() + s1timer;
        s1 = true;
      }
      if (!cb.isPlaying()) {
        cb.rewind();
        cb.pause();
      }
    }
  }

  if (snake2T.isHit()) {
    if (s2 == false && ss2 == false) {
      tele.play();
      s2Mem +=1000;
      if (s2Mem >= 3000) {
        memSeeker = true;
        memCounter += 1; 
        firstTimeHere = false;
        endTime =millis() + s2timer;
        s2 = true;
      }
      if (!tele.isPlaying()) {
        tele.rewind();
        tele.pause();
      }
    }
  }
  if (snake3T.isHit()) {
    if (s3 == false && ss3 == false) {
      tele.play();
      s3Mem +=1000;
      if (s3Mem >= 4500) {
        memSeeker = true;
        memCounter += 1; 
        firstTimeHere = false;
        endTime = millis() + s3timer;
        s3 = true;
      }
      if (!tele.isPlaying()) {
        tele.rewind();
        tele.pause();
      }
    }
  }
  if (snake4T.isHit()) {
    if (s4 == false && ss4 == false) {
      tele.play();
      s4Mem +=1000;
      if (s4Mem >= 6000) {
        memSeeker = true;
        memCounter += 1; 
        firstTimeHere = false;
        endTime = millis() + s4timer;
        s4 = true;
      }
      if (!tele.isPlaying()) {
        tele.rewind();
        tele.pause();
      }
    }
  }
  if (col1T.isHit()) {
    if (c1 == false && cc1 == false) {   
      emf.play();
      c1Mem +=1000;
      if (c1Mem >= 2000) {
        memSeeker = true;
        memCounter += 1; 
        firstTimeHere = false;
        endTime = millis() + coltimer;
        c1 = true;
      }
      if (!emf.isPlaying()) {
        emf.rewind();
        emf.pause();
      }
    }
  }
  if (col2T.isHit()) {
    if (c2 == false && cc2 == false) {
      radio.play();
      c2Mem +=1000;
      if (c2Mem >= 4000) {
        memSeeker = true;
        memCounter += 1; 
        firstTimeHere = false;
        endTime = millis() + col2timer;
        c2 = true;
      }
      if (!radio.isPlaying()) {
        radio.rewind();
        radio.pause();
      }
    }
  }
  if (col3T.isHit()) {
    if (c3 == false && cc3 == false) {
      emf.play();
      c3Mem +=1000;
      if (c3Mem >= 6000) {
        memSeeker = true;
        memCounter += 1; 
        firstTimeHere = false;
        endTime = millis() + col3timer;
        c3 = true;
      }
      if (!emf.isPlaying()) {
        emf.rewind();
        emf.pause();
      }
    }
  }
  if (col4T.isHit()) {
    if (c4 == false && cc4 == false) {
      radio.play();
      c4Mem +=1000;
      if (c4Mem >= 8000) {
        memSeeker = true;
        memCounter += 1; 
        firstTimeHere = false;
        endTime = millis() + col4timer;
        c4 = true;
      }
      if (!radio.isPlaying()) {
        radio.rewind();
        radio.pause();
      }
    }
  }
  /* do something with the points accumulated for each trigger */
  // let's lock one memory in each box except tele (two)
  if (cbMem > 10000 && cb1Found == false && ccb1Found == false) {
    memSeeker = true;
    firstTimeHere = false;
    endTime = millis() + cbtimer;
    cb1Found = true;
  }

  if (emfMem > 10000 && emf1Found == false && eemf1Found == false) {
    memSeeker = true;
    firstTimeHere = false;
    endTime = millis() + emftimer;
    emf1Found = true;
  }

  if (radioMem > 7000 && radio1Found == false && rradio1Found == false) {
    memSeeker = true;
    firstTimeHere = false;
    endTime = millis() + r1timer;
    radio1Found = true;
  }
  if (radioMem > 15000 && radio2Found == false && rradio2Found == false) {
    memSeeker = true;
    firstTimeHere = false;
    endTime = millis() + r2timer;
    radio2Found = true;
  }
  cbT.draw();
  cbT.clear();
  emfT.draw();
  emfT.clear();
  radioT.draw();
  radioT.clear();
  teleT.draw();
  teleT.clear();
  snake1T.draw();
  snake1T.clear();
  snake2T.draw();
  snake2T.clear();
  snake3T.draw();
  snake3T.clear();
  snake4T.draw();
  snake4T.clear();
  col1T.draw();
  col1T.clear();
  col2T.draw();
  col2T.clear();
  col3T.draw();
  col3T.clear();
  col4T.draw();
  col4T.clear();

  // found seven generic (key mems don't iterate memCounter)and not the key mems, you go mad 
  if (memCounter > 6) {
    if (cb1Found == false || emf1Found == false || radio1Found == false || radio2Found == false) {
      // if you heard the colonel too much...
      if (c1 == true && c2 == true || c3 == true && c4 == true || c1 == true && c3 == true
        || c2 == true && c3 == true || c2 == true && c4 == true || c1 == true && c4 == true) {
        println("USD gone mad stats");
        printGameState();
        memSeeker = false;
        sane = false;
        return;
      }
    }
  }
  // and if we've unlocked at least 2 other mems 
  if (memCounter > 2 && teleMem > 50000) {
    println("Mega Memory Hunter!  ", memCounter, " ", teleMem);
    // if we've found all the other pw related mems
    if (cb1Found == true && emf1Found == true && radio1Found == true && radio2Found == true && tele1Found == false) {
      // and if we've unlocked the key pw mem
      cleanScreen();
      tele1Found = true;
      if (tele1Found == true) {
        if (!tele1.isPlaying()) {
          tele1.play();
        }
        if (tele1.isPlaying()) {
          animationMb.display(xxpos, yypos);
        }
        println("teleMem: ", teleMem);
        // we win!
        memAccess = true;
      }
    }
  }
  /* end of UpsideDown version camera work/hotpoints */
  kinect.update();
  IntVector userList = new IntVector();
  kinect.getUsers(userList);
  if (userList.size() > 0) {
    image(kinect.depthImage(), 0, 0);
    rotateX(radians(rotation));
    rotation++;
    rotateY(radians(rotationY));
    rotationY++;
    userId = kinect.getUsers();

    for (int i=0; i<userId.length; i++)
    {
      if (kinect.isTrackingSkeleton(userId[i])) {

        confidence = kinect.getJointPositionSkeleton(userId[i], 
        SimpleOpenNI.SKEL_HEAD, confidenceVector);

        if (confidence > confidenceLevel)
        {
          stroke(userColor[(i)]);
          fill(userColor[(i)]);
          drawSkeleton(userId[i]);
          dText(achievementIndex);
        }
      }
    }
  }
}

