
import java.util.Map;
import java.util.Iterator;
import processing.opengl.*;
import processing.serial.*;
import SimpleOpenNI.*;
import ddf.minim.*;

SimpleOpenNI  kinect;
Serial myPort;
Minim minim;
AudioPlayer player;
/* Animation class instances */
Animation animationMa; // Matrix door
Animation animationMb; // Green matrix-y looking boxes
Animation animationMf; // USD mindflayer
Animation animationMg; // Metal Gear codec
Animation animationTe; // Fallout terminal locked

/* Hotpoint class instances */
Hotpoint cbT; //  use snakeNeedToUnlock.wav - that it's the thing needs done
Hotpoint emfT; // use otaconFiveDigit.wav - other crucial clue
Hotpoint radioT; // two stage: 1st use otaconPunchPW.wav(early), then use doorAtBack.wav - has good radio tuning built in
Hotpoint teleT; // use snakePW.wav - pw needed
Hotpoint snake1T; // use colDegaulle.wav
Hotpoint snake2T; // use colDestroyMG.wav
Hotpoint snake3T; // use snakeOkay.wav - lore element/story
Hotpoint snake4T; // use snakeNine - story element
Hotpoint col1T; // use colBogus.wav - ingenious trick
Hotpoint col2T; // use colFlapjaw.wav - weird, very eerie
Hotpoint col3T; // use colMission.wav - "mission is a failure"
Hotpoint col4T; // use colSocom.wav
Hotpoint pipeT; // Super Mario decending pipe

/*  Hespeler Audio instances */
AudioSnippet alrtHostiles; // "Alert, hostiles in area"
AudioSnippet alrtNonComNoSafe; // "alert non combatant safety cannot be guaranteed"
AudioSnippet alrtNoWarning; // "alert, non combatants are advised to leave the area. Security sweep in progress. Lethal force may be used without warning."
AudioSnippet engage; 
AudioSnippet hostTarLockGrn; // "hostile target detected, target lock status, green"
AudioSnippet hostDetLethForce; // "Alert, hostile detected. Lethal force authorized for all units."
AudioSnippet hostDetNeutralize; // "Hostile detected. Commencing neutralization"
AudioSnippet hostDetNoGuar; // "Hostile detected, non combatant safety can no longer be guaranteed."
AudioSnippet ifUNeedInfo; // "if you require event information or directions, please speak to an information kiosk officer"
AudioSnippet lethForceImminent; // "Warning, you are in violation of a security zone. Use of lethal force  is imminent"
AudioSnippet lockingOn;// "Locking on. Firing"
AudioSnippet minigun;
AudioSnippet moveAlongPlease;//  "Move Along Please"
AudioSnippet noGunsAllowed; // "Please note that the use of firearms within this facility is a direct violation of 17 federal laws. Have a good day"
AudioSnippet noHostiles; // "No hostiles detected. Continuing perimeter sweep"
AudioSnippet noHostilesDetected; // "Threat analysis green. No hostiles detected"
AudioSnippet sentryMiniGatOhYeah; // 8 seconds of total annihilation
AudioSnippet sentrySeekInfoOfficer; // "Please continue along, if you have any questions, seek an information kiosk officer at any one of the stations."
AudioSnippet snakeGecko;
AudioSnippet standClear; // "Non combatants are advised to stand clear of weapons discharge"
AudioSnippet standingDown; // "Threat analysis green, standing down"
AudioSnippet sysFailure; // "Warning, system failure imminent"
AudioSnippet sysFailureShutdown; // "Warning...whirr..primary systems offline...systems fail"
AudioSnippet targetLost; // "Alert target lock lost. Beginning search pattern delta 7"
AudioSnippet targetLostAtLarge; // "Alert target lock lost. Unneutralized hostile within perimeter"
AudioSnippet threatGreenResNorm; // "Threat analysis green, security operation successful. Resuming normal operation"
AudioSnippet threatGrnPatrolPat; //"Threat analysis green. Resuming standard patrol pattern"
AudioSnippet threatMatrix; // "Adding target to threat matrix" -- use this on initial detect
AudioSnippet ThreatRedEngage; // "Threat analysis red, engaging hostile target"
AudioSnippet threatRedWeaponsFree; //  "Threat analysis red, weapons free"
AudioSnippet weaponsLocked; // "Weapon systems locked on"
AudioSnippet yelScanHostiles; // "Threat analysis yellow, scanning for hostiles"
/*  UpsideDown Audio instances */
AudioSnippet arc; 
AudioSnippet hadouken;
AudioSnippet upsideDown;
AudioSnippet upsideLow;
AudioSnippet cb;
AudioSnippet emf;
AudioSnippet radio;
AudioSnippet tele;
AudioSnippet cb1;
AudioSnippet emf1;
AudioSnippet radio1;
AudioSnippet radio2;
AudioSnippet tele1;
AudioSnippet snake1;
AudioSnippet snake2;
AudioSnippet snake3;
AudioSnippet snake4;
AudioSnippet col1;
AudioSnippet col2;
AudioSnippet col3;
AudioSnippet col4;
AudioSnippet pipe;

PImage compu = loadImage("c:/data/compu.jpg");
PImage planet = loadImage("c:/data/planet.jpg");
PImage standby = loadImage("c:/data/standby.jpg");
PImage circuitboard = loadImage("c:/data/circuitboard.jpg");

// for the game end screen text (0-1)
String[] headlines = {
  "Threat  Neutralized", "The Syndicated Man: Quest Failed",
};

String[] madman = {
  "Mind Corrupted: Deleting Human Element", "The Syndicated Man: Quest Failed",
};

// to display char classes in Hespeler (0-8)
String[] character = {
  "COMMONER", "HACKER", "ROGUE", "SPELLCASTER", "WARRIOR", "HACKER PATH", "ROGUE PATH", 
  "SPELLCASTER PATH", "WARRIOR PATH",
};

// dynamic texts during battle, encouragement (0-9)
String[] award = {
  "WELL DONE!", "NICE MOVES!", "LIKE A BOSS!", "DEADLY!  ", "EXCELLENT!", 
  "ULTIMATE!", "KILLER COMBO!", "NOT BAD", "GOOD EFFORT", "KEEP GOING",
};
// opposite of award above (0-8)
String[] deduction = {
  "WATCH OUT!", "OH NO!", "DANGER CLOSE", "NOT QUITE", "DEFEND!", 
  "THAT'S NOT THE WAY", "ATTACK IMMINENT!", "YOU CAN DO IT!", 
  "SLOPPY TECHNIQUE",
};

