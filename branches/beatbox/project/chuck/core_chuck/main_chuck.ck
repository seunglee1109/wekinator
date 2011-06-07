/* Main ChucK wekinator glue.
*/

TrackpadFeatureExtractor trackpadFE;
MotionFeatureExtractor motionFE;
AudioFeatureExtractor audioFE;
ProcessingFeatureExtractor processingFE;
CustomFeatureExtractor customFE;
//CustomOSCFeatureExtractor oscCustomFE;

//The rate at which features will be extracted: edit this!
//(note this is also like the "hop size")
50::ms => dur rate;

//The rate at which the synth should send params back in playalong mode
100::ms => dur synthParamRate;

//The class that does your synthesis gets to decide
//what parameters it wants
new SynthClass @=> SynthClass mc;
mc.setup();
mc.getNumParams() => int numParams;
mc.useDistributionArray() @=> int wantDistArray[];
mc.isDiscreteArray() @=> int isDiscreteArray[];
mc.getNumClassesArray() @=> int numClassesArray[];
mc.getParamNamesArray() @=> string paramNamesArray[];
customFE.getFeatureNamesArray() @=> string customNamesArray[];
<<< "Chuck done setting up synth class">>>;
//Keep track of feature sources
0 => int useAudio;
0 => int useTrackpadXY;
0 => int useMotionXYZ;
0 => int useOtherHid; //TODO: set to # of other hids
2 => int otherDevice; //device ID: should be 0 or maybe 1
0 => int useProcessing; //get features from processing (webcam) too?
0 => int useCustom;

//OSC setup
6448 => int sendport;
6453 => int recvport;
"localhost" => string hostname;
OscSend xmit;
OscRecv recv;
recvport => recv.port;

//Set up receiver
recv.listen();
<<< "ChucK listening on port ", recvport>>>;

//Some standard events
recv.event("/control", "s i") @=> OscEvent oscControl;
recv.event("/useAudioFeature", "i i i i i i i i i i") @=> OscEvent oscUseAudio;
recv.event("/useFeatureList", "i i i i i i i i i i i i i i i i") @=> OscEvent oscUseFeatureList;

OscEvent oscParams;

0 => int paramArraySize;
"" => string s2;
for (0 => int i; i < numParams; i++) {
	if (isDiscreteArray[i] && wantDistArray[i]) {
		paramArraySize + numClassesArray[i] => paramArraySize;
		for (0 => int j; j < numClassesArray[i]; j++) {
			s2 + "f" => s2;
			if (j != numClassesArray[i] - 1) {
				s2 + " " => s2;
			}
		}
	} else {
		s2 + "f" => s2;
		paramArraySize++;
	}

	if (i != numParams-1) {
		s2 + " " => s2;
	}
}
recv.event("/params", s2) @=> oscParams;
spork ~oscParamsWait();

//Will get set automatically later on
int numFeats;

HidDiscoverer hd; //make sure we can open it first before

	new HidDiscoverer @=> hd;
	if (hd.init(otherDevice)) {
		<<< "Found HID device at ", otherDevice >>>;
	} 
	else if (hd.init(2)) {
		<<< "Found HID device at 2">>>;
		2 => otherDevice;
	} else if (hd.init(1)) {
		<<< "Found HID device at 1">>>;
		1 => otherDevice;
	}  else if (hd.init(0)) {
		<<< "Found HID device at 0">>>;
		0 => otherDevice;
	} else {
		<<< "Couldn't find other HID" >>>;
		0 => useOtherHid;
	}

OscEvent oscHidSetup;
OscEvent oscHidSetupStop;
OscEvent oscHidInit;
OscEvent oscHidRun;
OscEvent oscHidSettingsRequest;
OscEvent oscHidInitAll;

recv.event("/hidSetup", "i") @=> oscHidSetup;
recv.event("/hidSetupStop", "i") @=> oscHidSetupStop;
recv.event("/hidSettingsRequest", "i") @=> oscHidSettingsRequest;
//give # of axes, buttons, hats
recv.event("/hidInit", "i i i") @=> oscHidInit;
recv.event("/hidRun", "i") @=> oscHidRun;

// aim the transmitter
xmit.setHost( hostname, sendport );
mc.setOscHostAndPort(hostname, sendport);
0 => int isExtracting;

//Set up the player, for playalong learning
new ScorePlayer @=> ScorePlayer sp;
sp.setup(mc, xmit);

