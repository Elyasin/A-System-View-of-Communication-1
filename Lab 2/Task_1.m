% The channel_type variable changes the properties of the channel.
% Here we assume that measurements of the transmitter and receiver
% waveforms are synchronized, i.e. made at the same time.
channel_type = 'sync';
distance = 10;  % distance from transmitter to receiver

% define step-like waveform to send over channel
tx_wave = [zeros(1,150) ones(1,250)];

% send over a channel where transmitter and receiver are separated by an
% amount contained in the variable distance.
rx_wave=txrx(tx_wave,distance,channel_type);  
    
% fit_rcv(rx_wave,c,d,k,a) fits rx_wave by a function of the form
%     y(n) = c + k*(1-a^(n-d)) for n >= d and 0 otherwise. 
% modify the values below to find the correct fit
% % % Revise the following code % % %
c = 0.23;
d = 150;
k = 0.6;
a = 0.93;
% % % Do not change the code below % % %

mse = fit_rcv(rx_wave,c,d,k,a);  % fit channel output to model
title(['distance = ' num2str(distance)]); % put title on graph
display(['MSE = ' num2str(mse)]); % print out MSE of fit