
/********************************************************************
 ******************* START AUDIO FUNCTIONS *************************
 ********************************************************************/

// called in initial detect (userId)
void addingTarget() {
  onlyAddingTarget();
  if (!threatMatrix.isPlaying()) { // "Adding target to threat matrix" -- use this on initial detect
    threatMatrix.rewind();
    threatMatrix.play();
    myPort.write('j');
  }
}

// skeleton event, ie pose triggered
void alrtHostiles() { 
  onlyAlrtHostiles();
  if (!alrtHostiles.isPlaying()) { // "Alert, hostiles in area"
    alrtHostiles.rewind();
    alrtHostiles.play();
    myPort.write('p');
  }
} 

// skeleton event, ie triggered pose
void alrtNonComNoSafe() {
  onlyAlrtNonComNoSafe();
  if (!alrtNonComNoSafe.isPlaying()) { // "alert non combatant safety cannot be guaranteed"
    alrtNonComNoSafe.rewind();
    alrtNonComNoSafe.play();
    myPort.write('j');
  }
} 

// Arduino triggered idle track
void alrtNoWarning() { // "alert, non combatants are advised to leave the area. Security sweep in progress. Lethal force may be used without warning."
  onlyAlrtNoWarning();
  if (!alrtNoWarning.isPlaying()) { //  "Please continue along, if you have any questions, seek an information kiosk officer at any one of the stations."
    alrtNoWarning.rewind();
    alrtNoWarning.play();
    myPort.write('j');
  }
}

void ark() {
  if (!arc.isPlaying()) { 
    arc.rewind();
    arc.play();
  }
}

void engage() {
  onlyEngage();
  if (!engage.isPlaying()) {
    engage.rewind();
    engage.play();
  }
}

void enterUpside() {
  myPort.write('u'); // should put arduino into while loop to hold chars and stop movement
}

void exitUpside() {
  myPort.write('h'); // should resume chars from arduino
}

// skeleton event, ie pose triggered
void giveInfo() {
  onlyGiveInfo();
  if (!sentrySeekInfoOfficer.isPlaying()) { //  "Please continue along, if you have any questions, seek an information kiosk officer at any one of the stations."
    sentrySeekInfoOfficer.rewind();
    sentrySeekInfoOfficer.play();
    myPort.write('i');
  }
}
// fix this sholudnt ewind after coming out of transitions and mems
// skeleton event, ie pose triggered
void giveTheGat() {
  if (!sentryMiniGatOhYeah.isPlaying()) { //BRRRRRRRAAAAAAAPPPPP!!!!!
    onlyGiveTheGat();
    sentryMiniGatOhYeah.rewind();
    sentryMiniGatOhYeah.play();
    myPort.write('x');
    myPort.write('\n');
  }
}
void giveTheMini() {
  if (!minigun.isPlaying()) { //BRRRRRRRAAAAAAAPPPPP!!!!!
    onlyMinigun();
    minigun.rewind();
    minigun.play();
    myPort.write('x');
    myPort.write('\n');
  }
}
// skeleton event, ie pose triggered
void giveWarning() {
  onlyGiveWarning();
  if (!threatRedWeaponsFree.isPlaying()) { // "Threat analysis red, weapons free"
    threatRedWeaponsFree.rewind();
    threatRedWeaponsFree.play();
    myPort.write('p');
  }
}
// skeleton event, ie pose triggered
void giveNotice() {
  onlyGiveNotice();
  if (!hostDetLethForce.isPlaying()) { // "alert hostile detected, lethal force authorized for all units"
    hostDetLethForce.rewind();
    hostDetLethForce.play();
  }
}
void hadouken() {
  if (!hadouken.isPlaying()) { 
    hadouken.rewind();
    hadouken.play();
  }
}
// called in initial detect (userId)
void hostDetNeutralize() {
  onlyHostDetNeutralize();
  if (!hostDetNeutralize.isPlaying()) { // "Hostile detected. Commencing neutralization."
    hostDetNeutralize.rewind();
    hostDetNeutralize.play();
  }
}
// skeleton event, ie pose triggered
void hostTarLockGrn() {
  onlyHostTarLockGrn();
  if (!hostTarLockGrn.isPlaying()) { // "hostile target detected, target lock status, green"
    hostTarLockGrn.rewind();
    hostTarLockGrn.play();
    myPort.write('j');
  }
}