// for the battle sequence text on screen aka player feedback
String[] achievements = {
  " ", //blank on purpose (single space, better not empty?) // 0
  "SYSTEM FAILURE - ROUTING AUX POWER SET", //1
  "CRITICAL ERROR STATE - DISABLING ARMS", //2
  "THE WARRIOR WINS!!!!", //3 
  "SCORE BONUS LOST!! OH NO!!", //4
  "SCORE BONUS LOST!!", //5
  "GET IN THE MAINFRAME AND HACK THE CODE!", //6 
  "A HACKER FOOLED THE SENTRY!", //7
  "SCORE BONUS x2!", //8
  "THE SENTRY IS DUPED! SALUTE TO BLEND IN!", //9 
  "HEEEEEEEE YAAH!!!!!", //10
  "PROFICIENT SNEAK ATTACK!", //11 
  "IMPRESSIVE BALANCED STYLE!", //12 
  "LEFTY DUELIST! ", //13
  "IMPRESSIVE SWORDSMANSHIP!", //14
  // WARRIOR MOVES LIST
  "DEADLY PISTOLEER!", //15
  "RIGHT HIGH ARC!", //16
  "LEFT HIGH SLASH!", //17
  "MIDDLE ATTACK & COUNTER!", //18
  "LOW SNEAK ATTACK!", //19
  "FRONT POWER KICK!", //20
  "WARRIOR RIGHT SLASH UNLOCKED!", //21
  "WARRIOR LEFT SLASH UNLOCKED!", //22
  "WARRIOR SPEED DRAW UNLOCKED!", //23
  "WARRIOR SNEAK ATTACK UNLOCKED!", //24
  "WARRIOR UNARMED KICK UNLOCKED!", //25
  // Text secrets of the upside down
  "UNICORN WAND SLOWS TIME WHERE GREEN LIGHT IS BRIGHTEST", //26 cb1Found
  "CRACKING A SAFE? TRY THE SWEETEST WORD OF ALL", //27 emf1Found
  "LASERS THAT MOVE ARE USUALLY DECOYS, THEY WON'T TRIP ALARMS", //28 radio1Found
  "BATTLING COVIDIANS? TREASURE ABOUNDS, BUT WATCH OUT FOR THEIR SLIME ATTACK", //29 radio2Found
  "LISTEN CAREFULLY TO THE MEMORIES OF THE SYNDICATED MAN", // 30 tele1Found
  "SPELLCASTER HAS CONJURED INTO THE VOID", // 31
};
// timing variables for audio/gif sync
int runTime = 0; // master clock
int startTime;
int endTime;
int stopwatch;
int stopwatchS1;
int stopwatchS2;
int stopwatchS3;
int stopwatchS4;
int stopwatchC1;
int stopwatchC2;
int stopwatchC3;
int stopwatchC4;
int stopwatchCB;
int stopwatchEMF;
int stopwatchR1;
int stopwatchR2;
boolean clock;
int timer = 29500; // orig, death transition timer
int madtimer = 36000; // gonemad timer
int intimer = 4000; // matrix door anim
int outtimer = 2000; // codec anim back for more mems
int cbtimer = 13000; // cb1 tele1 
int emftimer = 38000; // emf1
int r1timer = 8000; // radio1
int r2timer = 11000; // radio2, 
int coltimer = 15000; //col1, 
int col2timer = 15000;// col2
int col3timer = 11000; // col3
int col4timer = 11000; // col4
int s1timer = 29000; // snake1, 
int s2timer = 15000; // snake 2
int s3timer = 46000; // snake 3
int s4timer = 29000;

PFont font;
PFont scoreFont;
/* ROTATION FOR UPSIDEDOWN CAM */
float rotation = 0;
float rotationY = 0;
float x; 
// for the mindflayer/both matrix animations
float xxpos;
float yypos;
// for the side scrolling text indices
int index = 0;
int ind = 0;
// various indices to arrays above
int achievementIndex;
int awardIndex;
int characterIndex;
int deductionIndex;

// for index and location of in-game texts
float achX; 
float achZ;
float bonZ;
float charX; // header
float charXX; // detail
int bonusX = -220; //defaults here
// for kinect skeleton tracking
int[] userId;
// user colors for skeleton tracking
color[] userColor = new color[] { 
  color(255, 0, 0), color(0, 255, 0), color(0, 0, 255), 
  color(255, 255, 0), color(255, 0, 255), color(0, 255, 255)
};

/*  SKELETON TRACKING  */
// position of head to draw circle
PVector headPosition = new PVector();
// turn headPosition into scalar form
float distanceScalar;
// diameter of head drawn in pixels
float headSize = 200;
// threshold of level of confidence
float confidenceLevel = 0.5;
// the current confidence level that the kinect is tracking
float confidence;
// vector of tracked head for confidence checking
PVector confidenceVector = new PVector();
/*  SKELETON TRACKING DEFS END */

/* HAND TRACKING DEFS START ADAPTED FROM kinectHandsOpenClose*/
int handId;
int handVecListSize = 20;
Map<Integer, ArrayList<PVector>>  handPathList = new HashMap<Integer, ArrayList<PVector>>();
color[]       userClr = new color[] { 
  color(255, 0, 0), 
  color(0, 255, 0), 
  color(0, 0, 255), 
  color(255, 255, 0), 
  color(255, 0, 255), 
  color(0, 255, 255)
};
/* HAND TRACKING DEFS END */

/************** START GAME STATE/EVENT DRIVERS  ******************/
boolean alive; // are you?
boolean sane;
boolean memAccess; // whether the overall goal of retrieving the keyMems has been reached
int memCounter; // can have catastrophic effect if too high and keyMems not found
int mode; // inits at 0, sets to 1 if alive == false, (gameOver()), 2 is game over/hotpoint reset (gameOverDead())
int madmode;
/* whether we've already heard these mems (the audio) */
boolean s1;
boolean s2;
boolean s3;
boolean s4;
boolean c1;
boolean c2;
boolean c3;
boolean c4;
boolean ss1;
boolean ss2;
boolean ss3;
boolean ss4;
boolean cc1;
boolean cc2;
boolean cc3;
boolean cc4;
// whether or not these memories have been unlocked (game progression and audio)
boolean cb1Found;
boolean emf1Found;
boolean radio1Found;
boolean radio2Found;
boolean tele1Found;
boolean ccb1Found;
boolean eemf1Found;
boolean rradio1Found;
boolean rradio2Found;
boolean ttele1Found;
// any mem == true sets general flag to route back to USD for more
boolean memSeeker;
boolean firstTimeHere;
/* for wave events to unlock memories, this will toggle true on extended hand waving events
 to access the upsideDown and the memories of the mystery */
