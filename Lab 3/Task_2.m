%% code
tx_bs = rand(1,1280) > 0.5; % generate random bit sequence
SPB=5;                      % bit time in samples

% transmitter %
tx_bs_frame = frame_bs(tx_bs);              % add start and stop bit and generate framed block 
tx_wave = bitseq2waveform(tx_bs_frame,SPB); % create a samples waveform with SPB samples per bit
tx_wave = add_training(tx_wave);            % add a training sequence

%channel
%rx_wave=txrx_lab03(tx_wave,15); % simulate channel with distance=15 cm
rx_wave=txrx(tx_wave,15); % simulate channel with distance=15 cm

n = [1:3000];
figure(1);

% % % Revise the following code % % %
%---your code here to generate the plot of tx_wave---
plot(n, tx_wave(1:3000));

% % % Do not change the code below % % %
grid on;                 % create grid
title('Channel Input');  % create plot title
xlabel('sample index');  % label X axis
ylabel('amplitude');     % label Y axis

figure(2)
grid on;
% % % Revise the following code % % %
%---your code here to generate and label the plot of rx_wave---
plot(n, rx_wave(1:3000));
title('Channel Output');
xlabel('sample index');
ylabel('amplitude');

% % % Do not change the code below % % %    