// skeleton event, ie pose triggered
void lockingOn() {
  onlyLockingOn();
  if (!lockingOn.isPlaying()) { //"Locking on. Firing"
    lockingOn.rewind();
    lockingOn.play();
  }
}

// skeleton event, ie pose triggered
void moveAlongPlease() {   //  "Move Along Please"
  onlyMoveAlong();
  if (!moveAlongPlease.isPlaying()) {
    moveAlongPlease.rewind();
    moveAlongPlease.play();
  }
}
// fix, rewind logically comes after, maybe it helps top them too?
void playCB() {
  if (!cb.isPlaying()) {
    cb.rewind();
    cb.play();
  }
}
void playEMF() {
  if (!emf.isPlaying()) {
    emf.rewind();
    emf.play();
  }
}
void playRADIO() {
  if (!radio.isPlaying()) {
    radio.rewind();
    radio.play();
  }
}
void playTELE() {
  if (!tele.isPlaying()) {
    tele.rewind();
    tele.play();
  }
}
void playUpside() {
  onlyUpside();
  if (!upsideDown.isPlaying()) {
    upsideDown.rewind();
    upsideDown.play();
  }
}

void playUpsideLow() {
  if (!upsideLow.isPlaying()) {
    upsideLow.rewind();
    upsideLow.play();
  }
}
// skeleton event, ie pose triggered
void standClear() {
  onlyStandClear();
  if (!standClear.isPlaying()) { // "Non combatants are advised to stand clear of weapons discharge"
    standClear.rewind();
    standClear.play();
  }
}
void standingDown()
{
  sysFailure.pause();
  sysFailureShutdown.pause();
  pauseAll();
  if (!standingDown.isPlaying()) { // "Threat analysis green, standing down"
    standingDown.rewind();
    standingDown.play();
  }
}
void sysFailure() {
  // pause other two hand events
  standingDown.pause();
  sysFailureShutdown.pause();
  pauseAll();
  if (!sysFailure.isPlaying()) { // "Warning, system failure imminent"
    sysFailure.rewind();
    sysFailure.play();
  }
}
void sysFailureShutdown() {
  // pause other two hand events
  standingDown.pause();
  sysFailure.pause();
  pauseAll();
  if (!sysFailureShutdown.isPlaying()) { // "Warning...whirr...primary systems offline...systems fail"
    sysFailureShutdown.rewind();
    sysFailureShutdown.play();
  }
}
// used on lost user
void threatGrnPatrolPat() {
  pauseIdle();
  if (!threatGrnPatrolPat.isPlaying()) { // "Threat analysis green. Resuming normal patrol pattern"
    threatGrnPatrolPat.rewind();
    threatGrnPatrolPat.play();
  }
}
// called in initial detect (userId)
void watchingYou() { // "Threat analysis yellow, scanning for hostiles"
  onlyWatchingYou();
  if (!yelScanHostiles.isPlaying()) {
    yelScanHostiles.rewind();
    yelScanHostiles.play();
  }
}
// called in initial detect (userId)
void weaponsLocked() { // "Weapon systems locked on"
  onlyWeaponsLocked();
  if (!weaponsLocked.isPlaying()) { // "Non combatants are advised to stand clear of weapons discharge"
    weaponsLocked.rewind();
    weaponsLocked.play();
  }
}

/* FUNCTIONS TO SILENCE OTHER TRACKS */


