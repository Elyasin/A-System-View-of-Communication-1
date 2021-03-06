tx_bs=rand(1,1280)>0.5; % generate sequence of 1280 random bits

SPBlist = 1:15;             % list of bit times to test
num_SPB = length(SPBlist);  % number of bit times to test
BER = zeros(1,num_SPB);     % initialize bit error rate array

for i = 1:num_SPB,         %generate the SPB list
    SPB = SPBlist(i);
    tx_wave = format_bitseq(tx_bs,SPB);  % create waveform following protocol
    %rx_wave = txrx_lab03(tx_wave);       % simulate channel  
    rx_wave = txrx(tx_wave);       % simulate channel 
    rx_bs = waveform2bitseq(rx_wave,SPB,0);  % decode received waveform
    BER(i) = compute_BER(tx_bs,rx_bs);  % compute the BER
end

figure(1);

% Place your code below that
%   1. computes bit rate in MHz for each bit time in SPBList assuming Fs =
%   500kHz
bitrate = 0.5./SPBlist;
%   2. plots BER and bit rate versus bit time in samples on the same
%   graph
plot(SPBlist,BER,'r');
hold on;
plot(SPBlist,bitrate,'b');

% code to label plot -- do not modify
title('Bit Error Rate and Bit Rate');
xlabel('Bit Time (samples)')
ylabel('BER or Bit Rate (MHz)');
legend('bit error rate','bit rate');
