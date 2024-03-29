/*  This controls a bowed string instrument physical model
    This was part of ICMC 2009 demo

	Copyright 2009 Rebecca Fiebrink
	http://wekinator.cs.princeton.edu
*/

//The synth always lives in a SynthClass definition
public class SynthClass {
	//Necessary state objects and overall envelope
	OscSend xmit;
	0 => int isPlayingScore;
	0 => int isSendingParams;
	1 => int hasFinished;
	50::ms => dur rate;
	Envelope e => dac;
	.1::second => e.duration;
	0 => e.target => e.value;
	e.keyOn();

	//4 parameters here, though could change this easily
	4 => int numParams;
	float myParams[numParams];

	//The synthesis patch
	Bowed b => e;
	440 => b.freq;
	Envelope envs[numParams];
	for (0 => int i; i < numParams; i++) {
	// new Envelope @=> envs[i];
		envs[i] => blackhole;
		.5 => envs[i].value;
		100::ms => envs[i].duration;
	}

	//Do we want discrete or continuous parameters?
	//i.e., NN or classifier?
	fun int isDiscrete() {
		return 0;
	}
	
	//The number of classes-- max-- that we want to use
	//Necessary for structuring OSC messages
	fun int getNumClasses() {
		return 4;
	}

	//Do we want the labels for each parameter,
	//or a distribution over all possible labels? (classifier only)
	fun int useDistribution() {
		return 0;
	}

	//TODO: Any other setup code that should be called
	//This is called by the main code, only once after initialization, like a constructor
	fun void setup() {
		1.0 => b.noteOn;
		spork ~smooth();
	}

	//This is also sporked in the other code
	//to define what happens when we get learned
	//parameters back-- i.e., what do we do with them?
	fun void setParams(float params[]) {
		if (params.size() >= numParams) {		
			//Adjust the synthesis accordingly
			0.0 => float x;
			for (0 => int i; i < numParams; i++) {
				params[i] => x;
				if (x < 0)
					0 => x;
				if (x > 1)
					1 => x;
				x => envs[i].target;
				x => myParams[i];
			}
		}
		//NOTE: we rely on smooth() method to actually interpret these parameters musically.
	}

	//Functions particular to this synth:
	fun void smooth() {
		//Could pull this into separate methods if want to smooth 
		//different model parameters at different rates.
		while (true) {
			envs[0].value() => b.bowPosition;
			envs[1].value() => b.bowPressure;
			envs[2].value() * .2 => b.vibratoGain;
			envs[3].value() * 10 => b.vibratoFreq;
			10::ms => now;
		}
	}

/* PROBABLY don't need to change anything below this line ----------------------------*/
	fun int getNumParams() {
		return numParams;
	}

	fun float[] getParams() {
		return myParams;
	}

	//Be quiet! If you want to improve efficiency here, you could also stop
	//other processing
	fun void silent() {
		0 => e.target;
	}

	//Make sound!
	fun void sound() {
		1 => e.target;
	}

	//Received when wekinator wants our params for playalong learning
	fun void startGettingParams(OscSend x, dur r) { //Q: Where does this go?? Here or in recording? Or neither-- put in main?
		x @=> xmit;
		r => rate;
		1 => isSendingParams;
		spork ~sendParamsLoop();
	}

	//Send those parameters on at a specified rate
	fun void sendParamsLoop() {
		while (isSendingParams) {
			sendParams();
			rate => now;
		}
	}

	//Received when wekinator wants us to stop sending those playalong params
	fun void stopGettingParams() {
		0 => isSendingParams;
	}

	//Send current parameters directly to Wekinator
	fun void sendParams() {
		"/realValue f" => string ss;
		1 => int i;
		for (1 => i; i < numParams; i++) {
			ss + " f" => ss;
		}
		xmit.startMsg(ss);
		for (0 => i; i < numParams; i++) {
			xmit.addFloat(myParams[i]); //Add all params, each in its own addFloat message.
		}
	}

	//If OSC synth, we need to instruct the synth how to get back to ChucK
	fun void setOscHostAndPort(string h, int p) {
		//no need to do anything, unless you're using an OSC synth like Processing or Max.
	}
	fun int[] useDistributionArray() {
		new int[numParams] @=> int a[];
		for (0 => int i; i < numParams; i++) {
			useDistribution() => a[i];
		}
		return a;
	}

	fun int[] isDiscreteArray() {
		new int[numParams] @=> int a[];
		for (0 => int i; i < numParams; i++) {
			isDiscrete() => a[i];
		}
		return a;
	}

	fun int[] getNumClassesArray() {
		new int[numParams] @=> int a[];
		for (0 => int i; i < numParams; i++) {
			getNumClasses() => a[i];
		}
		return a;
	}
	
	fun string[] getParamNamesArray() {
		new string[4] @=> string s[];
		"BowPosition" => s[0];
		"BowPressure" => s[1];
		"VibratoGain" => s[2];
		"VibratoFrequency" => s[3];
		return s;
	}

}