boolean hacker; // switching condition for HACKER battling into USD
boolean rogue; // switching condition for ROGUE into USD
boolean spellcaster; // switching condition for spellcasterCASTER waving in USD
boolean warrior; // switching condition for WARRIOR battling into USD
/************** END GAME STATE/EVENT DRIVERS ******************/

/************* START VARIOUS COUNTERS AND EVENT TRACKERS TO PREVENT UNWANTED OVERLAPPING AUDIO TRACKS ********/
// variable to store what idle track is being cued by Arduino while standing around
int idleTrack; 
/* These are timing counters to prevent audio from constantly overlapping.
 Longer phrases get higher counters, defined and tuned within their respective
 conditions. Since different gestures allot different point values, and logically
 and logistically (some gestures more easily tripped by accident), counters also
 reflect that, thus saluting which is low points (almost no damage) but high counter
 (shortcut of tricking bot into allowing safe approach as a HACKER would)is balanced
 against high arc sword wielding (low counter, it's easy to pull off but easy to get
 wasted in battle, but higher points in Hespeler, although it will take a whole 
 lotta points to get to winning condition in this WARRIOR method */
int aimCounter;
int arrestCounter;
int handsUpCounter;
int idleCounter;
int infoCounter;
int kickCounter;
int kneeCounter;
int leftHiCounter;
int rightHiCounter;
int swordCounter;
int battleCounter; // increments up to 5 see if player becomes WARRIOR
int gatCounter; // three chances to get gat
int miniCounter; // six chances to get creamed

/* score trackers for entry/interaction. These add to overall score,
 unlock discrete memories and are most likely path to the winning condition. 
 Simply waving  forever is possible, or battling the robot through gestures,
 but will take forever as the high point values occur in the Upside Down.*/
int hadoukenCounter; // counter for ROGUE entry
int waveCounter; // counter for spellcasterCASTER entry

// no counter for HACKER entry. They follow boolean stage progression instead (hands up, salute)
boolean hacker1; // hands up
boolean hacker2; // must have hacker 1 then get 2
// no counter for WARRIOR entry. Entry is 5 stages that follow a boolean stage progression instead
boolean warrior1; // 1-5 fill conditions to add to battle counter that a true warrior has been found
boolean warrior2;
boolean warrior3;
boolean warrior4;
boolean warrior5;
boolean gestureTypeA; // path to conditions due to waving
boolean gestureTypeB; // path to conditions due to clicking
int currentScore;
int score;
int scoreMod;
int bonus;
int thisBonus;
int lastBonus;

/******* USD Hotpoint interaction counters  ******************/
// keyMems
int cbMem;  
int emfMem; 
int radioMem;
int teleMem ;
// genericMems snake1, snake2, etc. same for c1/col1 etc.
int s1Mem; 
int s2Mem;
int s3Mem;
int s4Mem;
int c1Mem;
int c2Mem;
int c3Mem;
int c4Mem;
//////////////////////////////////////////////////////////////////////////////////
/************* END OF DEFINITIONS ***********************************************/
//////////////////////////////////////////////////////////////////////////////////


