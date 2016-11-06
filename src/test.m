1;
addpath('feature-extraction','feature-matching');

mfcc = extractFeatures('recorder/data/test1.wav');
codebook = lbg(mfcc,0.0001,16)
