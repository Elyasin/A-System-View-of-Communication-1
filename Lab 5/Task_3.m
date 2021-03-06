
tx_bs=rand(1,1280)>0.5;        % generate a random bit sequence
SPB = 15;                      % bit time in samples

% transmit/receive bit sequence 
tx_wave = format_bitseq(tx_bs,SPB);  % create waveform following protocol
rx_wave = txrx(tx_wave); % simulate channel

threshold = get_threshold(rx_wave);  % set threshold
start_ind = find_start(rx_wave);     % find start bit

% plot eye diagram
subplot(211)
eye_diagram(rx_wave,start_ind,SPB); % plot eye diagram
title(['Eye diagram, SPB = ' num2str(SPB)]);
xlabel('Sample index');
ylabel('Amplitude');

% evaluate BER if make bit comparisons at ind1
ind1 = 14;      % index of eye diagram to perform bit comparisons
hold on;
h = plot([ind1 ind1],[-0.1 1.1]);  % show ind1 on eye diagram 
set(h,'Color','r','LineWidth',2)
hold off;
sample_ind = start_ind + SPB + ind1 + SPB*[0:1279]; % choose subsampling points
rx_bs = rx_wave(sample_ind) > threshold;
BER1 = compute_BER(tx_bs,rx_bs);  % compute the BER  
disp(['BER if comparing at index ' num2str(ind1) ' is ' num2str(BER1)]);

% systematically sweep through all comparison locations
ind_list = [0:2*SPB];         % list of indices for bit comparison
BER = zeros(size(ind_list));  % initialize BER


% Put your code here that
%   1. Computes the BER if we compare at each index listed in ind_list
%   2. Stores the BER in the corresponding element of the vector BER
for i = ind_list;
    sample_i = start_ind + SPB + i + SPB*[0:1279];
    rx_bs = rx_wave(sample_i) > threshold;
    BER(i+1) = compute_BER(tx_bs, rx_bs);
end;

% plot BER versus index where comparison is performed
% do not modify code beyond this point
subplot(212)
plot(ind_list,BER,'g','Linewidth',2); % plot BER curve
hold on;
plot(ind1,BER1,'r*','Linewidth',2);   % indicate BER at eye_ind1
hold off;
grid on;
title('BER as a function of comparison point');
xlabel('Index for bit comparison');
ylabel('Bit error rate');
axis([0 2*SPB 0 1]);