// used in hand signal sequences, pause all incl. pauseIdle
void pauseAll() {
  // pause all idles
  alrtNoWarning.pause();
  lethForceImminent.pause();
  noGunsAllowed.pause();
  noHostilesDetected.pause();
  noHostiles.pause();
  targetLost.pause();
  threatGrnPatrolPat.pause();
  // pause all normal gesture events, except death
  alrtNonComNoSafe.pause();
  alrtHostiles.pause();
  alrtNoWarning.pause();
  hostTarLockGrn.pause();
  lockingOn.pause();
  minigun.pause();
  moveAlongPlease.pause();
  standClear.pause();
  threatMatrix.pause();
  threatRedWeaponsFree.pause();
  hostDetLethForce.pause();
  sentryMiniGatOhYeah.pause();
  sentrySeekInfoOfficer.pause();
  hostDetNeutralize.pause();
  weaponsLocked.pause();
  yelScanHostiles.pause();
}

void pauseEngage() {
  engage.pause();
}
// used in pauseQuiet, below
void pauseGestures() {
  alrtNonComNoSafe.pause();
  alrtHostiles.pause();
  alrtNoWarning.pause();
  hostTarLockGrn.pause();
  lockingOn.pause();
  minigun.pause();
  moveAlongPlease.pause();
  standClear.pause();
  threatMatrix.pause();
  threatRedWeaponsFree.pause();
  hostDetLethForce.pause();
  sentryMiniGatOhYeah.pause();
  sentrySeekInfoOfficer.pause();
  hostDetNeutralize.pause();
  weaponsLocked.pause();
  yelScanHostiles.pause();
}
void pauseQuiet(){
pauseHotpoints();
pauseIdle();
pauseGestures();
   upsideDown.pause();
    // upsideLow.pause();
}
void pauseHotpoints() {
  cb.pause();
  emf.pause();
  radio.pause();
  tele.pause();
}
// pause the Arduino driven idle in serial event at bottom
void pauseIdle() {
  alrtNoWarning.pause();
  lethForceImminent.pause();
  noGunsAllowed.pause();
  noHostilesDetected.pause();
  noHostiles.pause();
  targetLost.pause();
  threatGrnPatrolPat.pause();
}

void pauseUpside() {
  upsideDown.pause();
}

void pauseUpsideLow() {
  upsideLow.pause();
}

// gesture-specific silencers
void onlyAlrtHostiles() {
  // everything but alrtHostiles
  alrtNonComNoSafe.pause();
  alrtNoWarning.pause();
  hostTarLockGrn.pause();
  lockingOn.pause();
  moveAlongPlease.pause();
  standClear.pause();
  threatMatrix.pause();
  threatRedWeaponsFree.pause();
  hostDetLethForce.pause();
  sentryMiniGatOhYeah.pause();
  sentrySeekInfoOfficer.pause();
  hostDetNeutralize.pause();
  weaponsLocked.pause();
  yelScanHostiles.pause();

  pauseIdle();
}

void onlyAlrtNonComNoSafe() {
  // everything but alrtNonComNoSafe
  alrtHostiles.pause();
  alrtNoWarning.pause();
  hostTarLockGrn.pause();
  lockingOn.pause();
  moveAlongPlease.pause();
  standClear.pause();
  threatMatrix.pause();
  threatRedWeaponsFree.pause();
  hostDetLethForce.pause();
  sentryMiniGatOhYeah.pause();
  sentrySeekInfoOfficer.pause();
  hostDetNeutralize.pause();
  weaponsLocked.pause();
  yelScanHostiles.pause();

  pauseIdle();
}

void onlyAlrtNoWarning() {
  // everything but alrtNoWarning
  alrtHostiles.pause();
  alrtNonComNoSafe.pause();
  hostDetLethForce.pause();
  hostTarLockGrn.pause();
  lockingOn.pause();
  moveAlongPlease.pause();
  sentryMiniGatOhYeah.pause();
  sentrySeekInfoOfficer.pause();
  standClear.pause();
  threatMatrix.pause();
  threatRedWeaponsFree.pause();
  hostDetNeutralize.pause();
  weaponsLocked.pause();
  yelScanHostiles.pause();

  pauseIdle();
}

