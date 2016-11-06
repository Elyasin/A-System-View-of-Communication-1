% setup transmission parameters
distance_list = [10 15];
SPB_list = [50 20];
num_dist = length(distance_list);
BER = zeros(1,num_dist);             % store bit error rates
setup_lab0303; % setup other storage variables

tx_bs = rand(1,1280) > 0.5;  % create sequence of 1280 random bits

for i = 1:num_dist,
    distance = distance_list(i); % transmission distance
    SPB=SPB_list(i);             % bit time in samples per bit
    
    % transmitter %
    tx_bs_frame = frame_bs(tx_bs);              % generate frame
    tx_wave = bitseq2waveform(tx_bs_frame,SPB); % create waveform
    tx_wave = add_training(tx_wave);            % add training sequence
    
    % channel %
    %rx_wave=txrx_lab03(tx_wave,distance);  % simulate channel
    rx_wave=txrx(tx_wave,distance);  % simulate channel
    % receiver %
    start_ind=find_start(rx_wave); % find start bit
    
    % % % Revise the following code % % %
    threshold = (max(rx_wave) + min(rx_wave)) / 2;   % set threshold
    sample_ind = start_ind + [2*SPB-1:SPB:1281*SPB]; % set subsampling points 
    rx_bs = rx_wave(sample_ind) > threshold;         % make bit decisions
    % % % Do not change the code below % % %     
   
    % display received wave, threshold and subsampling points
    display_lab03;
end
