/**************************************************************************************************
 ********************  START ON SCREEN TEXT FUNCTIONS  *******************************************
 *************************************************************************************************/

/* start of battle sequence on screen texts */
void dText(int achievementIndex) {
  textFont(font, 16);
  textAlign(CENTER);
  textSize(32);
  fill(#00FF00);  // green
  text(achievements[achievementIndex], 320, 100, achZ); // Specify a z-axis value 
  achZ = achZ + 7; // speed of scrolling
  achZ++;
}

int displayScore(int score) {
  textFont(scoreFont, 26);
  textSize(30);
  fill(#FFA400);  // orange
  text("TOTAL POINTS", -205, -80);
  text(score, -150, -40);
  return score;
}
// fix get in binary
void textRUSD(int memCounter) {
  textFont(scoreFont, 26);
  textSize(30);
  fill(#FFA400);  // orange
 // text("MEMORIES FOUND", charX, -80);
 // text(memCounter, charXX, -80);
  text("MEMORIES FOUND", -210, -60);
  text(memCounter, -170, -60);
  text("/12", -160, -60);
}
// fix get index of classes to display on screen
void textRHespeler(int characterIndex) {
  textFont(scoreFont, 26);
  textSize(30);
  fill(#FFA400);  // yellow
  text("CHARACTER CLASS", charX, 520);
  text(character[characterIndex], charXX, 560);
}

int displayBonus(int bonus) { // int thisBonus
  thisBonus = bonus;
  textFont(scoreFont, 26);
  textSize(30);
  text("MOVE POINTS", -210, 520);
  text(bonus, -150, 560);
  return thisBonus;
}

void bonusText(int thisBonus, int deductionIndex, int awardIndex) {
  if (lastBonus != thisBonus) {
    textFont(scoreFont, 26);
    textSize(30);
    if (bonus < 0) {
      fill(#FF0000);  // red
      deductionIndex = int(random(deduction.length));
      text(deduction[deductionIndex], -195, 200, bonZ); // Specify a z-axis value bonusX fix
    } else if (bonus > 0) {
      fill(#FFA400);  //  yellow = #FFA400; orange = #FFA400
      awardIndex = int(random(award.length));
      text(award[awardIndex], -195, 200, bonZ); // fix
    }
    lastBonus = thisBonus;
    bonZ = bonZ + 5; 
    bonZ--;
  }
}
// fix, add hacker, spellcaster, etc
void displayCharPath(int battleCounter) {
  if (battleCounter > 0 && battleCounter < 6) {
    textFont(scoreFont, 26);
    textSize(30);
    fill(#FFA400);  // orange
    text("WARRIOR SKILL", charX, -80);
    fill(#FFA400);
    text(battleCounter, 690, -40);
    text("/5 UNLOCKED", charXX, -40);
  }
}


/* end of battle sequence on screen texts */

/**************************************************************************************************
 ********************  END ON SCREEN TEXT FUNCTIONS  *******************************************
 *************************************************************************************************/