//Spork OSC shreds
spork ~oscUseAudioWait();
spork ~oscControlWait();
spork ~oscUseFeatureListWait();

//chuck can init handshake too!
receivedHello();
spork ~oscHidSetupWait();
spork ~oscHidSetupStopWait();
spork ~oscHidInitWait();
spork ~oscHidRunWait();
spork ~oscHidSettingsRequestWait();

fun void oscControlWait() {
	string s;
	int i;
	while (true) {
	<<< "Chuck: Waiting for control messages" >>>;

		oscControl => now;
		<<< "Chuck: Control message received">>>;
		while (oscControl.nextMsg() != 0) {
			oscControl.getString() => s;
			oscControl.getInt() => i;
			<<< "S i ", s, i>>>;
			if (s == "hello") {
				receivedHello();
			} else if (s == "requestNumParams") {
				receivedRequestNumParams();
			} else if (s == "extract") {
				receivedExtract();
			} else if (s == "stop") {
				receivedStop();
			} else if (s == "realValueRequest") {
				receivedRealValueRequest();
			} else if (s == "requestChuckSettingsArrays") {
				receivedRequestSettingsArrays();
			} else if (s == "stopSound") {
				receivedStopSound();
			} else if (s == "startSound") {
				receivedStartSound();
			} else if (s == "startGettingParams") {
				receivedStartGettingParamsRequest();
			} else if (s == "stopGettingParams") {
				receivedStopGettingParamsRequest();
			} else if (s == "startPlayback") {
				receivedStartPlaybackRequest();
			} else if (s == "stopPlayback") {
				receivedStopPlaybackRequest();
			} else {
				<<< "Received unknown request ", s>>>;
			}
		}
	}
}

fun void receivedStopSound() {
	mc.silent();
}

fun void receivedStartSound() {
	mc.sound();
}

fun void receivedHello() {
	xmit.startMsg( "/hiback i");
	customFE.numFeatures() => xmit.addInt;
}

//Wait for the signal to enter into hid setup mode
fun void oscHidSetupWait() {
	while (true) {
		<<< "Waiting for hid setup">>>;
		oscHidSetup => now;
		while (oscHidSetup.nextMsg() != 0) {
			oscHidSetup.getInt();
		}
		xmit.startMsg( "/hidSetupBegun", "i");
		0 => xmit.addInt;
		<<< "Sent setup begun">>>;
		<<< "Entering hid setup mode">>>;
		spork ~hd.setup();

	}
}

fun void receivedRequestNumParams() {
	xmit.startMsg("/numParams", "i");
	numParams => xmit.addInt;	
}

fun void receivedRequestSettingsArrays() {
	<<< "ChucK: received request settings arrays">>>;
	"i i i" => string s; //# params, whether using chuck feat ext, # chuck feats
	
	for (0 => int j; j < 3; j++) { //wantDist + isDiscrete + numClasses
		for (0 => int i; i < numParams; i++) {
			s + " i" => s;
		}
	}
	for (0 => int i; i < numParams; i++) {
		s + " s" => s;
	}
	if (useCustom) {
		for (0 => int i; i < customFE.numFeatures(); i++) {
			s + " s" => s;
		}
	}	
	xmit.startMsg("/chuckSettingsArrays", s);
	numParams => xmit.addInt;
	//useOscCustom => xmit.addInt;
	useCustom => xmit.addInt; //HELP RAF BAD
	//oscCustomFE.numFeatures() => xmit.addInt;
	customFE.numFeatures() => xmit.addInt;

	for (0 => int i; i < wantDistArray.size(); i++) {
		wantDistArray[i] => xmit.addInt;
	}
	for (0 => int i; i < isDiscreteArray.size(); i++) {
		isDiscreteArray[i] => xmit.addInt;
	}
	for (0 => int i; i < numClassesArray.size(); i++) {
		numClassesArray[i] => xmit.addInt;
	}
	for (0 => int i; i < paramNamesArray.size(); i++) {
		paramNamesArray[i] => xmit.addString;
	}
	if (useCustom) {
		for (0 => int i; i < customFE.numFeatures(); i++) {
			customNamesArray[i] => xmit.addString;
		}
	}
	<<< "Chuck: Sent chuck settings array">>>;
}

