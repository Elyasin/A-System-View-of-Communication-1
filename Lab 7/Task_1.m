% The channel_type variable changes the properties of the channel.
% Here we assume a channel that is more noisy than previous channels.
channel_type = 'noisy';
distance = 10;

SPB = 50;                            % bit time in samples

tx_bs = zeros(1,1280);               % generate the all-zero bit sequence 
tx_wave = format_bitseq(tx_bs,SPB);  % create waveform following protocol

% transmit and receive over noisy channel
rx_wave = txrx(tx_wave,distance,channel_type);
start_ind = find_start(tx_wave); % get start index
[rx_min,rx_max,sigma] = get_noise_params; % get true noise parameters

sample_ind = start_ind+2*SPB-1+SPB*[0:1279]; % set subsampling points
signal_samples = rx_wave(sample_ind);        % get the received samples 

xhist = 0.1:0.01:0.7;    % determines the histogram bins
% Do not modify code above this line

nsamp = 80;   % number of samples to use for histogram

% Place your code below that plots the normalized histogram of 
% the first nsamp=80 samples from the vector signal_samples.
% 1. Use the function histogram
% 2. Use the vector xhist defined above as bin edges
% 3. The values of the histogram should be normalized to sum to one.
histogram(signal_samples(1:nsamp),xhist,'Normalization','probability')

% Do not modify code below this line       
% Plot histogram predicted by Gaussian distribution
hold on; % all plots on the same figure

plot_ghist(xhist,rx_min,sigma);      % predicted histogram
title(['Number of Samples = ' num2str(nsamp) ]); % add title
xlabel('Received signal');
ylabel('Frequency (%)');
hold off;