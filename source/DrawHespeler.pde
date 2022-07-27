
// fix could this be boolean return memseeker, ie time out getting status?
void drawHespeler() {
  background(compu);
  pauseUpside();
  pauseEngage();
  kinect.update();
  translate(width/4, height/5);
  image(kinect.rgbImage(), 0, 0); // default to innocent looking rgb cam
  IntVector userList = new IntVector();
  kinect.getUsers(userList);

  if (userList.size() > 0) {
    image(kinect.depthImage(), 0, 0); // switch to depth cam, it just got real
    userId = kinect.getUsers();

    // loop through each user to see if tracking
    for (int i=0; i<userId.length; i++)
    {
      if (kinect.isTrackingSkeleton(userId[i])) {
        pauseIdle();
        // get confidence level that Kinect is tracking head
        confidence = kinect.getJointPositionSkeleton(userId[i], 
        SimpleOpenNI.SKEL_HEAD, confidenceVector);

        // if confidence of tracking is beyond threshold, then track user
        if (confidence > confidenceLevel)
        {
          // change draw color based on hand id#
          stroke(userColor[(i)]);
          // fill the ellipse with the same color
          fill(userColor[(i)]);
          // draw the rest of the body
          drawSkeleton(userId[i]);
          useHands();
          dText(achievementIndex);
        }
      }
    }
    bonusText(bonus, deductionIndex, awardIndex);
      if (gatCounter == 3) {
      alive = false;
      return;
    }
      if (miniCounter == 10) {
      alive = false;
      return;
    }
    if (battleCounter >= 5 && warrior1 == true && warrior2 == true && warrior3 == true && warrior4 == true
      && warrior5 == true) {
        scoreMod = 1000;
      achievementIndex = 3;
      characterIndex = 4;
       warrior = true;
    }
    if (hacker1 == true && hacker2 == false) {
      characterIndex = 5;
    }
    if (hacker1 == true && hacker2 == true) {
      characterIndex = 1;
      scoreMod = 1000;
       hacker = true;
    }
  }

  if (battleCounter > 0) {
    displayCharPath(battleCounter);
    if (battleCounter >=2 && battleCounter <= 5) {
      characterIndex = 8;
    }
  }
  textRHespeler(characterIndex);
}
