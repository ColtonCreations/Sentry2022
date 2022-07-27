/**************************************************************************************************
 ********************  START  RESET/CLEANUP FUNCTIONS  *********************************************
 *************************************************************************************************/
/*********************************************************************************************
 *****************  START SERIAL HANDLER  *****************************************************
 *******************************************************************************************/
void serialEvent(Serial myPort) {
  // the idle lines via the Serial buffer shall not override event trigger lines 

  if (
  alrtHostiles.isPlaying() ||
    alrtNonComNoSafe.isPlaying() ||
    hostDetLethForce.isPlaying() ||
    hostTarLockGrn.isPlaying() ||
    lockingOn.isPlaying() ||
    moveAlongPlease.isPlaying() ||
    sentryMiniGatOhYeah.isPlaying() ||
    sentrySeekInfoOfficer.isPlaying() ||
    standClear.isPlaying() ||
    hostDetNeutralize.isPlaying() ||
    threatMatrix.isPlaying() ||
    threatRedWeaponsFree.isPlaying() ||
    weaponsLocked.isPlaying() ||
    yelScanHostiles.isPlaying() ||
    upsideDown.isPlaying()
    )
  { 
    pauseIdle();
  }

  if (
  !alrtHostiles.isPlaying() ||
    !alrtNonComNoSafe.isPlaying() ||
    !hostDetLethForce.isPlaying() ||
    !hostTarLockGrn.isPlaying() ||
    !lockingOn.isPlaying() ||
    !moveAlongPlease.isPlaying() ||
    !sentryMiniGatOhYeah.isPlaying() ||
    !sentrySeekInfoOfficer.isPlaying() ||
    !standClear.isPlaying() ||
    !hostDetNeutralize.isPlaying() ||
    !threatMatrix.isPlaying() ||
    !threatRedWeaponsFree.isPlaying() ||
    !weaponsLocked.isPlaying() || 
    !yelScanHostiles.isPlaying() ||
    !upsideDown.isPlaying()
    ) {
    int idleTrack = myPort.read();

    if (idleTrack == '1') { 
      myPort.clear();    
      alrtNoWarning.pause();
      threatGrnPatrolPat.pause();
      targetLost.pause();    
      lethForceImminent.pause(); 
      noHostiles.pause();
      noHostilesDetected.pause();
      if (!noGunsAllowed.isPlaying()) { // "Please note that the use of firearms within this facility is a direct violation of 17 federal laws. Have a good day"
        noGunsAllowed.rewind();
        noGunsAllowed.play();
      }
    } else if (idleTrack == '2') { 
      myPort.clear();     
      alrtNoWarning.pause();
      threatGrnPatrolPat.pause();
      targetLost.pause();
      lethForceImminent.pause();     
      noGunsAllowed.pause();
      noHostilesDetected.pause();
      if (!noHostiles.isPlaying()) {  // "Threat analysis green. No hostiles detected"
        noHostiles.rewind();
        noHostiles.play();
      }
    } else if (idleTrack == '3') {
      myPort.clear(); 
      alrtNoWarning.pause();
      threatGrnPatrolPat.pause();
      targetLost.pause();
      lethForceImminent.pause();
      noGunsAllowed.pause();
      noHostiles.pause();
      if (!noHostilesDetected.isPlaying()) {
        noHostilesDetected.rewind();
        noHostilesDetected.play();
      }
    } else if (idleTrack == '4') {
      myPort.clear(); 
      alrtNoWarning.pause();
      targetLost.pause();
      lethForceImminent.pause();
      noHostilesDetected.pause();
      noGunsAllowed.pause();

      noHostiles.pause();
      if (!threatGrnPatrolPat.isPlaying()) { // "Threat analysis green. Resuming normal patrol pattern"
        threatGrnPatrolPat.rewind();
        threatGrnPatrolPat.play();
      }
    } else if (idleTrack == '5') {
      myPort.clear(); 
      alrtNoWarning.pause();
      targetLost.pause();
      threatGrnPatrolPat.pause();
      noHostilesDetected.pause();
      noGunsAllowed.pause();
      noHostiles.pause();
      if (!lethForceImminent.isPlaying()) { // "Warning, you are in violation of a security zone. Use of lethal force  is imminennt
        lethForceImminent.rewind();
        lethForceImminent.play();
      }
    } else if (idleTrack == '6') {
      myPort.clear(); 
      alrtNoWarning.pause();
      lethForceImminent.pause();
      threatGrnPatrolPat.pause();
      noHostilesDetected.pause();
      noGunsAllowed.pause();
      noHostiles.pause();
      if (!targetLost.isPlaying()) { // "Alert target lock lost. Beginning search pattern delta 7"
        targetLost.rewind();
        targetLost.play();
      }
    } else if (idleTrack == '7') {
      myPort.clear(); 
      lethForceImminent.pause();
      threatGrnPatrolPat.pause();
      noHostilesDetected.pause();
      noGunsAllowed.pause();
      noHostiles.pause();
      targetLost.pause();
      /* "alert, non combatants are advised to leave the area.
       Security sweep in progress. 
       Lethal force may be used without warning." */
      if (!alrtNoWarning.isPlaying()) { 
        alrtNoWarning.rewind();
        alrtNoWarning.play();
      }
    }
  }
}
/**********************************************************************
 *****************  END SERIAL HANDLER  *******************************
 *********************************************************************/