fun void oscHidSetupStopWait() {
	while (true) {
	oscHidSetupStop => now;
	while (oscHidSetupStop.nextMsg() != 0) {
			oscHidSetupStop.getInt();
	}
	xmit.startMsg( "/hidSetupStopped", "i");
	0 => xmit.addInt;
	<<< "Exiting hid setup mode">>>;
		computeNumFeats();
	spork ~hd.stopSetupAndStartRun(); //chg 11/25
	<<< "Use hid? ", useOtherHid >>>;
	<<< "Using " + numFeats + " features total (make sure java knows)" >>>;
	}
}

int numHidAxes, numHidHats, numHidButtons;
float hidAxesInits[];
int hidHatsInits[];
int hidButtonsInits[];
int hidMaskInits[];
0 => int gotAxesInits => int gotHatsInits => int gotButtonsInits => int gotMaskInits;

fun void oscHidInitWait() {
	while (true) {	
	<<< "WAITING FOR HID INIT">>>;
	oscHidInit => now;
	<<< "GOT HID INIT OSCHIDINIT MSG">>>;
	int a, b,c;
	while (oscHidInit.nextMsg() != 0) {
		oscHidInit.getInt() => numHidAxes;
		new float[numHidAxes] @=> hidAxesInits;
		oscHidInit.getInt() => numHidHats;
		new int[numHidHats] @=> hidHatsInits;
		oscHidInit.getInt() => numHidButtons;
		new int[numHidButtons] @=> hidButtonsInits;
		new int[numHidAxes + numHidHats+ numHidButtons] @=> hidMaskInits;
	}
	
	if (numHidAxes == 0 && numHidHats == 0 && numHidButtons ==0) {
		<<< "NOTHING TO USE - NO OTHER HID">>>;
		0 => useOtherHid;
		return;
	}

	//Otherwise wait for a bunch of stuff!
	"i" => string s; //HACK
	for (0 => int i; i < numHidAxes; i++) {
		s + " f" => s;
	}	
	for (0 => int i; i < numHidHats; i++) {
		s + " i" => s;
	}
	for (0 => int i; i < numHidButtons; i++) {
		s + " i" => s;
	}
	for (0 => int i; i< numHidAxes + numHidHats + numHidButtons; i++) {
		s + " i" => s;
	}
	<<< "Going to wait for HIDINITALL with string ", s>>>;
	recv.event("/hidInitAll", s) @=> oscHidInitAll;
	spork ~oscHidInitAllWait();

	//Signal that it's ok to send these values now
	xmit.startMsg( "/sendHidInitValues", "i");
	0 => xmit.addInt;
  }
}

fun void oscHidRunWait() {
  while (true) {
	oscHidRun => now;
//	<<< "Got message to start extracting hid">>>;
	while (oscHidRun.nextMsg() != 0) {
			oscHidRun.getInt();
	}
	//<<< "Running HID controller">>>;
	spork ~hd.run(); 
  }
}

//New 11/25: Streamlined this.
fun void oscHidInitAllWait() {
	oscHidInitAll => now;	
	while (oscHidInitAll.nextMsg() != 0) {
		oscHidInitAll.getInt() => int dummy;

		for (0 => int i; i < numHidAxes; i++) {			
		
			oscHidInitAll.getFloat() => hidAxesInits[i];
		}

		for (0 => int i; i < numHidHats; i++) {			
			oscHidInitAll.getInt() => hidHatsInits[i];
		}

		for (0 => int i; i < numHidButtons; i++) {			
			oscHidInitAll.getInt() => hidButtonsInits[i];
		}

		for (0 => int i; i < hidMaskInits.size(); i++) {			
			oscHidInitAll.getInt() => hidMaskInits[i];
		}
	} 
	hd.initialize(hidAxesInits.size(), hidButtonsInits.size(), hidHatsInits.size(), hidAxesInits, hidButtonsInits, hidHatsInits, hidMaskInits);
	hd.run();
}