//////////////////////////////////////////////////////////////////////////////////
/**************** START OF SETUP ************************************************/
//////////////////////////////////////////////////////////////////////////////////
void setup() { 
  size(1366, 768, OPENGL); // my laptop native resolution
  kinect = new SimpleOpenNI(this);
  kinect.enableDepth();
  kinect.enableRGB();
  kinect.enableUser();
  kinect.enableHand();
  kinect.alternativeViewPointDepthToImage();
  kinect.startGesture(SimpleOpenNI.GESTURE_WAVE);
  kinect.setMirror(true); 
  strokeWeight(5);
  minim = new Minim(this);
  scoreFont = loadFont ("MakeMeACyborg-48.vlw");
  font = loadFont ("AlienCyborg-48.vlw");
  // animations
  animationMa = new Animation("ma_", 21); // matrix rooftop door
  animationMb = new Animation("mb_", 38); // matrix green weird boxy one
  animationMf = new Animation("mf_", 38); // mindflayer
  animationMg = new Animation("mg_", 11); // metal gear codec
  animationTe = new Animation("te_", 13); // fallout terminal locked

  x = width; 
  yypos = height * 0.001;
  xxpos = width * 0.06; 
  charX = width/1.65;
  charXX = width/1.65;
  /*WAVFILES/OBJECT////METHOD////////////FILE/////////////////////FILE RUNTIME */
  alrtHostiles = minim.loadSnippet("alrtHostiles.wav"); // 2
  alrtNonComNoSafe = minim.loadSnippet("alrtNonComNoSafe.wav"); // 3
  alrtNoWarning = minim.loadSnippet("alrtNoWarning.wav"); // 8
  arc = minim.loadSnippet("arc.wav"); // 2
  engage = minim.loadSnippet("engage.wav"); // 3:17
  hostTarLockGrn = minim.loadSnippet("hostTarLockGrn.wav"); // 4
  hostDetLethForce = minim.loadSnippet("hostDetLethForce.wav"); // 4
  hostDetNeutralize = minim.loadSnippet("hostDetNeutralize.wav"); // 3
  hostDetNoGuar = minim.loadSnippet("hostDetNoGuar.wav"); // 4
  ifUNeedInfo = minim.loadSnippet("ifUNeedInfo.wav"); // 7
  lethForceImminent = minim.loadSnippet("lethForceImminent.wav"); // 5
  lockingOn = minim.loadSnippet("lockingOn.wav"); // 2
  minigun = minim.loadSnippet("minigunBurst.wav"); // 1
  moveAlongPlease = minim.loadSnippet("moveAlongPlease.wav"); // 1
  noGunsAllowed = minim.loadSnippet("noGunsAllowed.wav"); // 9
  noHostiles = minim.loadSnippet("noHostiles.wav"); // 3
  noHostilesDetected = minim.loadSnippet("noHostilesDetected.wav"); // 4
  sentryMiniGatOhYeah = minim.loadSnippet("sentryMiniGatOhYeah.wav"); // 7
  sentrySeekInfoOfficer = minim.loadSnippet("sentrySeekInfoOfficer.wav");  //8
  snakeGecko = minim.loadSnippet("snakeGecko.wav"); // 25
  standClear = minim.loadSnippet("standClear.wav"); // 4
  standingDown = minim.loadSnippet("standingDown.wav"); // 3
  sysFailure =  minim.loadSnippet("sysFailure.wav");  // 2
  sysFailureShutdown = minim.loadSnippet("sysFailureShutdown.wav"); // 9
  targetLost = minim.loadSnippet("targetLost.wav"); // 4
  targetLostAtLarge = minim.loadSnippet("targetLostAtLarge.wav"); // 4
  threatGreenResNorm = minim.loadSnippet("threatGreenResNorm.wav"); // 6
  threatGrnPatrolPat = minim.loadSnippet("threatGrnPatrolPat.wav"); // 4
  threatMatrix = minim.loadSnippet("threatMatrix.wav"); // 2
  ThreatRedEngage = minim.loadSnippet("ThreatRedEngage.wav"); // 3 
  threatRedWeaponsFree = minim.loadSnippet("threatRedWeaponsFree.wav"); // 3
  weaponsLocked = minim.loadSnippet("weaponsLocked.wav"); // 1
  yelScanHostiles = minim.loadSnippet("yelScanHostiles.wav"); // 4
  // gets to the upside down
  hadouken = minim.loadSnippet("Hadouken.wav");
  //used in the upside down
  upsideDown = minim.loadSnippet("upsideDownSoftmix.wav"); // 6:55
  upsideLow = minim.loadSnippet("upsideDownLow.wav"); // 3:33
  cb = minim.loadSnippet("cb.wav");
  cb1 = minim.loadSnippet("snakeNeedToUnlock.wav"); // see memories tab
  emf = minim.loadSnippet("emf.wav");
  emf1 = minim.loadSnippet("otaconFiveDigit.wav");
  radio = minim.loadSnippet("radio.wav");
  radio1 = minim.loadSnippet("otaconPunchpw.wav");
  radio2 = minim.loadSnippet("doorAtBack.wav");
  tele = minim.loadSnippet("tele.wav");
  tele1 = minim.loadSnippet("snakePW.wav");
  snake1 = minim.loadSnippet("colDegaulle.wav");
  snake2 = minim.loadSnippet("colDestroyMG.wav");
  snake3 = minim.loadSnippet("snakeOkay.wav");
  snake4 = minim.loadSnippet("snakeNine.wav");
  col1 = minim.loadSnippet("colBogus.wav");
  col2 = minim.loadSnippet("colFlapjaw.wav");
  col3 = minim.loadSnippet("colMission.wav");
  col4 = minim.loadSnippet("colSocom.wav");
  pipe = minim.loadSnippet("pipe.wav");
  /* END LOAD WAV FILES */
  /* SET UP HOT POINTS */
  cbT = new Hotpoint(-57, 300, 930, 140); // default -57,300,930,140
  emfT = new Hotpoint(570, 130, 1100, 190); // 570,130,1100,190
  radioT = new Hotpoint(880, 300, 1500, 200); // 880,300,1500,200
  teleT = new Hotpoint(-200, 80, 2000, 280); // -200,80,2000,280
  snake1T = new Hotpoint(-2000, 600, 800, 160);
  snake2T = new Hotpoint(2000, 600, 400, 180);
  snake3T = new Hotpoint(-950, 800, 1000, 260);
  snake4T = new Hotpoint(950, 800, 600, 220);
  col1T = new Hotpoint(-350, 400, 2000, 240);
  col2T = new Hotpoint(350, 700, 1800, 240);
  col3T = new Hotpoint(-700, 900, 1800, 220);
  col4T = new Hotpoint(700, 500, 1700, 250);
  pipeT = new Hotpoint(-57, -200, 530, 440);
  /* OPEN SERIAL CONNECTION */
  myPort = new Serial(this, Serial.list()[0], 9600);
  /* INIT GLOBAL VARIABLES */
  reset();
  resetRuntime();
}
//////////////////////////////////////////////////////////////////////////////////
/****************** END OF SETUP ************************************************/
//////////////////////////////////////////////////////////////////////////////////