void cleanScreen() {
  background(0);
}

void resetRuntime() {
  runTime = millis();
}
void reset() {
  idleTrack = 0;
  leftHiCounter = 0;
  rightHiCounter = 0;
  kneeCounter = 0;
  swordCounter = 0;
  infoCounter = 0;
  handsUpCounter = 0;
  arrestCounter = 0;
  idleCounter = 0;
  aimCounter = 0;
  kickCounter = 0;

  bonus = 0;
  currentScore = 0;
  gatCounter = 0;
  miniCounter = 0;
  score = 0;
  scoreMod = 1;
  thisBonus = 0;
  lastBonus = 0;

  hadoukenCounter = 0;
  waveCounter = 0;

  battleCounter = 0;
  memCounter = 0;

  cbMem = 0;
  emfMem = 0;
  radioMem = 0;
  teleMem = 0;
  s1Mem = 0;
  s2Mem = 0;
  s3Mem = 0;
  s4Mem = 0;
  c1Mem = 0;
  c2Mem = 0;
  c3Mem = 0;
  c4Mem = 0;
  s1= false;
  s2= false;
  s3 = false;
  s4= false;
  c1= false;
  c2= false;
  c3= false;
  c4 = false;
  ss1 = false;
  ss2 = false;
  ss3 = false;
  ss4 = false;
  cc1 = false;
  cc2 = false;
  cc3 = false;
  cc4 = false;
  ccb1Found = false;
  eemf1Found = false;
  rradio1Found = false;
  rradio2Found = false;

  cb1Found = false;
  emf1Found = false;
  radio1Found = false;
  radio2Found = false;
  tele1Found = false;
  memSeeker = false;
  firstTimeHere = true;

  rogue = false;
  spellcaster = false; 
  warrior = false; 
  hacker = false; 
  warrior1 = false; 
  warrior2 = false;
  warrior3 = false;
  warrior4 = false;
  warrior5 = false;
  hacker1 = false;
  hacker2 = false;
  gestureTypeA = false;
  gestureTypeB = false;

  mode = 0;
  madmode = 0;
  startTime = 0;
  endTime = 0;

  stopwatch = 0;
stopwatchS1 = 0;
stopwatchS2 = 0;
stopwatchS3 = 0;
 stopwatchS4 = 0;
stopwatchC1 = 0;
stopwatchC2 = 0;
stopwatchC3 = 0;
 stopwatchC4 = 0;
 stopwatchCB = 0;
stopwatchEMF = 0;
 stopwatchR1 = 0;
 stopwatchR2 = 0;
  clock = false;

  alive = true;
  sane = true;
  memAccess = false;
  achievementIndex = 0;
  characterIndex = 0;
  awardIndex = 0;
  deductionIndex = 0;
}

void printGameState() { 
  println("alive =", alive, "  sane =", sane); 
  println( "memAccess =", memAccess, "  memSeeker = ", memSeeker, "  mode =", mode, "  madmode =", madmode); 
  println("hacker =", hacker, "  rogue =", rogue, "  spellcaster =", spellcaster, "  warrior =", warrior); 
  println("achievementIndex: ", achievementIndex,"  awardIndex: ", awardIndex); 
  println("characterIndex: ", characterIndex, "  deductionIndex: ", deductionIndex); 
  println("keyMems: ", "  cb1 =", cb1Found, "  emf1Found =", emf1Found, "  radio1Found =", radio1Found, "  radio2Found =", radio2Found, "  tele1Found =", tele1Found); 
  println("memCounter: ", memCounter);
  println("colonel mem scores", "c1Mem", c1Mem, "c2Mem", c2Mem, "c3Mem", c3Mem, "c4Mem", c4Mem);
  println("colonel mem scores", "s1Mem", s1Mem, "s2Mem", s2Mem, "s3Mem", s3Mem, "s4Mem", s4Mem);
  println("snake generic mem states:", "  s1 =", s1, "  s2 =", s2, "  s3 =", s3, "  s4 =", s4); 
  println("colonel generic mem states:", "  c1 =", c1, "  c2 = ", c2, "  c3 =", c3, "  c4 =", c4);
  println("");
}
void printBattleInfo() {
  println("aimCounter: ", aimCounter, "  arrestCounter:   ", arrestCounter, "  handsUpCounter:  ", handsUpCounter, "  idleCounter: ", idleCounter, "  infoCounter: ", infoCounter); 
  println("kickCounter: ", kickCounter, "  kneeCounter:   ", kneeCounter, "  leftHiCounter:  ", leftHiCounter, "  rightHiCounter: ", rightHiCounter, "  swordCounter: ", swordCounter); 
  println("hadoukenCounter: ", hadoukenCounter, "  waveCounter:   ", waveCounter, "  memCounter:  ", memCounter, "  gatCounter: ", gatCounter, "  battleCounter: ", battleCounter); 
  println("hacker1 =", hacker1, "  hacker2 =", hacker2); 
  println("warrior1 =", warrior1, "  warrior2 =", warrior2, "  warrior3 =", warrior3, "  warrior4 =", warrior4, "  warrior5 =", warrior5);
  println("gestureTypeA = ", gestureTypeA, "  gestureTypeB = ", gestureTypeB, "  scoreMod = ", scoreMod, "  bonus = ", bonus, "  thisBonus = ", thisBonus, "  lastBonus = ", lastBonus);
  println("currentScore =  ", currentScore, "  score =  ", score); 
  println("");
}