void onlyAddingTarget() {
  // everything but threatMatrix
  alrtHostiles.pause();
  alrtNonComNoSafe.pause();
  alrtNoWarning.pause();
  hostDetLethForce.pause();
  hostTarLockGrn.pause();
  lockingOn.pause();
  moveAlongPlease.pause();
  sentryMiniGatOhYeah.pause();
  sentrySeekInfoOfficer.pause();
  standClear.pause();
  threatRedWeaponsFree.pause();
  hostDetNeutralize.pause();
  weaponsLocked.pause();
  yelScanHostiles.pause();

  pauseIdle();
}

void onlyGiveInfo() {
  // everything but sentrySeekInfoOfficer
  alrtHostiles.pause();
  alrtNonComNoSafe.pause();
  alrtNoWarning.pause();
  hostDetLethForce.pause();
  hostTarLockGrn.pause();
  lockingOn.pause();
  moveAlongPlease.pause();
  sentryMiniGatOhYeah.pause();
  standClear.pause();
  threatMatrix.pause();
  threatRedWeaponsFree.pause();
  hostDetNeutralize.pause();
  weaponsLocked.pause();
  yelScanHostiles.pause();

  pauseIdle();
}
void onlyEngage() {
  pauseUpside();
  pauseAll();
}
void onlyGiveNotice() {
  // everything but hostDetLethForce
  alrtHostiles.pause();
  alrtNonComNoSafe.pause();
  alrtNoWarning.pause();
  hostTarLockGrn.pause();
  lockingOn.pause();
  moveAlongPlease.pause();
  sentryMiniGatOhYeah.pause();
  sentrySeekInfoOfficer.pause();
  standClear.pause();
  threatMatrix.pause();
  threatRedWeaponsFree.pause();
  hostDetNeutralize.pause();
  weaponsLocked.pause();
  yelScanHostiles.pause();

  pauseIdle();
}

void onlyGiveTheGat() {
  // everything but sentryMiniGatOhYeah
  alrtHostiles.pause();
  alrtNonComNoSafe.pause();
  alrtNoWarning.pause();
  hostDetLethForce.pause();
  hostTarLockGrn.pause();
  lockingOn.pause();
  moveAlongPlease.pause();
  sentrySeekInfoOfficer.pause();
  standClear.pause();
  threatMatrix.pause();
  threatRedWeaponsFree.pause();
  hostDetNeutralize.pause();
  weaponsLocked.pause();
  yelScanHostiles.pause();

  pauseIdle();
}

void onlyGiveWarning() {
  // everything but threatRedWeaponsFree
  alrtHostiles.pause();
  alrtNonComNoSafe.pause();
  alrtNoWarning.pause();
  hostDetLethForce.pause();
  hostTarLockGrn.pause();
  lockingOn.pause();
  moveAlongPlease.pause();
  sentryMiniGatOhYeah.pause();
  sentrySeekInfoOfficer.pause();
  standClear.pause();
  threatMatrix.pause();
  hostDetNeutralize.pause();
  weaponsLocked.pause();
  yelScanHostiles.pause();

  pauseIdle();
}

void onlyHostTarLockGrn() {
  // everything but onlyHostTarLockGrn
  alrtHostiles.pause();
  alrtNonComNoSafe.pause();
  alrtNoWarning.pause();
  lockingOn.pause();
  moveAlongPlease.pause();
  hostDetLethForce.pause();
  sentryMiniGatOhYeah.pause();
  sentrySeekInfoOfficer.pause();
  standClear.pause();
  threatMatrix.pause();
  threatRedWeaponsFree.pause();
  hostDetNeutralize.pause();
  weaponsLocked.pause();
  yelScanHostiles.pause();

  pauseIdle();
}

void onlyLockingOn() {
  //everything but lockingOn, this is only one to preclude sentryMiniGun since it comes first in firing sequence
  alrtHostiles.pause();
  alrtNonComNoSafe.pause();
  alrtNoWarning.pause();
  hostTarLockGrn.pause();
  moveAlongPlease.pause();
  standClear.pause();
  threatMatrix.pause();
  threatRedWeaponsFree.pause();
  hostDetLethForce.pause();
  // sentryMiniGatOhYeah.pause();
  sentrySeekInfoOfficer.pause();
  hostDetNeutralize.pause();
  weaponsLocked.pause();
  yelScanHostiles.pause();

  pauseIdle();
}