fun void oscHidSettingsRequestWait() {
  while (true) {
	oscHidSettingsRequest => now;
	//<<< "Received HID settings request ">>>;
	while (oscHidSettingsRequest.nextMsg() != 0) {
		oscHidSettingsRequest.getInt();
	}

	"i i i" => string s; //# axes, numHats, numButtons
	for (0 => int i; i < hd.getNumAxes(); i++) { //axes vals as f
		s + " f" => s;
	}
	for (0 => int i; i < hd.getNumHats(); i++) { //hat vals as i
		s + " i" => s;
	}
	for (0 => int i; i < hd.getNumButtons(); i++) { //buttons vals as i
		s + " i" => s;
	}
	hd.getMask() @=> int mask[];
	<<< "Mask length ", mask.size() >>>;
	for (0 => int i; i < mask.size(); i++) {
		s + " i" => s;
	}
	xmit.startMsg( "/hidSettingsAll", s);
<<< "Starting message ", s>>>;
	hd.getNumAxes() => xmit.addInt;
	hd.getNumHats() => xmit.addInt;
	hd.getNumButtons() => xmit.addInt;

	if (hd.getNumAxes() > 0) {
		hd.getAxesVals() @=> float vals[];
		for (0 => int i; i < vals.size(); i++) {
			vals[i] => xmit.addFloat;
		}
	}
	if (hd.getNumHats() > 0) {
		hd.getHatsVals() @=> int vals[];
		for (0 => int i; i < vals.size(); i++) {
			vals[i] => xmit.addInt;
		}
	}
	if (hd.getNumButtons() > 0) {
		hd.getButtonsVals() @=> int vals[];
		for (0 => int i; i < vals.size(); i++) {
			vals[i] => xmit.addInt;
		}
	}

	//if (hd.getNumButtons() > 0 || hd.getNumHats() > 0 || hd.getNumAxes() > 0) {
		hd.getMask() @=> int vals[];
		for (0 => int i; i < vals.size(); i++) {
			vals[i] => xmit.addInt;
		}
//	}
  }
}

//Wait for the signal to start extracting features
fun void receivedExtract() {
		//<<< "Received start extract.">>>;
		if (useTrackpadXY) {
			spork ~trackpadFE.extract();
		}
		if (useMotionXYZ) {
			spork ~motionFE.extract();
		} 
		if (useAudio) {
			spork ~audioFE.extract();
		}
		if (useProcessing) {
			spork ~processingFE.extract();
		}
		if (useCustom) {
			spork ~customFE.extract();
		}
		/*if (useOscCustom) {
			spork ~oscCustomFE.extract();
		} */
		sendFeatureData();
		spork ~extractFeatures();
}

//Wait for the signal to stop extracting features
fun void receivedStop() {
		//<<< "Received stop extract.">>>;
		0 => isExtracting;
		if (useTrackpadXY) {
			trackpadFE.stop();
		}
		if (useMotionXYZ) {
			motionFE.stop();
		}
		if (useAudio) {
			audioFE.stop();
		} 
		if (useProcessing) {
			processingFE.stop();
		}
		if (useCustom) {
			customFE.stop();
		}
		//if (useOscCustom) {
		//	oscCustomFE.stop();
		//}
}

//Extract them features!
fun void extractFeatures() {
	if (! isExtracting) {
		1 => isExtracting;
		while (isExtracting != 0) {
			rate => now;
			sendFeatures();		
		}
	}
}

fun void receivedRealValueRequest() {
	<<< "Received real value request. Huh?">>>;
}

fun void receivedStartGettingParamsRequest() {
	<<< "Received start param">>>;
	mc.startGettingParams(xmit, synthParamRate);
}

fun void receivedStopGettingParamsRequest() {
	<<< "Received stop param">>>;
	mc.stopGettingParams();
}

fun void receivedStartPlaybackRequest() {
<<< "Received start playback">>>;
	//mc.startPlayback(xmit);
	sp.startScore();
}

fun void receivedStopPlaybackRequest() {
<<< "Received stop playback">>>;
	//mc.stopPlayback();
	sp.stopScore();
}

//Send a metadata string, simply describing the # of features
fun void sendFeatureData() {
	computeNumFeats();
	xmit.startMsg("/featureInfo", "i");
	numFeats => xmit.addInt;
//	<<< "Sent feature info">>>;
}

"" => string featureMessageString;

fun void computeNumFeats() {
	0 => numFeats;
	if (useAudio) 
	    audioFE.numFeatures() => numFeats;
	if (useTrackpadXY) 
		numFeats + trackpadFE.numFeatures() => numFeats;
	if (useMotionXYZ)
		numFeats + motionFE.numFeatures() => numFeats;
	if (useOtherHid)
		numFeats + hd.numFeatures() => numFeats;
	if (useProcessing)
		numFeats + processingFE.numFeatures() => numFeats;
	if (useCustom) 
		customFE.numFeatures() +=> numFeats;

	"" => featureMessageString;
	if (numFeats > 0) {
		for (0 => int i; i < numFeats-1; i++) {
			featureMessageString + "f " => featureMessageString;
		}
		featureMessageString + "f " => featureMessageString;
	}
	<<< "Chuck using ", numFeats, "features">>>;
}