//////////////////////////////////////////////////////////////////////////////////
/**************** START OF MAIN ************************************************/
//////////////////////////////////////////////////////////////////////////////////
void draw() {
  if (alive == false) {
    if (mode == 0) {
      resetTimer();
    }
    if (mode == 1) {
      gameOver();
    }
    if (mode == 2) {
      gameOverDead();
    }
  }
  if (sane == false) {
    if (madmode == 0) {
      resetTimer();
    }
    if (madmode == 1) {
      goneMad();
    } 
    if (madmode == 2) {
      gameOverMad();
    }
  }
  if (alive == true && sane == true) {  
    if (memAccess == true && alive == true && sane == true && memSeeker == true) {
      // success! got the codes, saved the world, found out the code of the Syndicated Man
      savedPlanet();
    } else if (rogue == false && spellcaster == false && warrior == false && hacker == false && memAccess == false && memSeeker == false) {
      scoreMod = 100;
      drawHespeler();
    } else if (rogue == true || spellcaster == true || warrior == true || hacker == true && memAccess == false && memSeeker == false) {
      scoreMod = 1000;
      drawTheUpsideDown();

      if (s1 == true && ss1 == false) {
        stopwatchS1 = millis();
        pauseQuiet();
        if (!snake1.isPlaying()) {
          println("s1: ", s1Mem);
          snake1.play();
        }
        animationMb.display(xxpos, yypos);    
        if (endTime < stopwatchS1) {
          snake1.rewind();
          snake1.pause();
          ss1 = true;
          memSeeker = false;
        }
      } else if (s2 == true && ss2 == false) {
        stopwatchS2 = millis();
        pauseQuiet();
        if (!snake2.isPlaying()) {
          println("s2: ", s2Mem);
          snake2.play();
        }
        animationMb.display(xxpos, yypos);    
        if (endTime < stopwatchS2) {
          snake2.rewind();
          snake2.pause();
          ss2 = true;
          memSeeker = false;
        }
      } else if (s3 == true && ss3 == false) {
        stopwatchS3 = millis();
        pauseQuiet();
        if (!snake3.isPlaying()) {
          println("s3: ", s3Mem);
          snake3.play();
        }
        animationMb.display(xxpos, yypos);    
        if (endTime < stopwatchS3) {
          snake3.rewind();
          snake3.pause();
          ss3 = true;
          memSeeker = false;
        }
      } else if (s4 == true && ss4 == false) {
        stopwatchS4 = millis();
        pauseQuiet();
        if (!snake4.isPlaying()) {
          println("s4: ", s4Mem);
          snake4.play();
        }
        animationMb.display(xxpos, yypos);    
        if (endTime < stopwatchS4) {
          snake4.rewind();
          snake4.pause();
          ss4 = true;
          memSeeker = false;
        }
      } else if (c1 == true && cc1 == false) {
        stopwatchC1 = millis();
        pauseQuiet();
        if (!col1.isPlaying()) {
          println("c1: ", c1Mem);
          col1.play();
        }
        animationMb.display(xxpos, yypos);    
        if (endTime < stopwatchC1) {
          col1.rewind();
          col1.pause();
          cc1 = true;
          memSeeker = false;
        }
      } else if (c2 == true && cc2 == false) {
        stopwatchC2 = millis();
        pauseQuiet();
        if (!col2.isPlaying()) {
          println("c2: ", c2Mem);
          col2.play();
        }
        animationMb.display(xxpos, yypos);    
        if (endTime < stopwatchC2) {
          col2.rewind();
          col2.pause();
          cc2 = true;
          memSeeker = false;
        }
      } else if (c3 == true && cc3 == false) {
        stopwatchC3 = millis();
        pauseQuiet();
        if (!col3.isPlaying()) {
          println("c3: ", c3Mem);
          col3.play();
        }
        animationMb.display(xxpos, yypos);    
        if (endTime < stopwatchC3) {
          col3.rewind();
          col3.pause();
          cc3 = true;
          memSeeker = false;
        }
      } else if (c4 == true && cc4 == false) {
        stopwatchC4 = millis();
        pauseQuiet();
        if (!col4.isPlaying()) {
          println("c4: ", c4Mem);
          col4.play();
        }
        animationMb.display(xxpos, yypos);    
        if (endTime < stopwatchC4) {
          col4.rewind();
          col4.pause();
          cc4 = true;
          memSeeker = false;
        }
      } else if (cb1Found == true && ccb1Found == false) {
        stopwatchCB = millis();
        pauseQuiet();
        if (!cb1.isPlaying()) {
          println("cb1Found: ", cb1Found);
          cb1.play();
        }
        animationMb.display(xxpos, yypos);    
        if (endTime < stopwatchCB) {
          cb1.rewind();
          cb1.pause();
          ccb1Found = true;
          memSeeker = false;
        }
      } else if (emf1Found == true && eemf1Found == false) {
        stopwatchEMF = millis();
        pauseQuiet();
        if (!emf1.isPlaying()) {
          println("emf1Found: ", emf1Found);
          emf1.play();
        }
        animationMb.display(xxpos, yypos);    
        if (endTime < stopwatchEMF) {
          emf1.rewind();
          emf1.pause();
          eemf1Found = true;
          memSeeker = false;
        }
      } else if (radio1Found == true && rradio1Found == false) {
        stopwatchR1 = millis();
        pauseQuiet();
        if (!radio1.isPlaying()) {
          println("radio1Found: ", radio1Found);
          radio1.play();
        }
        animationMb.display(xxpos, yypos);    
        if (endTime < stopwatchR1) {
          radio1.rewind();
          radio1.pause();
          rradio1Found = true;
          memSeeker = false;
        }
      } else if (radio2Found == true && rradio2Found == false) {
        stopwatchR2 = millis();
        pauseQuiet();
        if (!radio2.isPlaying()) {
          println("radio2Found: ", radio2Found);
          radio2.play();
        }
        animationMb.display(xxpos, yypos);    
        if (endTime < stopwatchR2) {
          radio2.rewind();
          radio2.pause();
          rradio2Found = true;
          memSeeker = false;
        }
      }
    }
    displayScore(score);
    displayBonus(bonus);
    textRHespeler(characterIndex);
      textRUSD(memCounter);
  }
}

/*---------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------
 START OF SKELETON TRACKING AND GESTURE RECOGNITION FUNCTIONS
 ---------------------------------------------------------------------------------------
 --------------------------------------------------------------------------------------- */


/* Draw the skeleton of a tracked user.  Input is userId
 ----------------------------------------------------------------*/
