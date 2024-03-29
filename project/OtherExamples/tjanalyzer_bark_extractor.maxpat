{
	"patcher" : 	{
		"fileversion" : 1,
		"rect" : [ 115.0, 44.0, 1024.0, 694.0 ],
		"bglocked" : 0,
		"defrect" : [ 115.0, 44.0, 1024.0, 694.0 ],
		"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
		"openinpresentation" : 0,
		"default_fontsize" : 12.0,
		"default_fontface" : 0,
		"default_fontname" : "Arial",
		"gridonopen" : 0,
		"gridsize" : [ 15.0, 15.0 ],
		"gridsnaponopen" : 0,
		"toolbarvisible" : 1,
		"boxanimatetime" : 200,
		"imprint" : 0,
		"enablehscroll" : 1,
		"enablevscroll" : 1,
		"boxes" : [ 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "THIS IS THE PART THAT SENDS FEATURES TO THE WEKINATOR:",
					"numinlets" : 1,
					"patching_rect" : [ 43.0, 683.0, 447.0, 20.0 ],
					"id" : "obj-149",
					"fontname" : "Arial",
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Use 127.0.0.1 for localhost; can change IP if Wekinator is running on  different host.",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 454.0, 870.0, 278.0, 34.0 ],
					"id" : "obj-121",
					"fontname" : "Arial",
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Don't change port - must be 6448",
					"numinlets" : 1,
					"patching_rect" : [ 456.0, 850.0, 271.0, 20.0 ],
					"id" : "obj-147",
					"fontname" : "Arial",
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Note that this outputs a vector of floats.",
					"numinlets" : 1,
					"patching_rect" : [ 393.0, 777.0, 447.0, 20.0 ],
					"id" : "obj-142",
					"fontname" : "Arial",
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "unpack",
					"numinlets" : 1,
					"patching_rect" : [ 302.0, 741.0, 49.0, 20.0 ],
					"id" : "obj-146",
					"fontname" : "Arial",
					"numoutlets" : 2,
					"outlettype" : [ "int", "int" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "vexpr $f1 / $f2 @scalarmode 1",
					"numinlets" : 2,
					"patching_rect" : [ 218.0, 774.0, 174.0, 20.0 ],
					"id" : "obj-143",
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "zl sort -1",
					"numinlets" : 2,
					"patching_rect" : [ 302.0, 712.0, 57.0, 20.0 ],
					"id" : "obj-135",
					"fontname" : "Arial",
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "t b s",
					"numinlets" : 1,
					"patching_rect" : [ 291.0, 831.0, 33.0, 20.0 ],
					"id" : "obj-136",
					"fontname" : "Arial",
					"numoutlets" : 2,
					"outlettype" : [ "bang", "" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "OpenSoundControl 2000",
					"numinlets" : 1,
					"patching_rect" : [ 295.0, 856.0, 143.0, 20.0 ],
					"id" : "obj-137",
					"fontname" : "Arial",
					"numoutlets" : 3,
					"outlettype" : [ "", "", "OSCTimeTag" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend /oscCustomFeatures",
					"numinlets" : 1,
					"patching_rect" : [ 293.0, 806.0, 169.0, 20.0 ],
					"id" : "obj-138",
					"fontname" : "Arial",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "udpsend localhost 6448",
					"numinlets" : 1,
					"patching_rect" : [ 294.0, 885.0, 137.0, 20.0 ],
					"id" : "obj-140",
					"fontname" : "Arial",
					"numoutlets" : 0,
					"fontsize" : 12.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "loud 0",
					"numinlets" : 2,
					"patching_rect" : [ 220.0, 276.0, 43.0, 17.0 ],
					"id" : "obj-1",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "loud 1",
					"numinlets" : 2,
					"patching_rect" : [ 266.0, 276.0, 44.0, 17.0 ],
					"id" : "obj-2",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "• Loudness type",
					"numinlets" : 1,
					"patching_rect" : [ 220.0, 293.0, 85.0, 19.0 ],
					"id" : "obj-3",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "11.6",
					"numinlets" : 2,
					"hidden" : 1,
					"patching_rect" : [ 172.0, 328.0, 30.0, 17.0 ],
					"id" : "obj-4",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"triscale" : 0.9,
					"numinlets" : 1,
					"patching_rect" : [ 172.0, 346.0, 35.0, 19.0 ],
					"id" : "obj-5",
					"fontname" : "Geneva",
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"outlettype" : [ "float", "bang" ],
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Brightness",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 708.0, 111.0, 53.0, 31.0 ],
					"id" : "obj-6",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"numinlets" : 1,
					"patching_rect" : [ 362.0, 401.0, 15.0, 15.0 ],
					"id" : "obj-7",
					"numoutlets" : 1,
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Noisiness",
					"numinlets" : 1,
					"patching_rect" : [ 257.0, 419.0, 51.0, 19.0 ],
					"id" : "obj-8",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Brightness",
					"numinlets" : 1,
					"patching_rect" : [ 203.0, 419.0, 54.0, 19.0 ],
					"id" : "obj-9",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"triscale" : 0.9,
					"numinlets" : 1,
					"patching_rect" : [ 258.0, 399.0, 49.0, 19.0 ],
					"id" : "obj-10",
					"fontname" : "Geneva",
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"outlettype" : [ "float", "bang" ],
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"triscale" : 0.9,
					"numinlets" : 1,
					"patching_rect" : [ 206.0, 401.0, 49.0, 19.0 ],
					"id" : "obj-11",
					"fontname" : "Geneva",
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"outlettype" : [ "float", "bang" ],
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"triscale" : 0.9,
					"numinlets" : 1,
					"patching_rect" : [ 154.0, 401.0, 49.0, 19.0 ],
					"id" : "obj-12",
					"fontname" : "Geneva",
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"outlettype" : [ "float", "bang" ],
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "bright 0",
					"numinlets" : 2,
					"patching_rect" : [ 220.0, 309.0, 44.0, 17.0 ],
					"id" : "obj-13",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "bright 1",
					"numinlets" : 2,
					"patching_rect" : [ 266.0, 309.0, 44.0, 17.0 ],
					"id" : "obj-14",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "linear",
					"numinlets" : 2,
					"patching_rect" : [ 220.0, 243.0, 34.0, 17.0 ],
					"id" : "obj-15",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "log",
					"numinlets" : 2,
					"patching_rect" : [ 256.0, 243.0, 35.0, 17.0 ],
					"id" : "obj-16",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "• Output scale",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 220.0, 260.0, 70.0, 31.0 ],
					"id" : "obj-17",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "• Brightness type",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 220.0, 326.0, 85.0, 31.0 ],
					"id" : "obj-18",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "noise~",
					"numinlets" : 1,
					"patching_rect" : [ 245.0, 155.0, 44.0, 19.0 ],
					"id" : "obj-19",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Pitch tracker based on fiddle~ from Miller Puckette",
					"numinlets" : 1,
					"patching_rect" : [ 17.0, 68.0, 241.0, 19.0 ],
					"id" : "obj-20",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Outputs Pitch, Loudness, Brightness, Noisiness and Bark scale",
					"numinlets" : 1,
					"patching_rect" : [ 17.0, 56.0, 294.0, 19.0 ],
					"id" : "obj-21",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "analyzer~",
					"numinlets" : 1,
					"patching_rect" : [ 15.0, 23.0, 87.0, 27.0 ],
					"id" : "obj-22",
					"fontname" : "Arial",
					"numoutlets" : 0,
					"fontsize" : 18.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "FFT-Based Perceptual Analysis",
					"numinlets" : 1,
					"patching_rect" : [ 17.0, 44.0, 150.0, 19.0 ],
					"id" : "obj-23",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "noisy",
					"numinlets" : 1,
					"patching_rect" : [ 842.0, 150.0, 33.0, 19.0 ],
					"id" : "obj-24",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "multislider",
					"setminmax" : [ 0.0, 22050.0 ],
					"numinlets" : 1,
					"patching_rect" : [ 647.0, 135.0, 165.0, 17.0 ],
					"id" : "obj-25",
					"contdata" : 1,
					"numoutlets" : 2,
					"orientation" : 0,
					"outlettype" : [ "", "" ],
					"peakcolor" : [ 0.498039, 0.498039, 0.498039, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "0.2",
					"numinlets" : 1,
					"patching_rect" : [ 831.0, 431.0, 23.0, 19.0 ],
					"id" : "obj-26",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "0.4",
					"numinlets" : 1,
					"patching_rect" : [ 831.0, 359.0, 23.0, 19.0 ],
					"id" : "obj-27",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "0.6",
					"numinlets" : 1,
					"patching_rect" : [ 831.0, 287.0, 23.0, 19.0 ],
					"id" : "obj-28",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "0.8",
					"numinlets" : 1,
					"patching_rect" : [ 831.0, 217.0, 23.0, 19.0 ],
					"id" : "obj-29",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "multislider",
					"setminmax" : [ 0.0, 1.0 ],
					"numinlets" : 1,
					"patching_rect" : [ 813.0, 153.0, 17.0, 355.0 ],
					"id" : "obj-30",
					"contdata" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"peakcolor" : [ 0.498039, 0.498039, 0.498039, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "multislider",
					"setminmax" : [ -96.0, 30.0 ],
					"numinlets" : 1,
					"patching_rect" : [ 630.0, 153.0, 17.0, 355.0 ],
					"id" : "obj-31",
					"contdata" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"peakcolor" : [ 0.498039, 0.498039, 0.498039, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "22 KHz",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 791.0, 123.0, 39.0, 31.0 ],
					"id" : "obj-32",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "0 Hz",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 644.0, 123.0, 25.0, 31.0 ],
					"id" : "obj-33",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "10 KHz",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 715.0, 123.0, 37.0, 31.0 ],
					"id" : "obj-34",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "-60 dB",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 595.0, 390.0, 36.0, 31.0 ],
					"id" : "obj-35",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "22 KHz",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 793.0, 511.0, 39.0, 31.0 ],
					"id" : "obj-36",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "3 KHz",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 738.0, 511.0, 34.0, 31.0 ],
					"id" : "obj-37",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "multislider",
					"setminmax" : [ -96.0, 30.0 ],
					"numinlets" : 1,
					"patching_rect" : [ 648.0, 153.0, 164.0, 355.0 ],
					"id" : "obj-38",
					"contdata" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"peakcolor" : [ 0.498039, 0.498039, 0.498039, 1.0 ],
					"size" : 25
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "0 Hz",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 644.0, 511.0, 25.0, 31.0 ],
					"id" : "obj-39",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "1 KHz",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 691.0, 511.0, 32.0, 31.0 ],
					"id" : "obj-40",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "-96 dB",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 594.0, 499.0, 36.0, 31.0 ],
					"id" : "obj-41",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "30 dB",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 597.0, 148.0, 31.0, 31.0 ],
					"id" : "obj-42",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "0 dB",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 605.0, 231.0, 25.0, 31.0 ],
					"id" : "obj-43",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "-30 dB",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 595.0, 312.0, 36.0, 31.0 ],
					"id" : "obj-44",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "0",
					"numinlets" : 1,
					"patching_rect" : [ 831.0, 501.0, 16.0, 19.0 ],
					"id" : "obj-45",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "1",
					"numinlets" : 1,
					"patching_rect" : [ 831.0, 150.0, 16.0, 19.0 ],
					"id" : "obj-46",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "peaky",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 843.0, 501.0, 33.0, 31.0 ],
					"id" : "obj-47",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p description",
					"numinlets" : 0,
					"patching_rect" : [ 226.0, 482.0, 65.0, 19.0 ],
					"id" : "obj-48",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0,
					"color" : [ 0.380392, 0.611765, 0.611765, 1.0 ],
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 30.0, 48.0, 466.0, 722.0 ],
						"bglocked" : 0,
						"defrect" : [ 30.0, 48.0, 466.0, 722.0 ],
						"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 0,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 0,
						"toolbarvisible" : 1,
						"boxanimatetime" : 200,
						"imprint" : 0,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"boxes" : [ 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Default window is blackman70",
									"numinlets" : 1,
									"patching_rect" : [ 280.0, 222.0, 145.0, 19.0 ],
									"id" : "obj-1",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "blackman92",
									"numinlets" : 1,
									"patching_rect" : [ 154.0, 270.0, 93.0, 19.0 ],
									"id" : "obj-2",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "blackman74",
									"numinlets" : 1,
									"patching_rect" : [ 154.0, 258.0, 93.0, 19.0 ],
									"id" : "obj-3",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "blackman70",
									"numinlets" : 1,
									"patching_rect" : [ 154.0, 246.0, 93.0, 19.0 ],
									"id" : "obj-4",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Notes:",
									"linecount" : 2,
									"numinlets" : 1,
									"patching_rect" : [ 44.0, 529.0, 35.0, 31.0 ],
									"id" : "obj-5",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- Noisiness (float) 0-1",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 438.0, 113.0, 19.0 ],
									"id" : "obj-6",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- Bark decomposition (list of/or 25 floats)",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 450.0, 201.0, 19.0 ],
									"id" : "obj-7",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- Loudness (float)",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 414.0, 100.0, 19.0 ],
									"id" : "obj-8",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- Brightness (float)",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 426.0, 113.0, 19.0 ],
									"id" : "obj-9",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "nolist (25 outlets)",
									"linecount" : 2,
									"numinlets" : 1,
									"patching_rect" : [ 84.0, 342.0, 87.0, 31.0 ],
									"id" : "obj-10",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "list (default)",
									"numinlets" : 1,
									"patching_rect" : [ 84.0, 354.0, 63.0, 19.0 ],
									"id" : "obj-11",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- Bark output format",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 330.0, 99.0, 19.0 ],
									"id" : "obj-12",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "analyzer~",
									"numinlets" : 1,
									"patching_rect" : [ 12.0, 21.0, 87.0, 27.0 ],
									"id" : "obj-13",
									"fontname" : "Arial",
									"numoutlets" : 0,
									"fontsize" : 18.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- Pitch is measured with an adapted version of fiddle~ from Miller Puckette",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 70.0, 362.0, 19.0 ],
									"id" : "obj-14",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- Noisiness is measured with the Bark-based spectral flatness measure (SFM)",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 106.0, 363.0, 19.0 ],
									"id" : "obj-15",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- The bark scale is an auditory model spetrum decomposition: the number of outputs depends on the sampling rate. This version is set for 44100 Hz only, and outputs 25 bands.",
									"linecount" : 3,
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 118.0, 363.0, 43.0 ],
									"id" : "obj-16",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- Loudness is measured with the spectral energy",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 94.0, 363.0, 19.0 ],
									"id" : "obj-17",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- Brightness is measured with the spectral centroid",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 82.0, 362.0, 19.0 ],
									"id" : "obj-18",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "In this version:",
									"numinlets" : 1,
									"patching_rect" : [ 42.0, 54.0, 100.0, 19.0 ],
									"id" : "obj-19",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- Sinusoidal decomposition (freq, amp) (list)",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 498.0, 205.0, 19.0 ],
									"id" : "obj-20",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- Raw Pitch (Midi, Amp) (list)",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 474.0, 166.0, 19.0 ],
									"id" : "obj-21",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- Overall amplitude in dB (float)",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 486.0, 152.0, 19.0 ],
									"id" : "obj-22",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- Onset detection (bang)",
									"linecount" : 2,
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 462.0, 114.0, 31.0 ],
									"id" : "obj-23",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- Cooked Pitch (Midi, Hz) (list)",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 402.0, 148.0, 19.0 ],
									"id" : "obj-24",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Outputs are (from left to right):",
									"numinlets" : 1,
									"patching_rect" : [ 44.0, 386.0, 151.0, 19.0 ],
									"id" : "obj-25",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "3- The object uses an efficient real FFT written at CNMAT by Adrian Freed when running on a G3 processor. It uses the altivec optimized Apple real FFT when running on a G4 processor.",
									"linecount" : 3,
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 614.0, 361.0, 43.0 ],
									"id" : "obj-26",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Default # peaks to output is 0",
									"numinlets" : 1,
									"patching_rect" : [ 280.0, 270.0, 140.0, 19.0 ],
									"id" : "obj-27",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Default # peaks to find is 20",
									"numinlets" : 1,
									"patching_rect" : [ 280.0, 258.0, 133.0, 19.0 ],
									"id" : "obj-28",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Default # pitches is 1",
									"numinlets" : 1,
									"patching_rect" : [ 280.0, 246.0, 107.0, 19.0 ],
									"id" : "obj-29",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- # of peaks to output (1-100)",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 318.0, 166.0, 19.0 ],
									"id" : "obj-30",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- # of peaks to find (1-100)",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 306.0, 166.0, 19.0 ],
									"id" : "obj-31",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- # of pitches to extract (1-3)",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 294.0, 166.0, 19.0 ],
									"id" : "obj-32",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "2- Use the delay argument when using this object multiple times in parallel to avoid over loading the CPU with several FFTs occuring at the same time, e.g. choose 0, 1, 2, etc. FFTs will occur at different times, each one separated by the time length of a signal vector.",
									"linecount" : 4,
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 562.0, 358.0, 55.0 ],
									"id" : "obj-33",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Default delay is 0",
									"numinlets" : 1,
									"patching_rect" : [ 280.0, 234.0, 91.0, 19.0 ],
									"id" : "obj-34",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Default FFT size is 1024",
									"numinlets" : 1,
									"patching_rect" : [ 280.0, 210.0, 123.0, 19.0 ],
									"id" : "obj-35",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- FFT size (ms or # of samples)",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 210.0, 174.0, 19.0 ],
									"id" : "obj-36",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- Initial delay (# of signal vectors)",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 282.0, 182.0, 19.0 ],
									"id" : "obj-37",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Default hop size is 512",
									"numinlets" : 1,
									"patching_rect" : [ 280.0, 198.0, 143.0, 19.0 ],
									"id" : "obj-38",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Arguments are:",
									"numinlets" : 1,
									"patching_rect" : [ 42.0, 170.0, 79.0, 19.0 ],
									"id" : "obj-39",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- Buffer size (ms or # of samples)",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 186.0, 189.0, 19.0 ],
									"id" : "obj-40",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- Hop size (ms or # of samples)",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 198.0, 202.0, 19.0 ],
									"id" : "obj-41",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "- Type of window",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 222.0, 100.0, 19.0 ],
									"id" : "obj-42",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "rectangular",
									"numinlets" : 1,
									"patching_rect" : [ 80.0, 234.0, 75.0, 19.0 ],
									"id" : "obj-43",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Default buffer size is 1024",
									"numinlets" : 1,
									"patching_rect" : [ 280.0, 186.0, 136.0, 19.0 ],
									"id" : "obj-44",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "hanning",
									"numinlets" : 1,
									"patching_rect" : [ 80.0, 246.0, 59.0, 19.0 ],
									"id" : "obj-45",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "hamming",
									"numinlets" : 1,
									"patching_rect" : [ 80.0, 258.0, 62.0, 19.0 ],
									"id" : "obj-46",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "blackman62",
									"numinlets" : 1,
									"patching_rect" : [ 154.0, 234.0, 93.0, 19.0 ],
									"id" : "obj-47",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "1- Use floats to define sizes in ms and integers to define sizes in # of samples",
									"numinlets" : 1,
									"patching_rect" : [ 63.0, 546.0, 357.0, 19.0 ],
									"id" : "obj-48",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
 ],
						"lines" : [  ]
					}
,
					"saved_object_attributes" : 					{
						"default_fontname" : "Arial",
						"default_fontsize" : 12.0,
						"fontname" : "Arial",
						"globalpatchername" : "",
						"fontface" : 0,
						"default_fontface" : 0,
						"fontsize" : 12.0
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "65",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 629.0, 570.0, 17.0, 31.0 ],
					"id" : "obj-49",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "55",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 629.0, 596.0, 17.0, 31.0 ],
					"id" : "obj-50",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "80",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 629.0, 531.0, 17.0, 31.0 ],
					"id" : "obj-51",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "45",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 629.0, 622.0, 17.0, 31.0 ],
					"id" : "obj-52",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "65",
					"numinlets" : 1,
					"patching_rect" : [ 26.0, 553.0, 24.0, 19.0 ],
					"id" : "obj-53",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "55",
					"numinlets" : 1,
					"patching_rect" : [ 26.0, 587.0, 23.0, 19.0 ],
					"id" : "obj-54",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "80",
					"numinlets" : 1,
					"patching_rect" : [ 26.0, 505.0, 29.0, 19.0 ],
					"id" : "obj-55",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "unpack 0. 0.",
					"linecount" : 2,
					"numinlets" : 1,
					"hidden" : 1,
					"patching_rect" : [ 514.0, 450.0, 62.0, 31.0 ],
					"id" : "obj-56",
					"fontname" : "Geneva",
					"numoutlets" : 2,
					"outlettype" : [ "float", "float" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "multislider",
					"setminmax" : [ 45.0, 80.0 ],
					"numinlets" : 1,
					"patching_rect" : [ 647.0, 535.0, 165.0, 93.0 ],
					"id" : "obj-57",
					"contdata" : 1,
					"numoutlets" : 2,
					"setstyle" : 2,
					"outlettype" : [ "", "" ],
					"peakcolor" : [ 0.498039, 0.498039, 0.498039, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Simulate Attack",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 27.0, 138.0, 57.0, 31.0 ],
					"id" : "obj-58",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "127",
					"numinlets" : 2,
					"patching_rect" : [ 40.0, 189.0, 26.0, 17.0 ],
					"id" : "obj-59",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "10",
					"numinlets" : 2,
					"patching_rect" : [ 62.0, 170.0, 20.0, 17.0 ],
					"id" : "obj-60",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "220.",
					"numinlets" : 2,
					"hidden" : 1,
					"patching_rect" : [ 200.0, 113.0, 29.0, 17.0 ],
					"id" : "obj-61",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"maximum" : 22000.0,
					"triscale" : 0.9,
					"numinlets" : 1,
					"patching_rect" : [ 200.0, 131.0, 38.0, 19.0 ],
					"id" : "obj-62",
					"fontname" : "Geneva",
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"outlettype" : [ "float", "bang" ],
					"minimum" : 10.0,
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "phasor~",
					"numinlets" : 2,
					"patching_rect" : [ 200.0, 155.0, 44.0, 19.0 ],
					"id" : "obj-63",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "print",
					"numinlets" : 2,
					"patching_rect" : [ 332.0, 309.0, 30.0, 17.0 ],
					"id" : "obj-64",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "npartial 7",
					"numinlets" : 2,
					"patching_rect" : [ 332.0, 241.0, 52.0, 17.0 ],
					"id" : "obj-65",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "reattack 100 10",
					"numinlets" : 2,
					"patching_rect" : [ 332.0, 161.0, 82.0, 17.0 ],
					"id" : "obj-66",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "vibrato 50 0.5",
					"numinlets" : 2,
					"patching_rect" : [ 332.0, 93.0, 74.0, 17.0 ],
					"id" : "obj-67",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "amp-range 40 50",
					"numinlets" : 2,
					"patching_rect" : [ 332.0, 25.0, 85.0, 17.0 ],
					"id" : "obj-68",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "• A low and high amplitude threshold: if signal amplitude is below the low threshold, no pitches or peaks are output. The high threshold is a minimum at which \"cooked\" outputs may appear.",
					"linecount" : 4,
					"numinlets" : 1,
					"patching_rect" : [ 332.0, 42.0, 229.0, 55.0 ],
					"id" : "obj-69",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "• A period in milliseconds (50) over which the raw pitch may not deviate more than an interval in half-tones (0.5) from the average pitch to report it as a note to the \"cooked\" pitch outlet.",
					"linecount" : 4,
					"numinlets" : 1,
					"patching_rect" : [ 332.0, 110.0, 231.0, 55.0 ],
					"id" : "obj-70",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "• A period in milliseconds (100) over which a re-attack is reported if the amplitude rises more than (10) dB. The re-attack will result in a \"bang\" in the attack outlet and may give rise to repeated notes in the cooked pitch output.",
					"linecount" : 5,
					"numinlets" : 1,
					"patching_rect" : [ 332.0, 178.0, 231.0, 67.0 ],
					"id" : "obj-71",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "• Higher partials are weighed less strongly than lower ones in determining the pitch -- this specifies the number of the partial (7) which will be weighted half as strongly as the fundamental.",
					"linecount" : 4,
					"numinlets" : 1,
					"patching_rect" : [ 332.0, 258.0, 238.0, 55.0 ],
					"id" : "obj-72",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "• Print the values of these parameters.",
					"numinlets" : 1,
					"patching_rect" : [ 332.0, 326.0, 231.0, 19.0 ],
					"id" : "obj-73",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "p fiddle",
					"numinlets" : 0,
					"patching_rect" : [ 226.0, 501.0, 41.0, 19.0 ],
					"id" : "obj-74",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0,
					"color" : [ 0.380392, 0.611765, 0.611765, 1.0 ],
					"patcher" : 					{
						"fileversion" : 1,
						"rect" : [ 46.0, 82.0, 280.0, 529.0 ],
						"bglocked" : 0,
						"defrect" : [ 46.0, 82.0, 280.0, 529.0 ],
						"openrect" : [ 0.0, 0.0, 0.0, 0.0 ],
						"openinpresentation" : 0,
						"default_fontsize" : 12.0,
						"default_fontface" : 0,
						"default_fontname" : "Arial",
						"gridonopen" : 0,
						"gridsize" : [ 15.0, 15.0 ],
						"gridsnaponopen" : 0,
						"toolbarvisible" : 1,
						"boxanimatetime" : 200,
						"imprint" : 0,
						"enablehscroll" : 1,
						"enablevscroll" : 1,
						"boxes" : [ 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "pitch estimator and sinusoidal peak finder",
									"linecount" : 2,
									"numinlets" : 1,
									"patching_rect" : [ 131.0, 31.0, 105.0, 31.0 ],
									"id" : "obj-1",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "fpic",
									"numinlets" : 1,
									"embed" : 1,
									"patching_rect" : [ 22.0, 31.0, 101.0, 22.0 ],
									"id" : "obj-2",
									"numoutlets" : 0,
									"data" : [ 1445, "", "IBkSG0fBZn....PCIgDQRA...TF...fEHX....P1JKEn....DLmPIQEBHf.B7g.YHB..EvURDEDUnEXwZEBciiCD8u6K.alLyBJnCygkBMLgckkBCrG6N1svdrsrqvB6xZX0PCaXwrXnf1rHVDqGv0dksF0XmW5qeVjmNVyLZl4qw8au81auAGPo0PVVhRkpcsHNG7vP3A.M.Jqpr96Zd9XfKcIBCGolp22GL1y..9ddHjwFkLeUXB0hJsFOlkghxRx+n+a8Z..THk3grLqm+yatAddiKrPoqPeeb2pUiRO..Y44Hc+9NqkHDXURxnj4qBVAEkVi6d5InnjF0NpF2coxVpPeevFY.A.P5Hi6b.0goPNezx7UAqfR5quRFPDAAvyyCbCGNkgctNR4gCVqEclNIJcMsmtFhLeUnSPQCfLozRnUWcERhhrVOVHrbbmqijJ.KBBFsdnx3.PmdECQluRzInjSDPB88ICH.v45iEUDkAANul7CIi6RlU9YfNAEJ1OyDhK1KSVU0lQvYLDIDvC.6GYVhF0DCZ5oEw4sAvgjwcNYk8Yh544AQPvYcv4TXRZdN1ramSAR2uukkhI6jekkYUpyE6ksRIdNKypWEC.2jjfJJmDQoDMpYMQseEAAXcRhSJ5lXHxXt2yxyIyt.pqjb874H9Bd3chKZuja.iTbIQIGAwFiJ30.E.dJKCd99mTWZ.b+lMNcNxCGviYYn53QqmYVZRCbRYZj6gzTmWKnAUGOhGxxvsIIWr.yjxQDTLYmP4b5WBHqnfLfjHDfEDfborVODNo955wrLq2IC.WMcJ777P1tcj6IFPGJ5TYI8kg5..C.IylgHNGEkkVYqOuc6kKnb6xk..X698VNPQP.Vc0Us+tgcxPXunzZ7qWe0Rl0IIX96a9j3X7iGejjBtot1JkVjPX.3uu95V4h3b7uu7hkd3C39I8kYCwAfaWtrs+gHLDpCG53upNdDZfQOICJ7cQXHDggnTqsdXrPflma1Pixv5m9mRDPh371.BPsAz2gPoqW1t0RljYy5D3b0vsutN0dWVUYc3rwOXBFAw.prPfZ1ko44HMO2ISyJkp8vdK6KpxXtnIdJJkttuyUCjBsotxkRxd.mit.Nscts2nW.pc12ml1Ys9yMiBZTW10LKeytcPDDfj331CnUJE94yOCOee7iUqpCJJslrDhKFIjrWLN0RceG.5fLkSxTWENt6T+Q435DnoMLD6bOgsUc7H4AiOROeDwjFRIOi5JEMYuriGgRopCJjyAxXFWlPo0jaPggCm5TDkizkSxTWTkUmRbXgx36aCCwNGhymBLzsehYeoHNGQb9uI17NT.P0DPvu6QNAXb71kDFVe1KTFe.w8N1QjELDcQUOmRWi89ITDXh3b7WKVXs9oPHmCHkXwzo3OlOG..KhiQtThrhhN1UnuO9yEKZ6QNAXbicfZxvT2OYHHKO+hnKkVSVx7RLdEpmmaLMgFLSH5P7nYDT8GEUrPfXgn864P8MbbV9x0XGFhrhf.K4JKK6PYLMOmtLHgt56LKJKwh331e+Hw2zgRWmZu6S7IG5+tpTJ7TuoSvPM8993ilMHyyCLGUilL1gANDVZ7vPfdrXTntwWrPfhxRm2TtutDLFYP4grLHBBvqEEN6CXZCCwNCYLvdeuZ9ttOMEQbt0cSZvsKWdQteRC99XFFXkRMHVZwBABIFch7vArY2NTTVhDGko5qqjYyHkKWJwlc6P0wij5puMLT67ZhY20bC99ADFpuL7kdnjemZXfi49Ihf.qSId.0MtHBLLT+8YlOc5fzUHig0IIf5KcD56i+Y4RxF+8sggZmyEBmuOSjHD3t0q6bY3KE91G8ONwk.4NFw9Xg9cccPofmmGlx4e5eTJYUEjGN.86zx+LGWuI9eD8X.VWzkoUH.....IUjSD4pPfIH" ]
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "by Miller Puckette",
									"numinlets" : 1,
									"patching_rect" : [ 21.0, 75.0, 94.0, 19.0 ],
									"id" : "obj-3",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "MSP port by Ted Apel, David Zicarelli",
									"numinlets" : 1,
									"patching_rect" : [ 21.0, 91.0, 185.0, 19.0 ],
									"id" : "obj-4",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Version 1.1 December 1999",
									"numinlets" : 1,
									"patching_rect" : [ 21.0, 59.0, 149.0, 19.0 ],
									"id" : "obj-5",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "The fiddle~ object estimates the pitch and amplitude of an incoming sound, both continuously and as a streem of discrete \"note\" events. Fiddle~ optionally outputs a list of detected sinusoidal peaks used to make the pitch determination. Fiddle~ is described theoretically in the 1998 ICMC proceedings, reprinted on http://www.crca.ucsd.edu/~msp.",
									"linecount" : 8,
									"numinlets" : 1,
									"patching_rect" : [ 21.0, 124.0, 222.0, 103.0 ],
									"id" : "obj-6",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "Fiddle's creation arguments specify an analysis window size, the maximum polyphony (i.e., the number of simultaneous \"pitches\" to try the find), the number of peaks in the spectrum to consider, and the number of peaks, if any, to output \"raw\". The outlets give discrete pitch (a number), detected attacks in the amplitude envelope (a bang), one or more voices of continuous pitch and amplitude, overall amplitude, and optionally a sequence of messages with the peaks.",
									"linecount" : 11,
									"numinlets" : 1,
									"patching_rect" : [ 21.0, 225.0, 222.0, 139.0 ],
									"id" : "obj-7",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
, 							{
								"box" : 								{
									"maxclass" : "comment",
									"text" : "The analysis hop size is half the window size so in the example shown here, one analysis is done every 512 samples (1.6 msec at 44.1kHz), and the analysis uses the most recent 1024 samples (23.2 msec at 44.1kHz). The minimum frequency that fiddle~ with report is 2-1/2 cycles per analysis window, or about 108 Hz. (just below MIDI 45.)",
									"linecount" : 8,
									"numinlets" : 1,
									"patching_rect" : [ 21.0, 362.0, 224.0, 103.0 ],
									"id" : "obj-8",
									"fontname" : "Geneva",
									"numoutlets" : 0,
									"fontsize" : 9.0
								}

							}
 ],
						"lines" : [  ]
					}
,
					"saved_object_attributes" : 					{
						"default_fontname" : "Arial",
						"default_fontsize" : 12.0,
						"fontname" : "Arial",
						"globalpatchername" : "",
						"fontface" : 0,
						"default_fontface" : 0,
						"fontsize" : 12.0
					}

				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "up to 3",
					"numinlets" : 1,
					"patching_rect" : [ 166.0, 524.0, 53.0, 19.0 ],
					"id" : "obj-75",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "up to 3",
					"numinlets" : 1,
					"patching_rect" : [ 319.0, 527.0, 64.0, 19.0 ],
					"id" : "obj-76",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "65.390778 57.2",
					"linecount" : 2,
					"numinlets" : 2,
					"patching_rect" : [ 346.0, 600.0, 62.0, 29.0 ],
					"id" : "obj-77",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend set",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 346.0, 580.0, 60.0, 31.0 ],
					"id" : "obj-78",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "69.084084 42.142391",
					"linecount" : 2,
					"numinlets" : 2,
					"patching_rect" : [ 283.0, 600.0, 62.0, 29.0 ],
					"id" : "obj-79",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend set",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 282.0, 573.0, 60.0, 31.0 ],
					"id" : "obj-80",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "route 1 2",
					"numinlets" : 1,
					"patching_rect" : [ 309.0, 553.0, 50.0, 19.0 ],
					"id" : "obj-81",
					"fontname" : "Geneva",
					"numoutlets" : 3,
					"outlettype" : [ "", "", "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Polyphonic pitches (freq, amp)",
					"numinlets" : 1,
					"patching_rect" : [ 274.0, 630.0, 145.0, 19.0 ],
					"id" : "obj-82",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "multislider",
					"setminmax" : [ 45.0, 80.0 ],
					"numinlets" : 1,
					"patching_rect" : [ 43.0, 510.0, 50.0, 118.0 ],
					"id" : "obj-83",
					"contdata" : 1,
					"numoutlets" : 2,
					"outlettype" : [ "", "" ],
					"peakcolor" : [ 0.498039, 0.498039, 0.498039, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"triscale" : 0.9,
					"numinlets" : 1,
					"patching_rect" : [ 96.0, 489.0, 49.0, 19.0 ],
					"id" : "obj-84",
					"fontname" : "Geneva",
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"outlettype" : [ "float", "bang" ],
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"triscale" : 0.9,
					"numinlets" : 1,
					"patching_rect" : [ 44.0, 489.0, 49.0, 19.0 ],
					"id" : "obj-85",
					"fontname" : "Geneva",
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"outlettype" : [ "float", "bang" ],
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "unpack 0. 0.",
					"numinlets" : 1,
					"patching_rect" : [ 41.0, 464.0, 78.0, 19.0 ],
					"id" : "obj-86",
					"fontname" : "Geneva",
					"numoutlets" : 2,
					"outlettype" : [ "float", "float" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "0. 0.",
					"numinlets" : 2,
					"patching_rect" : [ 545.0, 600.0, 63.0, 17.0 ],
					"id" : "obj-87",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend set",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 545.0, 580.0, 60.0, 31.0 ],
					"id" : "obj-88",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "0. 0.",
					"numinlets" : 2,
					"patching_rect" : [ 482.0, 600.0, 62.0, 17.0 ],
					"id" : "obj-89",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend set",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 482.0, 580.0, 60.0, 31.0 ],
					"id" : "obj-90",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "route 1 2 3",
					"numinlets" : 1,
					"patching_rect" : [ 466.0, 551.0, 76.0, 19.0 ],
					"id" : "obj-91",
					"fontname" : "Geneva",
					"numoutlets" : 4,
					"outlettype" : [ "", "", "", "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "4997.450684 0.000961",
					"linecount" : 3,
					"numinlets" : 2,
					"patching_rect" : [ 419.0, 600.0, 62.0, 41.0 ],
					"id" : "obj-92",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend set",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 419.0, 580.0, 60.0, 31.0 ],
					"id" : "obj-93",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "0. 0.",
					"numinlets" : 2,
					"patching_rect" : [ 395.0, 508.0, 84.0, 17.0 ],
					"id" : "obj-94",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend set",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 390.0, 476.0, 60.0, 31.0 ],
					"id" : "obj-95",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "65.390778 357.2",
					"linecount" : 2,
					"numinlets" : 2,
					"patching_rect" : [ 190.0, 605.0, 62.0, 29.0 ],
					"id" : "obj-96",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend set",
					"numinlets" : 1,
					"patching_rect" : [ 190.0, 580.0, 75.0, 19.0 ],
					"id" : "obj-97",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "69.084091 442.142395",
					"linecount" : 3,
					"numinlets" : 2,
					"patching_rect" : [ 108.0, 599.0, 62.0, 41.0 ],
					"id" : "obj-98",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "prepend set",
					"numinlets" : 1,
					"patching_rect" : [ 110.0, 576.0, 73.0, 19.0 ],
					"id" : "obj-99",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "route 1 2",
					"numinlets" : 1,
					"patching_rect" : [ 154.0, 550.0, 50.0, 19.0 ],
					"id" : "obj-100",
					"fontname" : "Geneva",
					"numoutlets" : 3,
					"outlettype" : [ "", "", "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "© 1997-99 Miller Puckette",
					"numinlets" : 1,
					"patching_rect" : [ 17.0, 80.0, 132.0, 19.0 ],
					"id" : "obj-101",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "512",
					"numinlets" : 2,
					"hidden" : 1,
					"patching_rect" : [ 135.0, 327.0, 26.0, 17.0 ],
					"id" : "obj-102",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number",
					"maximum" : 8188,
					"triscale" : 0.9,
					"numinlets" : 1,
					"patching_rect" : [ 135.0, 346.0, 35.0, 19.0 ],
					"id" : "obj-103",
					"fontname" : "Geneva",
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"outlettype" : [ "int", "bang" ],
					"minimum" : 0,
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Hop size",
					"numinlets" : 1,
					"patching_rect" : [ 133.0, 332.0, 58.0, 19.0 ],
					"id" : "obj-104",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "message",
					"text" : "5000.",
					"numinlets" : 2,
					"hidden" : 1,
					"patching_rect" : [ 160.0, 113.0, 35.0, 17.0 ],
					"id" : "obj-105",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "loadbang",
					"linecount" : 2,
					"numinlets" : 1,
					"hidden" : 1,
					"patching_rect" : [ 261.0, 74.0, 45.0, 31.0 ],
					"id" : "obj-106",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "bang" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "button",
					"numinlets" : 1,
					"patching_rect" : [ 145.0, 225.0, 15.0, 15.0 ],
					"id" : "obj-107",
					"numoutlets" : 1,
					"outlettype" : [ "bang" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "number",
					"triscale" : 0.9,
					"numinlets" : 1,
					"patching_rect" : [ 136.0, 268.0, 35.0, 19.0 ],
					"id" : "obj-108",
					"fontname" : "Geneva",
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"outlettype" : [ "int", "bang" ],
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "timer",
					"numinlets" : 2,
					"hidden" : 1,
					"patching_rect" : [ 129.0, 247.0, 33.0, 19.0 ],
					"id" : "obj-109",
					"fontname" : "Geneva",
					"numoutlets" : 2,
					"outlettype" : [ "float", "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "umenu",
					"items" : [ "Menu", ",", "audio", ",", "sine", ",", "phasor", ",", "noise" ],
					"numinlets" : 1,
					"types" : [  ],
					"patching_rect" : [ 83.0, 121.0, 53.0, 19.0 ],
					"id" : "obj-110",
					"fontname" : "Geneva",
					"numoutlets" : 3,
					"outlettype" : [ "int", "", "" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "selector~ 4",
					"numinlets" : 5,
					"patching_rect" : [ 102.0, 178.0, 134.0, 19.0 ],
					"id" : "obj-111",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "flonum",
					"maximum" : 22000.0,
					"triscale" : 0.9,
					"numinlets" : 1,
					"patching_rect" : [ 160.0, 131.0, 38.0, 19.0 ],
					"id" : "obj-112",
					"fontname" : "Geneva",
					"numoutlets" : 2,
					"htextcolor" : [ 0.870588, 0.870588, 0.870588, 1.0 ],
					"outlettype" : [ "float", "bang" ],
					"minimum" : 10.0,
					"bgcolor" : [ 0.866667, 0.866667, 0.866667, 1.0 ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "adc~ 1",
					"numinlets" : 1,
					"patching_rect" : [ 115.0, 155.0, 45.0, 19.0 ],
					"id" : "obj-113",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "cycle~",
					"numinlets" : 2,
					"patching_rect" : [ 160.0, 155.0, 38.0, 19.0 ],
					"id" : "obj-114",
					"fontname" : "Geneva",
					"numoutlets" : 1,
					"outlettype" : [ "signal" ],
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "ezdac~",
					"numinlets" : 2,
					"patching_rect" : [ 133.0, 290.0, 33.0, 33.0 ],
					"id" : "obj-115",
					"numoutlets" : 0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "gain~",
					"numinlets" : 2,
					"patching_rect" : [ 103.0, 201.0, 22.0, 122.0 ],
					"id" : "obj-116",
					"numoutlets" : 2,
					"orientation" : 2,
					"outlettype" : [ "signal", "int" ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "newobj",
					"text" : "analyzer~ 2048 512 4096 blackman70 0 1 10 3 list",
					"numinlets" : 1,
					"patching_rect" : [ 102.0, 378.0, 377.0, 19.0 ],
					"id" : "obj-117",
					"fontname" : "Geneva",
					"numoutlets" : 8,
					"outlettype" : [ "list", "float", "float", "float", "list", "bang", "list", "list" ],
					"fontsize" : 9.0,
					"color" : [ 0.156863, 0.8, 0.54902, 1.0 ]
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Update rate (ms)",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 135.0, 235.0, 50.0, 31.0 ],
					"id" : "obj-118",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "© 2001 Tristan Jehan",
					"numinlets" : 1,
					"patching_rect" : [ 17.0, 92.0, 107.0, 19.0 ],
					"id" : "obj-119",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Sinusoidal components (freq, amp)",
					"numinlets" : 1,
					"patching_rect" : [ 428.0, 630.0, 167.0, 19.0 ],
					"id" : "obj-120",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "MIDI Pitch",
					"numinlets" : 1,
					"patching_rect" : [ 42.0, 630.0, 53.0, 19.0 ],
					"id" : "obj-122",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Pitch (Hz)",
					"numinlets" : 1,
					"patching_rect" : [ 96.0, 508.0, 52.0, 19.0 ],
					"id" : "obj-123",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Raw MIDI pitch and amplitude",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 383.0, 531.0, 74.0, 31.0 ],
					"id" : "obj-124",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Cooked",
					"numinlets" : 1,
					"patching_rect" : [ 55.0, 445.0, 55.0, 19.0 ],
					"id" : "obj-125",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "up to 100",
					"numinlets" : 1,
					"patching_rect" : [ 479.0, 530.0, 66.0, 19.0 ],
					"id" : "obj-126",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Attack",
					"numinlets" : 1,
					"patching_rect" : [ 366.0, 419.0, 43.0, 19.0 ],
					"id" : "obj-127",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "45",
					"numinlets" : 1,
					"patching_rect" : [ 26.0, 620.0, 23.0, 19.0 ],
					"id" : "obj-128",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Raw MIDI pitch",
					"numinlets" : 1,
					"patching_rect" : [ 695.0, 630.0, 72.0, 19.0 ],
					"id" : "obj-129",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Loudness",
					"numinlets" : 1,
					"patching_rect" : [ 145.0, 423.0, 51.0, 19.0 ],
					"id" : "obj-130",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Documentation",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 223.0, 467.0, 73.0, 31.0 ],
					"id" : "obj-131",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Bark scale, 25 band\n\n",
					"linecount" : 3,
					"numinlets" : 1,
					"patching_rect" : [ 314.0, 403.0, 61.0, 43.0 ],
					"id" : "obj-132",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Loudness",
					"linecount" : 2,
					"numinlets" : 1,
					"patching_rect" : [ 583.0, 136.0, 45.0, 31.0 ],
					"id" : "obj-133",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
, 			{
				"box" : 				{
					"maxclass" : "comment",
					"text" : "Noisiness",
					"numinlets" : 1,
					"patching_rect" : [ 831.0, 138.0, 55.0, 19.0 ],
					"id" : "obj-134",
					"fontname" : "Geneva",
					"numoutlets" : 0,
					"fontsize" : 9.0
				}

			}
 ],
		"lines" : [ 			{
				"patchline" : 				{
					"source" : [ "obj-137", 0 ],
					"destination" : [ "obj-140", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-143", 0 ],
					"destination" : [ "obj-138", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-138", 0 ],
					"destination" : [ "obj-136", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-117", 4 ],
					"destination" : [ "obj-143", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-117", 4 ],
					"destination" : [ "obj-135", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-146", 0 ],
					"destination" : [ "obj-143", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-135", 0 ],
					"destination" : [ "obj-146", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-136", 1 ],
					"destination" : [ "obj-137", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-136", 0 ],
					"destination" : [ "obj-137", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-10", 0 ],
					"destination" : [ "obj-30", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-117", 4 ],
					"destination" : [ "obj-38", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-56", 0 ],
					"destination" : [ "obj-57", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-11", 0 ],
					"destination" : [ "obj-25", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-12", 0 ],
					"destination" : [ "obj-31", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-88", 0 ],
					"destination" : [ "obj-87", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-91", 2 ],
					"destination" : [ "obj-88", 0 ],
					"hidden" : 0,
					"midpoints" : [ 513.5, 573.0, 554.5, 573.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-117", 6 ],
					"destination" : [ "obj-56", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-90", 0 ],
					"destination" : [ "obj-89", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-91", 1 ],
					"destination" : [ "obj-90", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-117", 7 ],
					"destination" : [ "obj-91", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-93", 0 ],
					"destination" : [ "obj-92", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-91", 0 ],
					"destination" : [ "obj-93", 0 ],
					"hidden" : 0,
					"midpoints" : [ 475.5, 573.0, 428.5, 573.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-95", 0 ],
					"destination" : [ "obj-94", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-117", 6 ],
					"destination" : [ "obj-95", 0 ],
					"hidden" : 0,
					"midpoints" : [ 418.357147, 468.0, 399.5, 468.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-117", 5 ],
					"destination" : [ "obj-7", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-78", 0 ],
					"destination" : [ "obj-77", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-81", 1 ],
					"destination" : [ "obj-78", 0 ],
					"hidden" : 0,
					"midpoints" : [ 334.0, 573.0, 355.5, 573.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-117", 6 ],
					"destination" : [ "obj-81", 0 ],
					"hidden" : 0,
					"midpoints" : [ 418.357147, 468.0, 318.5, 468.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-80", 0 ],
					"destination" : [ "obj-79", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-81", 0 ],
					"destination" : [ "obj-80", 0 ],
					"hidden" : 0,
					"midpoints" : [ 318.5, 573.0, 291.5, 573.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-117", 3 ],
					"destination" : [ "obj-10", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-19", 0 ],
					"destination" : [ "obj-111", 4 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-117", 2 ],
					"destination" : [ "obj-11", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-62", 0 ],
					"destination" : [ "obj-63", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-61", 0 ],
					"destination" : [ "obj-62", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-106", 0 ],
					"destination" : [ "obj-61", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-63", 0 ],
					"destination" : [ "obj-111", 3 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-97", 0 ],
					"destination" : [ "obj-96", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-100", 1 ],
					"destination" : [ "obj-97", 0 ],
					"hidden" : 0,
					"midpoints" : [ 179.0, 573.0, 199.5, 573.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-4", 0 ],
					"destination" : [ "obj-5", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-106", 0 ],
					"destination" : [ "obj-4", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-116", 0 ],
					"destination" : [ "obj-115", 1 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-114", 0 ],
					"destination" : [ "obj-111", 2 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-112", 0 ],
					"destination" : [ "obj-114", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-105", 0 ],
					"destination" : [ "obj-112", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-106", 0 ],
					"destination" : [ "obj-105", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-107", 0 ],
					"destination" : [ "obj-109", 1 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-117", 0 ],
					"destination" : [ "obj-100", 0 ],
					"hidden" : 0,
					"midpoints" : [ 111.5, 442.0, 163.5, 442.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-117", 1 ],
					"destination" : [ "obj-12", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-117", 3 ],
					"destination" : [ "obj-107", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-102", 0 ],
					"destination" : [ "obj-103", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-106", 0 ],
					"destination" : [ "obj-102", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-109", 0 ],
					"destination" : [ "obj-108", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-107", 0 ],
					"destination" : [ "obj-109", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-116", 0 ],
					"destination" : [ "obj-115", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-113", 0 ],
					"destination" : [ "obj-111", 1 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-99", 0 ],
					"destination" : [ "obj-98", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-100", 0 ],
					"destination" : [ "obj-99", 0 ],
					"hidden" : 0,
					"midpoints" : [ 163.5, 573.0, 119.5, 573.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-15", 0 ],
					"destination" : [ "obj-117", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-16", 0 ],
					"destination" : [ "obj-117", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-13", 0 ],
					"destination" : [ "obj-117", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-14", 0 ],
					"destination" : [ "obj-117", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-64", 0 ],
					"destination" : [ "obj-117", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-65", 0 ],
					"destination" : [ "obj-117", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-66", 0 ],
					"destination" : [ "obj-117", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-67", 0 ],
					"destination" : [ "obj-117", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-68", 0 ],
					"destination" : [ "obj-117", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-103", 0 ],
					"destination" : [ "obj-117", 0 ],
					"hidden" : 0,
					"midpoints" : [ 144.5, 369.0, 111.5, 369.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-5", 0 ],
					"destination" : [ "obj-117", 0 ],
					"hidden" : 0,
					"midpoints" : [ 181.5, 369.0, 111.5, 369.0 ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-116", 0 ],
					"destination" : [ "obj-117", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-1", 0 ],
					"destination" : [ "obj-117", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-2", 0 ],
					"destination" : [ "obj-117", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-60", 0 ],
					"destination" : [ "obj-116", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-59", 0 ],
					"destination" : [ "obj-116", 0 ],
					"hidden" : 1,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-111", 0 ],
					"destination" : [ "obj-116", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-110", 0 ],
					"destination" : [ "obj-111", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-86", 1 ],
					"destination" : [ "obj-84", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-85", 0 ],
					"destination" : [ "obj-83", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-86", 0 ],
					"destination" : [ "obj-85", 0 ],
					"hidden" : 0,
					"midpoints" : [  ]
				}

			}
, 			{
				"patchline" : 				{
					"source" : [ "obj-117", 0 ],
					"destination" : [ "obj-86", 0 ],
					"hidden" : 0,
					"midpoints" : [ 111.5, 442.0, 50.5, 442.0 ]
				}

			}
 ]
	}

}