//lump the features into one message and hope for the best
fun void sendFeatures() {
	//<<< "sending " , numFeats>>>;
	//don't recompute # feats here every time-- it's expensive!	

	if (!(useAudio || useTrackpadXY || useMotionXYZ || useOtherHid || useProcessing || useCustom)) {
		return;
	}

	xmit.startMsg( "/features", featureMessageString);
	if (useAudio) {
		for (0 => int i; i < audioFE.numFeatures(); i++) {
			audioFE.getFeatures()[i] => xmit.addFloat;
		}
	}
	if (useTrackpadXY) {
		trackpadFE.getFeatures()[0] => xmit.addFloat;
		trackpadFE.getFeatures()[1] => xmit.addFloat;
	} 
	if (useMotionXYZ) {
		motionFE.getFeatures()[0] => xmit.addFloat;
		motionFE.getFeatures()[1] => xmit.addFloat;
		motionFE.getFeatures()[2] => xmit.addFloat;		
	}
	if (useOtherHid) {
		hd.extractFeatures() @=> float otherFeats[];
		for (0 => int i; i < otherFeats.size(); i++) {
			otherFeats[i] => xmit.addFloat;
		}
	}
	if (useProcessing) {
		for (0 => int i; i < processingFE.numFeatures(); i++) {
			processingFE.getFeatures()[i] => xmit.addFloat;
		}
	}
	if (useCustom) {
		for (0 => int i; i < customFE.numFeatures(); i++) {
			customFE.getFeatures()[i] => xmit.addFloat;
		}
	}
}

fun void oscParamsWait() {
	float vals[paramArraySize];
	while (true) {
		oscParams => now;
		<<< "Received osc parameters">>>;
		while (oscParams.nextMsg() != 0) {
			for (0 => int i; i < paramArraySize; i++) {
				oscParams.getFloat() => vals[i];
			}
			mc.setParams(vals);
		}
	}
}

fun void oscUseFeatureListWait() {
	while (true) {
		oscUseFeatureList => now;
		<<< "Chuck received feature list message">>>;
		  while (oscUseFeatureList.nextMsg() != 0) {
			<<< "Chuck feature list msg has another message">>>;
			//Audio
			if (audioFE != null) {
					audioFE.stop();
			}
			oscUseFeatureList.getInt() => useAudio;
			if (useAudio) {
				new AudioFeatureExtractor @=> audioFE;
				oscUseFeatureList.getInt() => int useFFT;
				oscUseFeatureList.getInt() => int useRMS;
				oscUseFeatureList.getInt() => int useCentroid;
				oscUseFeatureList.getInt() => int useRolloff;
				oscUseFeatureList.getInt() => int useFlux;
				oscUseFeatureList.getInt() => int fftSize;
				oscUseFeatureList.getInt() => int windowSize;
				oscUseFeatureList.getInt() => int windowType;
				oscUseFeatureList.getInt() => int rate;
				audioFE.setup(useFFT, useRMS, useCentroid, useRolloff, useFlux, fftSize, windowSize, windowType, rate::ms);
			} else {
				//Pull same # of ints off OSC message
				for (0 => int i; i < 9; i++) {
					oscUseFeatureList.getInt() => int tmp;
				}

			}

			//Trackpad
			oscUseFeatureList.getInt() => useTrackpadXY;
			if (trackpadFE != null) {
				trackpadFE.stop();
			}
			if (useTrackpadXY) {
				new TrackpadFeatureExtractor @=> trackpadFE;
				trackpadFE.setup();
				if (!trackpadFE.isOK) {
					0 => useTrackpadXY;
				}
			}

			//motion
			oscUseFeatureList.getInt() => int use;
			if (motionFE != null) {
				motionFE.stop();
			}
			if (use > 0) {
				1 => useMotionXYZ;
				new MotionFeatureExtractor @=> motionFE;
				motionFE.setup(use::ms);
				if (!motionFE.isOK) {
						0 => useMotionXYZ;
				}
			} else {
				0 => useMotionXYZ;
			}
	
			//other hid
			oscUseFeatureList.getInt() => useOtherHid;

			//use procesing (TODO: Get rid of this here)
			oscUseFeatureList.getInt() => use;
			if (processingFE != null) {
				processingFE.stop();
			}
			if (use > 0) {
				1 => useProcessing;
				new ProcessingFeatureExtractor @=> processingFE;
				processingFE.setup(use, recv);
				if (!processingFE.isOK) {
					0 => useProcessing;
				}
			} else {
				0 => useProcessing;
			}

			//custom osc
			oscUseFeatureList.getInt() => use; //Ignore this (TODO: change message in java)
			
			//custom chuck
			oscUseFeatureList.getInt() => use;	
			<<< "Chuck received ", use, " for use custom CHUCK">>>;
			if (customFE != null) {
				customFE.stop();
			}
			if (use > 0) {
				1 => useCustom;
				new CustomFeatureExtractor @=> customFE;
				customFE.setup();
			} else {
				0 => useCustom;
			}
			computeNumFeats();
			<<< "ChucK: done receiving feature list">>>;
		}//end while msg
	} //end while true
}

