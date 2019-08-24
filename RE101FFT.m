% The FFT calculation based on results obtained from the oscilloscope
% (Rigol DS4024). The correction factor is taken into account as specified in 
% MIL-STD-461F Appendix A on page 209 for a 50uH LISN.
function [fVec, MagneticField, signalPeak, signalPeakFreq, signalPeakIndex, B, maxamp] = RE101FFT(Fs, numberOfFiles, data)

% Analyse all the files in 'data'
M = csvread(data(numberOfFiles, 1:end));

% Voltage Amplitude [V] and Sequence
amplitude = M(3:end,2);
sequence = M(3:end,1);

% Number of turns on the receiving coil based on requirements
N = 36;
% Diameter of the receiving coil
r = 0.133/2;
% Surface
A = pi*r^2;
% Distance from center
z = 0;
u_0 = 4*pi*10^(-7);
f = 5000;

%Set zero pad depth (Radix 2);
zeroPadDepth = 0;

% Remove DC component from the data and take RMS
amplitude = amplitude - mean(amplitude);
amplitude = amplitude/sqrt(2);
maxamp = max(amplitude);

% Length of FFT to be same as Sampling frequency or higher. With the equal value
% of measured points the results are most accurate (Tested with signal generator)
%nfft = 2^((nextpow2(length(amplitude)))+zeroPadDepth);
nfft = length(amplitude);

% Fast Fourier Transform with padding of zeros so that length(Signal) is
% equal to nfft
Signal = fft(amplitude, nfft);

% Takes only one side
Signal = Signal(1:nfft/2 + 1);

% Take magnitude of FFT of Signal
SignalMagnitudeAbs = abs(Signal);

% Normalisation and taking into account the total power (x2)
SignalMagnitude = SignalMagnitudeAbs/nfft;

% Frequency Vector
fVec = (Fs/2)*linspace (0, 1, nfft/2 + 1);

% Faraday's law for Receiving coil's Magnetic field [Wb]
B_flux = (SignalMagnitude)./(fVec'.*2*pi*N);
% Magnetic flux density, T = Wb/m^2 [T]
B = B_flux/A;
% Converting T to dBpT (required for data presentation)
MagneticField = 20*log10(B*10^12);

% Maximum peak value from an range of interest
MagneticFieldMax = MagneticField(75:5000);
% Location of peak
[signalPeak signalPeakIndex5] = max(MagneticFieldMax);
signalPeakIndex = signalPeakIndex5+75;
signalPeakFreq = fVec(1, signalPeakIndex); 
endfunction