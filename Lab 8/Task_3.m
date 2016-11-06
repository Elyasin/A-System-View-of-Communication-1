% The channel_type variable changes the properties of the channel.
% Here we assume a channel that is more noisy than previous channels.
channel_type = 'noisy';

distance = 8;             % set the transmission distance
tx_bs = rand(1,1280)>0.5; % generate a random bit sequence

SPBlist = [50 20 10];     % list of bit times in samples
num_SPB = length(SPBlist);
for i = 1:num_SPB
    SPB = SPBlist(i);
    tx_wave = format_bitseq(tx_bs,SPB); % create waveform following protocol
    % transmit and receive over noisy channel
    rx_wave = txrx(tx_wave,distance,channel_type);
    start_ind = find_start(tx_wave); % get start index
    [rx_min,rx_max,sigma] = get_noise_params; % get true noise parameters

    sample_ind = start_ind+2*SPB-1+SPB*[0:1279];
    thresh = 0.5*(rx_max+rx_min);              % set threshold
    decoded_bs = rx_wave(sample_ind) > thresh; % decode bit stream
    
    empBER = compute_BER(tx_bs,decoded_bs);  % compute BER
    predBER = predict_BER(rx_min,rx_max,sigma,thresh,0.5); % predicted BER
    
    subplot(3,1,i);
    % plot the histgram
    diagram_lab08(rx_wave,rx_min,rx_max,sigma,start_ind,1280,SPB);
    % display the results
    disp(['At bit time ' num2str(SPB) ...
        ' samples, the predicted BER is ' ...
        num2str(predBER) ' and the empirical BER is '...
        num2str(empBER) '.'])
end