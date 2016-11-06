% The channel_type variable changes the properties of the channel.
% Here we assume that measurements of the transmitter and receiver
% waveforms are synchronized, i.e. made at the same time.
channel_type = 'sync';

tx_wave = [zeros(1,150) ones(1,250)];  % define step-like waveform

distance_list = [10 20 30]; % list of distances to simulate
num_dist = length(distance_list);
mse_list = zeros(1,num_dist);

% parameters of best fits for each distance
% modify these to find the best fit at each distance
% % % Revise the following code % % %
c_list = [0.23 0.25 0.265];
d_list = [150 150 150];
k_list = [0.6 0.15 0.07];
a_list = [0.93 0.93 0.93];
% % % Do not change the code below % % %


% the for loop below simulates the channel at each distance
for i = 1:num_dist,  
    figure(i)
    distance = distance_list(i);  % set distance
    rx_wave=txrx(tx_wave,distance,channel_type);  % simulate channel
    mse_list(i) = fit_rcv(rx_wave, c_list(i), d_list(i), k_list(i), a_list(i));
    title(['distance = ' num2str(distance)]); % put title on graph
end

for i = 1:num_dist,
    display(['MSE at distance ' num2str(distance_list(i)) ...
        ' = ' num2str(mse_list(i))]);
end