void keyPressed() {
  if (key == 'r') {
    reset();
    return;
  }
  if (key == 'm') {
    waveCounter++;
    ark();
  }
  if (key == ' ') {
    hadoukenCounter++;
    hadouken();
  }
  if (key == 'c') {
    emf.play();
    c1Mem += 500;
    return;
  }
  if (key == 'e') {
    radio.play();
    c4Mem += 500;
    return;
  }
  if (key == 'q') {
    tele.play();
    s4Mem += 500;
    return;
  }
  if (key == 'z') {
    cb.play();
    s1Mem += 500;
    return;
  }
  if (key == 'w') {
    aimCounter++;
    return;
  }
  if (key == 'a') {
    leftHiCounter++;
    return;
  }
  if (key == 's') {
    kickCounter++;
    return;
  }
  if (key == 'd') {
    rightHiCounter++;
    return;
  }
  if (key == '(') {
    printGameState();
    return;
  }
  if (key == ')') {
    printBattleInfo();
    return;
  }

  if (key == '%') {
    if (alive == true && sane == true) {
      hacker1 = true;
      hacker2 = true;
      characterIndex = 1;
      hacker = true;
      memSeeker = true;
      if (key == '#') {
        cb1Found = true;
        memCounter += 1;
        printGameState();
        return;
      }
    }
  }
  if (key == '<') {
    madmode = 0;
    sane = !sane;
    printGameState();
    return;
  }
  if (key == '>') {
    mode = 0;
    alive = !alive;
    printGameState();
  }
  if (key == '?') {
    clock = !clock;
    if (clock == true) {
      println("runTime: ", runTime);
    }
  }

    if (key == '+') {
      alive = true;
      sane = true;
      memSeeker = true;
      memAccess = true;
      printGameState();
      return;
    }
    // conditions that drive us mad 
    if (key == ';') {
      memCounter = 7;
      cb1Found = false;
      // fix, force all then reduce as needed to get logic right
      c1 = true;
      c2 = true;
      c3 = true;
      c3 = true;
      printGameState();
      return;
    }
}

    void stop() {
      cb.close();
      cb1.close();
      emf.close();
      emf1.close();
      radio.close();
      radio1.close();
      radio2.close();
      tele.close();
      tele1.close();

      snake1.close();
      snake2.close();
      snake3.close();
      snake4.close();
      col1.close();
      col2.close();
      col3.close();
      col4.close();

      arc.close();
      pipe.close();
      hadouken.close();

      alrtHostiles.close();
      alrtNonComNoSafe.close();
      alrtNoWarning.close();
      engage.close();
      hostDetNeutralize.close();
      hostDetNoGuar.close();
      hostDetLethForce.close();
      hostTarLockGrn.close();
      ifUNeedInfo.close();
      noGunsAllowed.close();
      noHostiles.close();
      noHostilesDetected.close();
      lethForceImminent.close();
      lockingOn.close();
      minigun.close();
      moveAlongPlease.close();
      ThreatRedEngage.close();
      threatMatrix.close();
      threatRedWeaponsFree.close();
      sentryMiniGatOhYeah.close();
      sentrySeekInfoOfficer.close();
      snakeGecko.close();
      standClear.close();
      standingDown.close();
      sysFailure.close();
      sysFailureShutdown.close();
      targetLost.close();
      targetLostAtLarge.close();
      threatGrnPatrolPat.close();
      threatGreenResNorm.close();
      upsideDown.close();
      upsideLow.close();
      weaponsLocked.close();
      yelScanHostiles.close();

      player.close();
      minim.stop();
      super.stop();

      player.close();
      minim.stop();
      super.stop();
    }
    /***********************************************************************
     ********************  END RESET/CLEANUP FUNCTIONS  ********************
     ***********************************************************************/
