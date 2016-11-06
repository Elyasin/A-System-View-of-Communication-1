% The channel_type variable changes the properties of the channel.
% Here we assume a channel that is more noisy than previous channels.
channel_type = 'noisy';

SPB = 50;                           % bit time in samples
tx_bs = rand(1,1280)>0.5;           % generate a random bit sequence
tx_wave = format_bitseq(tx_bs,SPB); % create waveform following protocol

distance_list = [8:2:50];           % list of transmission distances
num_dist = length(distance_list);
empirical_BER = zeros(1,num_dist);  % initialize storage arrays
predicted_BER = zeros(1,num_dist);
SNR = zeros(1,num_dist);

% loop over transmission at different distances
for i = 1:num_dist,
    distance = distance_list(i);
    % transmit and receive over noisy channel
    rx_wave = txrx(tx_wave,distance,channel_type);
    start_ind = find_start(tx_wave); % get start index
    [rx_min,rx_max,sigma] = get_noise_params; % get true noise parameters

    thresh = 0.5*(rx_max+rx_min);                % set the optimal threshold
    sample_ind = start_ind+2*SPB-1+SPB*[0:1279]; % set subsampling points
    decoded_bs = rx_wave(sample_ind) > thresh;   % decode bit stream
    empirical_BER(i) = compute_BER(tx_bs,decoded_bs);  % compute BER

    % Add your code below to
    % 1. Compute the values of predicted_BER 
    % 2. Compute the values of SNR 
    % from the values of rx_min, rx_max and sigma returned by txrx
    p_e0 = qfunc( (thresh-rx_min) / sigma );
    p_e1 = ( 1 - qfunc( (thresh-rx_max) / sigma ));
    predicted_BER(i) = 0.5 * p_e0 + 0.5 * p_e1;
    p_signal = (rx_max - rx_min)^2;
    p_noise = 4 * sigma^2;
    SNR(i) = 10 * log10(p_signal/p_noise);
    
end

% display the results
subplot(2,1,1)
plot(distance_list,predicted_BER,'r','LineWidth',2);
hold on;
plot(distance_list,empirical_BER,'bx','LineWidth',2);
hold off;
axis([0 50 0 0.5]);
legend('predicted BER','empirical BER','Location','southeast');
title('BER as a function of distance');
ylabel('BER');
grid;
subplot(2,1,2)
plot(distance_list,SNR,'r','LineWidth',2)
title('SNR as a function of distance');
ylabel('SNR (dB)');
xlabel('distance');
axis([0 50 -20 20]);
grid;

