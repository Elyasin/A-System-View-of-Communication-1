% Copy your code in Task 3 where you generated the empirical and predicted histograms 
% for the received signal when IN=0 and IN=1, respectively.

% The channel_type variable changes the properties of the channel.
% Here we assume a channel that is more noisy than previous channels.
channel_type = 'noisy';

SPB = 50;               % bit time in samples
distance = 14;           % transmission distance

tx_bs = [1:1280] > 640; % generate bit sequence of 640 0's and 640 1's
tx_wave = format_bitseq(tx_bs,SPB);   % create waveform following protocol

% transmit and receive over noisy channel
rx_wave = txrx(tx_wave,distance,channel_type);
start_ind = find_start(tx_wave); % get start index
[rx_min,rx_max,sigma] = get_noise_params; % get true noise parameters

sample_ind = start_ind + 2*SPB-1 + SPB*[0:1279];  % choose subsampling points
signal_samples = rx_wave(sample_ind);             % extract samples

xhist = 0.1:0.01:0.7;   % centers of histogram bins
% Do not modify code above this line



subplot(2,1,1)
% Place your code below that plots the empirical normalized histogram of the 
% received signal samples when IN=0
histogram(signal_samples(1:640),xhist,'Normalization','probability')

% Do not modify next six lines
hold on;                        % all plots on the same figure
plot_ghist(xhist,rx_min,sigma); % plot histogram predicted by Gaussian
title(['Histogram of received signals when IN=0']);  % add title
xlabel('Received signal');
ylabel('Frequency (%)');
hold off;
% Plot empirical and predicted histograms when IN=1
subplot(2,1,2)

% Place your code below that 
% 1. Plots the empirical normalized histogram of the received signal samples when IN=1
% 2. Plots the predicted histogram using plot_ghist on the same figure
histogram(signal_samples(641:1280),xhist,'Normalization','probability')
hold on;                        % all plots on the same figure
plot_ghist(xhist,rx_max,sigma); % plot histogram predicted by Gaussian

% do not modify code below this line
title(['Histogram of received signals when IN=1']);  % add title
xlabel('Received signal');
ylabel('Frequency (%)');