// fix should this be int and return gatcounter for doom damage screen
void drawSkeleton(int userId) {
  PVector rightHand = new PVector();
  PVector rightElbow = new PVector();
  PVector rightShoulder = new PVector();
  PVector leftShoulder = new PVector();
  PVector leftHand = new PVector();
  PVector leftElbow = new PVector();
  PVector torso = new PVector();
  PVector leftHip = new PVector();
  PVector leftKnee = new PVector();
  PVector rightHip = new PVector();
  PVector rightKnee = new PVector();
  PVector neck = new PVector();
  PVector head = new PVector();
  PVector leftFoot = new PVector();
  PVector rightFoot = new PVector();
  // get 3D position of head
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_HEAD, headPosition);
  // convert real world point to projective space
  kinect.convertRealWorldToProjective(headPosition, headPosition);
  // create a distance scalar related to the depth in z dimension
  distanceScalar = (525/headPosition.z);
  // draw the circle at the position of the head with the head size scaled by the distance scalar
  ellipse(headPosition.x, headPosition.y, distanceScalar*headSize, distanceScalar*headSize);

  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HAND, rightHand);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, rightElbow);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, rightShoulder);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HAND, leftHand);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, leftElbow);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, leftShoulder);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_TORSO, torso);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_HIP, leftHip);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_KNEE, leftKnee);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_LEFT_FOOT, leftFoot);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_HIP, rightHip);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, rightKnee);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_RIGHT_FOOT, rightFoot);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_NECK, neck);
  kinect.getJointPositionSkeleton(userId, SimpleOpenNI.SKEL_HEAD, head);

  if (rightHand.z < rightElbow.z && rightElbow.z < rightShoulder.z && rightHand.x < rightShoulder.x && leftHand.z < leftElbow.z && leftElbow.z < leftShoulder.z && leftHand.x > leftShoulder.x) {
    aimCounter ++;
    score += aimCounter * scoreMod;

    achievementIndex = 8;
    if (aimCounter == 5) {
      stroke(255);
      stroke(192, 192, 192); // silver
      lockingOn(); //"Locking on. Firing"
      scoreMod = scoreMod * 2;
    } else if (aimCounter == 40) {
      stroke(255);
      stroke(192, 192, 192); // silver
      giveTheGat();
      score -=100000;
      bonus = -100000;
      gatCounter++;
    }

    if (aimCounter >= 41) {
      aimCounter = 0;
    }
    //println("aim counter:  " + aimCounter);
  }

  // threatening stance like raising a sword to strike a blow, right arm, warrior1
  // if (rightElbow.y > rightShoulder.y && rightElbow.x > rightShoulder.x && rightHand.y > rightElbow.y && rightHand.x > rightElbow.x) {
  if (rightElbow.y > rightShoulder.y && rightElbow.x > rightShoulder.x && rightHand.y > rightElbow.y && leftElbow.y < leftShoulder.y && rightHand.x > rightElbow.x ) {
    if (leftElbow.y < leftShoulder.y) {
      rightHiCounter++;
      score += rightHiCounter * scoreMod;

      achievementIndex = 16;
      // WARRIOR PROGRESSION STAGE ONE
      if (warrior1 == false) {
        if (battleCounter == 0) {
          warrior1 = true;
          battleCounter = 1;
          bonus = 500;
          achievementIndex = 21; //WARRIOR 1 UNLOCKED
          println("WARRIOR1 UNLOCKED");
        }
      }
      stroke(255);
      stroke(255, 0, 0);
      if (rightHiCounter == 5) {
        lockingOn();
        scoreMod = scoreMod * 2;
        achievementIndex = 8;
      } else if (rightHiCounter == 40) {
        giveTheMini();
        score -=25000;
        bonus = -25000;
        miniCounter ++;
      } else if (rightHiCounter == 60) {
        giveTheMini();
        score -=25000;
        bonus = -25000;
        miniCounter ++;
      } else if (rightHiCounter == 80) {
        giveTheMini();
        score -=25000;
        bonus = -25000;
        miniCounter ++;
      } else if (rightHiCounter == 100) {
        giveTheGat();
        score -=100000;
        bonus = -100000;
        gatCounter ++;
      }
      if (rightHiCounter >= 101) {
        rightHiCounter = 0;
      }
    }
  }

  // threatening stance like raising a sword to stike a blow left handed version of above, warrior2
  if (leftElbow.y > leftShoulder.y && leftElbow.x < leftShoulder.x && leftHand.y > leftElbow.y && rightElbow.y < rightShoulder.y) {
    if (rightElbow.y < rightShoulder.y) {
      leftHiCounter++;
      score += leftHiCounter * scoreMod;
      achievementIndex = 17;
      if (warrior2 == false) {
        if (battleCounter == 4) {
          warrior2 = true;
          // FINISH HIM!
          battleCounter = 5;
          bonus = 750;
          achievementIndex = 22; // WARRIOR 2 UNLOCKED
          println("WARRIOR2 UNLOCKED");
        }
      }
      stroke(255);
      stroke(255, 0, 0);
      if (leftHiCounter == 5) {
        lockingOn();
        scoreMod = scoreMod * 2;
        //  println("SCORE BONUS X 2!");
        achievementIndex = 8;
      } else if (leftHiCounter == 40) {
        giveTheMini();
        score -= 25000;
        bonus = -25000;
        miniCounter ++;
      } else if (leftHiCounter == 60) {
        giveTheMini();
        score -= 25000;
        bonus = -25000;
        miniCounter ++;
      } else if (leftHiCounter == 80) {
        giveTheMini();
        score -= 25000;
        bonus = -25000;
        miniCounter ++;
      } else if (leftHiCounter == 100) {
        giveTheGat();
        score -= 100000;
        bonus = -100000;
        gatCounter ++;
      }
      if (leftHiCounter >= 101) {
        leftHiCounter = 0;
      }
    }
  }

  // roughly drawing sword across hip or getting low in battle stance warrior3
  if (rightHand.x < leftHip.x || leftHand.x > rightHip.x || leftElbow.y < leftKnee.y || rightElbow.y < rightKnee.y) {
    swordCounter++;
    score += swordCounter * scoreMod;
    achievementIndex = 18;
    if (warrior3 == false) {
      if (battleCounter == 2) {
        warrior3 = true;
        battleCounter = 3;
        bonus = 250;
        // println(battleCounter);
        achievementIndex = 23; // WARRIOR 3
        println("WARRIOR3 UNLOCKED");
      }
    }
    if (swordCounter == 10) {
      alrtHostiles(); // "Alert, hostiles in area"
      stroke(255);
      stroke(255, 140, 0);
    } else if (swordCounter == 50) {
      giveWarning(); // "Threat analysis red, weapons free"
      stroke(255);
      stroke(255, 0, 0);
      score += 500;
    } else if (swordCounter == 70) {
      giveTheMini(); // "Threat analysis red, weapons free"
      stroke(255);
      stroke(255, 0, 0);
      score -= 500;
    }
    if (swordCounter >= 101) {
      swordCounter = 0;
    }
  }

  // reachin' for that blade, or maybe the senorita pistole? WARRIOR4
  if (leftKnee.y > leftHand.y || rightKnee.y > leftHand.y) {
    kneeCounter++;
    score += kneeCounter * scoreMod;
    achievementIndex = 19;
    if (warrior4 == false) {
      if (battleCounter == 1) {
        warrior4 = true;
        battleCounter = 2;
        bonus = 2000;
        achievementIndex = 24; // WARRIOR 4
        println("WARRIOR4 UNLOCKED");
      }
    }
    stroke(255);
    stroke(255, 140, 0);
    if (kneeCounter == 15) {
      giveNotice(); // "alert hostile detected, lethal force authorized for all units"
    }
    if (kneeCounter >=16) {
      kneeCounter = 0;
    }
  }

  // Karate KICK warrior 5
  if (leftFoot.y > leftKnee.y || rightFoot.y > leftKnee.y) {
    kickCounter++;
    score += kickCounter * scoreMod;
    achievementIndex = 20;
    if (warrior5 == false) {
      if (battleCounter == 3) {
        warrior5 = true;
        battleCounter = 4;
        bonus = 2500;
        achievementIndex = 25; // WARRIOR 5
        println("WARRIOR5 UNLOCKED");
      }
    }
    stroke(255);
    stroke(255, 140, 0);
    if (kickCounter == 20) {
      stroke(255);
      stroke(192, 192, 192); // silver
      lockingOn(); //"Locking on. Firing"
      scoreMod = scoreMod * 2;
      achievementIndex = 8;
    } else if (kickCounter == 40) {
      stroke(255);
      stroke(192, 192, 192); // silver
      giveTheMini();
      score -=25000;
      bonus = -25000;
      miniCounter ++;
    } else if (kickCounter == 70) {
      stroke(255);
      stroke(192, 192, 192); // silver
      giveTheMini();
      score -=25000;
      bonus = -25000;
      miniCounter ++;
    } else if (kickCounter == 110) {
      stroke(255);
      stroke(192, 192, 192); // silver
      giveTheGat();
      score -=100000;
      bonus = -100000;
      gatCounter ++;
    }

    if (kickCounter >= 111) {
      kickCounter = 0;
    }
    // println("Kicks: " + kickCounter);
  }

  // hands up, buster. Reach for the sky
  if (leftElbow.y > leftShoulder.y && rightElbow.y > rightShoulder.y && leftElbow.x < leftShoulder.x && rightElbow.x > rightShoulder.x) {
    handsUpCounter++;
    if (hacker1 == false) {
      hacker1 = true;
      achievementIndex = 9;
    }
    if (handsUpCounter == 2) {
      moveAlongPlease(); // "Move along please"
      stroke(255);
      stroke(0, 0, 255);
      scoreMod = 10;
      achievementIndex = 5;
    } else if (handsUpCounter == 60) {
      alrtNonComNoSafe(); // "alert non combatant safety cannot be guaranteed"
      stroke(255);
      stroke(255, 255, 0);
      scoreMod = 1;
      achievementIndex = 4;
    } else if (handsUpCounter == 120) {
      moveAlongPlease(); // "Move along please"
      stroke(255);
      stroke(0, 0, 255);
      score -= 100;
      bonus = -100;
    }
    if (handsUpCounter >= 121) {
      handsUpCounter = 0;
    }
  }

  // blank cond for the HACKER while he lowers right arm to salute for hacker2, just holds hacker1 boolean in place
  if (leftElbow.y > leftShoulder.y && leftHand.y > leftElbow.y && leftElbow.x < leftShoulder.x) {
    if (hacker1 == true) {
      hacker1 = hacker1;
    } else {
      hacker1 = false;
    }
  }


  // long right handed salute will get memory access (Hacker)
  if (rightElbow.y < rightShoulder.y && rightElbow.x > rightShoulder.x && rightHand.x < rightElbow.x &&
    rightHand.x < rightElbow.x) {
    if (rightHand.y > rightElbow.y && leftHand.y < leftElbow.y && leftHand.y < leftHip.y) {
      infoCounter++;
      score += infoCounter * scoreMod;
      if (infoCounter == 1) {
        standClear(); // "Non combatants are advised to stand clear of weapons discharge"
        stroke(255);
        stroke(0, 0, 255);
        scoreMod = scoreMod * 2;
        achievementIndex = 8;
      } else  if (infoCounter == 60) {
        giveInfo(); //  "Please continue along, if you have any questions, seek an information kiosk officer at any one of the stations."
        stroke(255);
        stroke(0, 255, 0);
        score += 25000;
        bonus = 25000;
        println("A HACKER has tricked their way past the Sentry!");
        achievementIndex = 7;
        if (hacker1 == true) {
          if (hacker2 == false) {
            //  println("That's it! Now get in the maniframe and hack the code!");
            achievementIndex = 6;
            hacker2 = true;
          }
        }
      }
      if (infoCounter >= 150) {
        infoCounter = 0;
      }
    }
  }

  // hands behind head like arrested
  if (leftElbow.y > leftShoulder.y && leftElbow.x < leftShoulder.x && leftHand.y < leftElbow.y && leftHand.x > leftElbow.x 
    && leftHand.y > torso.y && leftHand.y < head.y && 
    rightElbow.y > rightShoulder.y && rightElbow.x > rightShoulder.x && rightHand.y < rightElbow.y && rightHand.x < rightElbow.x 
    && rightHand.y > torso.y && rightHand.y < head.y) {
    arrestCounter++;
    score -= arrestCounter * scoreMod;
    stroke(255);
    stroke(0, 255, 0);
    if (arrestCounter == 2) {
      moveAlongPlease();
      scoreMod = 10;
      achievementIndex = 5;
    } else if (arrestCounter == 4) {
      moveAlongPlease(); // "Move along please"
      score -= 1000;
      bonus = -1000;
    } else if (arrestCounter == 6) {
      hostTarLockGrn(); // "hostile target detected, target lock status, green"
      scoreMod = 1;
      //  println("SCORE BONUS LOST!! OH NO!!");
      achievementIndex = 4;
    }
    if (arrestCounter >= 7) {
      arrestCounter = 0;
    }
  }

  //draw limb from head to neck
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_HEAD, SimpleOpenNI.SKEL_NECK);
  //draw limb from neck to left shoulder
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_LEFT_SHOULDER);
  //draw limb from left shoulde to left elbow
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_LEFT_ELBOW);
  //draw limb from left elbow to left hand
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_ELBOW, SimpleOpenNI.SKEL_LEFT_HAND);
  //draw limb from neck to right shoulder
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_NECK, SimpleOpenNI.SKEL_RIGHT_SHOULDER);
  //draw limb from right shoulder to right elbow
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_RIGHT_ELBOW);
  //draw limb from right elbow to right hand
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_ELBOW, SimpleOpenNI.SKEL_RIGHT_HAND);
  //draw limb from left shoulder to torso
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  //draw limb from right shoulder to torso
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_SHOULDER, SimpleOpenNI.SKEL_TORSO);
  //draw limb from torso to left hip
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_LEFT_HIP);
  //draw limb from left hip to left knee
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_HIP, SimpleOpenNI.SKEL_LEFT_KNEE);
  //draw limb from left knee to left foot
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_LEFT_KNEE, SimpleOpenNI.SKEL_LEFT_FOOT);
  //draw limb from torse to right hip
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_TORSO, SimpleOpenNI.SKEL_RIGHT_HIP);
  //draw limb from right hip to right knee
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_HIP, SimpleOpenNI.SKEL_RIGHT_KNEE);
  //draw limb from right knee to right foot
  kinect.drawLimb(userId, SimpleOpenNI.SKEL_RIGHT_KNEE, SimpleOpenNI.SKEL_RIGHT_FOOT);
} 