void onlyMinigun(){
  lockingOn.pause();
  alrtHostiles.pause();
  alrtNonComNoSafe.pause();
  alrtNoWarning.pause();
  hostTarLockGrn.pause();
  moveAlongPlease.pause();
  standClear.pause();
  threatMatrix.pause();
  threatRedWeaponsFree.pause();
  hostDetLethForce.pause();
  sentryMiniGatOhYeah.pause();
  sentrySeekInfoOfficer.pause();
  hostDetNeutralize.pause();
  weaponsLocked.pause();
  yelScanHostiles.pause();

  pauseIdle();
}

void onlyMoveAlong() {
  // everything but moveAlongPlease
  alrtHostiles.pause();
  alrtNonComNoSafe.pause();
  alrtNoWarning.pause();
  hostTarLockGrn.pause();
  lockingOn.pause();
  standClear.pause();
  threatMatrix.pause();
  threatRedWeaponsFree.pause();
  hostDetLethForce.pause();
  sentryMiniGatOhYeah.pause();
  sentrySeekInfoOfficer.pause();
  hostDetNeutralize.pause();
  weaponsLocked.pause();
  yelScanHostiles.pause();

  pauseIdle();
}

void onlyStandClear() {
  // everything but standClear
  alrtHostiles.pause();
  alrtNonComNoSafe.pause();
  alrtNoWarning.pause();
  hostTarLockGrn.pause();
  lockingOn.pause();
  moveAlongPlease.pause();
  threatMatrix.pause();
  threatRedWeaponsFree.pause();
  hostDetLethForce.pause();
  sentryMiniGatOhYeah.pause();
  sentrySeekInfoOfficer.pause();
  hostDetNeutralize.pause();
  weaponsLocked.pause();
  yelScanHostiles.pause();

  pauseIdle();
}

void onlyHostDetNeutralize() {
  // everything but hostDetNeutralize
  alrtHostiles.pause();
  alrtNonComNoSafe.pause();
  alrtNoWarning.pause();
  hostTarLockGrn.pause();
  lockingOn.pause();
  moveAlongPlease.pause();
  standClear.pause();
  hostDetLethForce.pause();
  sentryMiniGatOhYeah.pause();
  sentrySeekInfoOfficer.pause();
  threatMatrix.pause();
  threatRedWeaponsFree.pause();
  weaponsLocked.pause();
  yelScanHostiles.pause();

  pauseIdle();
}

// USD BG music
void onlyUpside() {
  pauseAll();
  engage.pause();
}


void onlyWatchingYou() {
  // everything but yelScanHostiles
  alrtHostiles.pause();
  alrtNonComNoSafe.pause();
  alrtNoWarning.pause();
  hostTarLockGrn.pause();
  lockingOn.pause();
  moveAlongPlease.pause();
  standClear.pause();
  threatMatrix.pause();
  threatRedWeaponsFree.pause();
  hostDetLethForce.pause();
  sentryMiniGatOhYeah.pause();
  sentrySeekInfoOfficer.pause();
  hostDetNeutralize.pause();
  weaponsLocked.pause();

  pauseIdle();
}

void onlyWeaponsLocked() {
  // everything but weapons locked
  alrtHostiles.pause();
  alrtNonComNoSafe.pause();
  alrtNoWarning.pause();
  hostTarLockGrn.pause();
  lockingOn.pause();
  moveAlongPlease.pause();
  standClear.pause();
  hostDetLethForce.pause();
  sentryMiniGatOhYeah.pause();
  sentrySeekInfoOfficer.pause();
  hostDetNeutralize.pause();
  threatMatrix.pause();
  threatRedWeaponsFree.pause();
  yelScanHostiles.pause();

  pauseIdle();
}

/***************************************************************************************************
 ********************   END AUDIO FUNCTIONS  ******************************************************
 **************************************************************************************************/

