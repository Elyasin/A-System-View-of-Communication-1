% The channel_type variable changes the properties of the channel.
% Here we assume a channel that is more noisy than previous channels.
channel_type = 'noisy';

distance = 11;  % set the transmission distance
SPB = 50;      % bit time in samples

tx_bs = rand(1,1280) > 0.5;          % generate a random bit sequence
tx_wave = format_bitseq(tx_bs,SPB);  % create waveform following protocol
% transimit and receive over noisy channel
rx_wave = txrx(tx_wave,distance,channel_type);
start_ind = find_start(tx_wave); % get start index
[rx_min,rx_max,sigma] = get_noise_params; % get true noise parameters

sample_ind = start_ind+2*SPB-1+SPB*[0:1279];

plist = -1:0.1:2; % list of threshold parameters
np = length(plist);
thresh = zeros(1,np);
empirical_BER = zeros(1,np);
for i=1:np,
    p = plist(i); % set threshold control parameter
    thresh(i) = rx_min+p*(rx_max-rx_min);             % set the threshold
    decoded_bs = rx_wave(sample_ind) > thresh(i);     % decode bit stream
    empirical_BER(i) = compute_BER(tx_bs,decoded_bs); % compute the BER
end

% display results
plot(thresh,empirical_BER,'b','LineWidth',2);
hold on;
plot(rx_min*[1 1],[0 1],'r','LineWidth',2);
plot(rx_max*[1 1],[0 1],'r','LineWidth',2);
hold off;
set(gca,'XTick',rx_min+(rx_max-rx_min)*[-1:0.5:2]);
axis([min(thresh) max(thresh) 0 1]);
title('BER as a function of threshold');
xlabel('threshold');
ylabel('BER');
text(rx_max,0.95,' rx_{max}','Color','r');
text(rx_min,0.95,' rx_{min}','Color','r');
grid

