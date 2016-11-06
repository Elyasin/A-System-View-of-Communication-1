tx_bs=rand(1,1280)>0.5;      % generate a random bit sequence
SPB=20;                      % bit time in samples

% transmitter %
tx_wave = format_bitseq(tx_bs,SPB);  % create waveform following protocol

% channel %
rx_wave = txrx(tx_wave);

% receiver %
start_ind=find_start(rx_wave);       % find start bit

figure(1);
% Place your code below that
%   1. Creates the eye diagram of rx_wave, plotting "2*SPB+1" samples in each trace.  
%      Hint: use for loop.
%   2. Superimposes all the traces on the same plot. 
%      Hint: use command hold on.
n = [0:2*SPB];
for index = start_ind:2*SPB:start_ind + 639 * 2 * SPB;
    plot(n, rx_wave(index:index + 2 * SPB));
    hold on;
end;

% code to label plot -- do not modify
title('Eye Diagram, SPB = 20');
xlabel('Sample index')
ylabel('Amplitude');
grid on;