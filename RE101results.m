% FFT measurement results along with RE101 limit on a logarithmic frequency scale
function RE101results(fVec, MagneticField, numberOfFiles, saveFile, ambient, signalPeak, signalPeakFreq, fileTitle, filePath, maxamp)

% Limit line according to RE101 requirement
limit = 'RE101limit.csv';
N = csvread(limit);
limitx = N(3:4, 1);
limity = N(3:4, 2);

% Frequency limits of the standard, 10Hz - 1MHz
f_high = 10^5;
f_low = 30;

figure(numberOfFiles);
semilogx(fVec, ambient, "color", 'm',...
       fVec, MagneticField, "color", 'b',...
       limitx, limity, "color", 'r', ...
       signalPeakFreq , signalPeak, "color", 'r', "marker", 'o' );
       
% Show result from 10kHz to 30MHz and 0 to 60mV
axis([f_low, f_high, -50, 200]);
xlabel('Frequency (Hz)');
ylabel('Limit Level (dBpT)');
legend('Ambient', 'Data', 'Limit', 'Marked Peak');
grid on;

% Show maximum amplitude and its frequency on the plot
signalPeakFreqkHz = signalPeakFreq/10^3;
signalPeakString = num2str(signalPeak);
signalPeakFreqString = num2str(signalPeakFreqkHz);
mVPeakString = num2str(maxamp*1000);
peakMax = strcat("Marked Peak:\n", mVPeakString, " mV \n", signalPeakFreqString, " kHz");
dim = [.2 0.2 0.3 0.3];
annotation("textbox", dim, "edgecolor", 'w', "String", peakMax);

% Titles for the plot, following the order of the files in 'data'
RE101titleNames(numberOfFiles);

% Save plots as jpg images. saveFile is defined in main
if (saveFile == 1)
  fileNumber = num2str(numberOfFiles);
  fileDate = datestr(now(), 29);
  fileName = strcat(fileTitle, fileDate, "_", fileNumber)
  saveas(numberOfFiles, fullfile(filePath, fileName), 'jpg');
endif
endfunction