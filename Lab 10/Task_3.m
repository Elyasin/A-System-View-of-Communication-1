num_bits=30000;
bs_raw = rand(1,num_bits)>0.5;    % generate a random bit sequence
distance_list = [1:50];           % list of transmission distances
num_dist = length(distance_list);
BER_no_ecc = zeros(1,num_dist);   % initialize storage arrays
BER_rep_ecc = zeros(1,num_dist);
BER_blk_ecc = zeros(1,num_dist);

rep = 7; % number of repetitions
bs_rep_enc = rep_encode_bs(bs_raw,rep);   % repetition code encoder 
bs_blk_enc = blk_encode_bs(bs_raw);       % (8,4,3) block code encoder

% loop over different transmission distances
for i = 1:num_dist,
    distance = distance_list(i);
    bs_no_ecc = binary_channel(bs_raw,distance);        % simulate the transmission over binary channel
    bs_rep_out = binary_channel(bs_rep_enc,distance);   
    bs_blk_out = binary_channel(bs_blk_enc,distance);  

    bs_rep_dec = rep_decode_bs(bs_rep_out,rep);         % repetition code deocder
    bs_blk_dec = blk_decode_bs(bs_blk_out);             % (8,4,3) block code deocder
    
    BER_no_ecc(i) = compute_BER(bs_raw,bs_no_ecc);      % compute bit error rate
    BER_rep_ecc(i) = compute_BER(bs_raw,bs_rep_dec);    
    BER_blk_ecc(i) = compute_BER(bs_raw,bs_blk_dec); 
end
% display the results, do not modify the code below
figure(1)
plot(distance_list,BER_no_ecc,'r','LineWidth',2);
hold on;
plot(distance_list,BER_rep_ecc,'bx','LineWidth',2);
hold on;
plot(distance_list,BER_blk_ecc,'gx','LineWidth',2);
hold off;
axis([0 50 0 0.5]);
legend('BER\_no\_ecc','BER\_rep\_ecc','BER\_blk\_ecc','Location','southeast');
title('BER vs. Transmission Distance');
xlabel('Transmission Distance');
ylabel('BER');
grid;