fun void receivedTrackpadMessage(int i) {
		//<<< "Saw trackpad", i>>>;
		i => useTrackpadXY;
		
		if (trackpadFE != null) {
			trackpadFE.stop();
		}
		if (useTrackpadXY) {
			new TrackpadFeatureExtractor @=> trackpadFE;
			trackpadFE.setup();
			if (!trackpadFE.isOK) {
				0 => useTrackpadXY;
			}
		}	
	computeNumFeats();		
}

fun void oscUseAudioWait() {
	while (true) {
		oscUseAudio => now;
		//<<< "Saw audio">>>;
		while (oscUseAudio.nextMsg() != 0) {
			if (audioFE != null) {
				audioFE.stop();
			}
			oscUseAudio.getInt() => useAudio;
			if (useAudio) {
				new AudioFeatureExtractor @=> audioFE;
				oscUseAudio.getInt() => int useFFT;
				oscUseAudio.getInt() => int useRMS;
				oscUseAudio.getInt() => int useCentroid;
				oscUseAudio.getInt() => int useRolloff;
				oscUseAudio.getInt() => int useFlux;
				oscUseAudio.getInt() => int fftSize;
				oscUseAudio.getInt() => int windowSize;
				oscUseAudio.getInt() => int windowType;
				oscUseAudio.getInt() => int rate;
				audioFE.setup(useFFT, useRMS, useCentroid, useRolloff, useFlux, fftSize, windowSize, windowType, rate::ms);
			}
		}	
	computeNumFeats();		
	}
	
}

fun void receivedOtherHidMessage(int i) {
	<<< "RECEIVED OTHER HID MESSAGE ", i>>>;
	i => useOtherHid;
	computeNumFeats();
}


fun void receivedMotionMessage(int i) {
	//	<<< "Saw motion", i>>>;
		i => int use;
		if (motionFE != null) {
			motionFE.stop();
		}
		if (use > 0) {
			1 => useMotionXYZ;
			new MotionFeatureExtractor @=> motionFE;
			motionFE.setup(use::ms);
			if (!motionFE.isOK) {
				0 => useMotionXYZ;
			}
		} else {
			0 => useMotionXYZ;
		}
			
		computeNumFeats();
}

fun void receivedProcessingMessage(int i) {
	i => int use;
//	<<< "Use is ", use >>>;
	if (processingFE != null) {
		processingFE.stop();
	}
	if (use > 0) {
		1 => useProcessing;
		new ProcessingFeatureExtractor @=> processingFE;
		processingFE.setup(use, recv);
		if (!processingFE.isOK) {
			0 => useProcessing;
		}
	} else {
		0 => useProcessing;
	}
	computeNumFeats();
}

fun void receivedCustomMessage(int i) {
	i => int use;
	if (customFE != null) {
		customFE.stop();
	}
	if (use > 0) {
		1 => useCustom;
		new CustomFeatureExtractor @=> customFE;
		customFE.setup(use);
		if (!customFE.isOK) {
			0 => useCustom;
		}
	} else {
		0 => useCustom;
	}
	computeNumFeats();
}

computeNumFeats();

// infinite time loop
//Make sure this has params of interest...
while( true )
{
	//some silly params here
	//mc.setFreq(400);
    1::hour => now;
}
	 