void onNewUser(SimpleOpenNI kinect, int userId) {
  kinect.startTrackingSkeleton(userId);
  pauseIdle();
  if (userId > 0 && userId < 13) {
    if (idleCounter == 0 || idleCounter == 3 || idleCounter == 8) {
      addingTarget();  // "adding target to threat matrix"
    } else if (idleCounter == 1 || idleCounter == 9 ) {
      weaponsLocked(); // "Weapon systems locked on"
    } else if (idleCounter == 5 || idleCounter == 11) {
      hostDetNeutralize(); // "Hostile detected. Commencing neutralization
    } else if (idleCounter == 7 || idleCounter == 15) {
      watchingYou(); // "Threat analysis yellow, scanning for hostiles"
    } else if (idleCounter >= 16) {
      idleCounter = 0;
    }
  }
  idleCounter ++;
}

/*---------------------------------------------------------------
 Print when user is lost. Input is int userId of user lost
 ----------------------------------------------------------------*/

void onLostUser(SimpleOpenNI kinect, int userId) {
  // print user lost and user id
  // println("User Lost - userId: " + userId);
  pauseIdle();
  threatGrnPatrolPat(); // "Threat analysis green. Resuming normal patrol pattern"
  // println("target lost " );
}

/*---------------------------------------------------------------
 Called when a user is tracked.
 ----------------------------------------------------------------*/

