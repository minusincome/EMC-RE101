% Purpose:    Data analysis with Fast Fourier Tranform (FFT) for EMC pre-compliance 
%             testing based on MIL-STD-461F CE102
% Equipment:  Oscilloscope Rigol DS4024
%             LISN 50uH
% Version:    1.0, March 2019
% Author:     Siiri Talvistu
% TODO: 
%    - Indicate, if the measured value goes above the limit line. 
%      Not relevant for calibration.
clear all
close all

% Sampling frequency of oscilloscope - must be concurrent with actual measurement
Fs = 5*10^7; 

%% INPUT: 
% Measured data files
data =[''];

% FFT as many times as there are files in 'data'
A = rows(data);

%% Saving plots to a directory
% TO SAVE '1' or NOT TO SAVE '0'. That is the question.
saveFile = 1;

% SAVE AS. The saved title includes also a date and iteration sequence number
fileTitle = 'RE101_';
% SAVE LOCATION. Needs to be an already existing folder
filePath = '';

for numberOfFiles = 1:A
% Fast Fourier Transform of measured data
[fVec, MagneticField, signalPeak, signalPeakFreq, signalPeakIndex, B, maxamp] = RE101FFT(Fs, numberOfFiles, data);

% For ambient measurement display, use the first data file as the ambient 
% measurement and it will plot ambient under the signal
if (numberOfFiles == 1)
  % The ambient measurements were taken with a x10 probe and the oscilloscope 
  % probe settings were also set to x10, hence '-20'
  ambient = MagneticField-20; 
endif

% Plot figures of all given 'data' files
RE101results(fVec, MagneticField, numberOfFiles, saveFile, ambient, signalPeak, signalPeakFreq, fileTitle, filePath, maxamp);
endfor