void onVisibleUser(SimpleOpenNI kinect, int userId) {
} 


// -----------------------------------------------------------------
// hand events

void onNewHand(SimpleOpenNI curkinect, int handId, PVector pos)
{
  pauseIdle();
  // println("onNewHand - handId: " + handId + ", pos: " + pos);

  ArrayList<PVector> vecList = new ArrayList<PVector>();
  vecList.add(pos);

  handPathList.put(handId, vecList);
}

int hh =-1;
boolean a=false;
boolean sameGuy; 
void onTrackedHand(SimpleOpenNI curkinect, int handId, PVector pos)
{
  pauseIdle();
  // println("handId: " + handId + ", pos: " + pos );
  ArrayList<PVector> vecList = handPathList.get(handId);
  if (vecList != null)
  {
    vecList.add(0, pos);
    if (vecList.size() >= handVecListSize)
      // remove the last point 
      vecList.remove(vecList.size()-1);
  }  
  hh = handId;
}

void onLostHand(SimpleOpenNI curkinect, int handId)
{
  //  println("onLostHand - handId: " + handId);
  handPathList.remove(handId);
}

// -----------------------------------------------------------------
// gesture events where gesture type 0 is wave, 1 is telekinetic rage
// fix could this return boolean memseeker after time ourt like the ske tracker?
void onCompletedGesture(SimpleOpenNI curkinect, int gestureType, PVector pos)
{
  if (gestureType == 1) {
    gestureTypeA = true;
  } else {
    gestureTypeA = false;
  }
  if (gestureType == 0) {
    gestureTypeB = true;
  } else {
    gestureTypeB = false;
  }
  /* All gestureType does is notify either wave or press routines */
  if (gestureTypeA == true) {
    score = scoreMod * hadoukenCounter;
    if (hadoukenCounter <= 2 ) {
      hadoukenCounter++;
      hadouken();
      characterIndex = 6; // on the path of a ROGUE
    } else if (hadoukenCounter == 3) {
      hadoukenCounter++;
      hadouken();
      println("Disengaging Brain ");
      sysFailure();// "Warning, system failure imminent"
    } else if (hadoukenCounter >= 4) {
      println("Critical error, Sentry shutting down ");
      sysFailureShutdown();// "Warning...whirr...primary systems offline...systems fail"
      hadoukenCounter++;
      hadouken();
      characterIndex = 2;
      scoreMod = 1000;
      rogue = true;
    }
  }

  // waving inputs
  if (sameGuy == true) {
    println("same SPELLCASTER" );
    println("a = ", a, " sameGuy =", sameGuy, " hh: ", hh, " handId: ", handId);
    println("");
    if (gestureTypeB == true) {
      waveCounter++;
      println("wavecounter: " + waveCounter);
      if (waveCounter > 0) {
        ark();
      }
      if (waveCounter == 1) {
        playRADIO();
      } else if (waveCounter == 3) {
        characterIndex = 7; // on path to SPELLCASTER
        playEMF();
      } else if (waveCounter == 5 ) {
        standingDown();
      } else if (waveCounter >= 7) {
        achievementIndex = 31;
        characterIndex = 3;
        scoreMod = 1000;
        spellcaster = true;
      }
    }
  } else if (sameGuy == false) {
    println("new SPELLCASTER");
    println("a = ", a, " sameGuy =", sameGuy, " hh: ", hh, " handId: ", handId);
    println("");
    waveCounter = waveCounter = 0;
  }

  kinect.startGesture(SimpleOpenNI.GESTURE_CLICK);
  handId = kinect.startTrackingHand(pos);
  a=!a;
  if (a) {
    handId = kinect.startTrackingHand(pos);
    sameGuy = true;
  } else kinect.stopTrackingHand(hh);
  sameGuy = false;
}

void useHands() {
  kinect.update();
  // draw the tracked hands
  if (handPathList.size() > 0)  
  {    
    Iterator itr = handPathList.entrySet().iterator();     
    while (itr.hasNext ())
    {
      sameGuy = true;
      Map.Entry mapEntry = (Map.Entry)itr.next(); 
      int handId =  (Integer)mapEntry.getKey();
      ArrayList<PVector> vecList = (ArrayList<PVector>)mapEntry.getValue();
      PVector p;
      PVector p2d = new PVector();

      stroke(userClr[ (handId - 1) % userClr.length ]);
      noFill(); 
      strokeWeight(1);        
      Iterator itrVec = vecList.iterator(); 
      beginShape();
      while ( itrVec.hasNext () ) 
      { 
        p = (PVector) itrVec.next(); 

        kinect.convertRealWorldToProjective(p, p2d);
        vertex(p2d.x, p2d.y);
      }
      endShape();   

      stroke(userClr[ (handId - 1) % userClr.length ]);
      strokeWeight(4);
      p = vecList.get(0);
      kinect.convertRealWorldToProjective(p, p2d);
      point(p2d.x, p2d.y);
    }
  }
}
/*---------------------------------------------------------------------------------------
 ---------------------------------------------------------------------------------------
 END OF SKELETON TRACKING AND GESTURE RECOGNITION FUNCTIONS
 ---------------------------------------------------------------------------------------
 --------------------------------------------------------------------------------------- */
