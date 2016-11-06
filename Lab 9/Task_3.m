num_bits=12800;
bs_raw = rand(1,num_bits)>0.5;    % generate a random bit sequence
distance_list = [1:50];           % list of transmission distances
num_dist = length(distance_list);
BER_no_ecc = zeros(1,num_dist);   % initialize storage arrays
BER_ecc = zeros(1,num_dist);
bs_enc = rep_encode_bs(bs_raw);   % encode bitstream 

% loop over different transmission distances
for i = 1:num_dist,
    distance = distance_list(i);
    bs_out = binary_channel(bs_enc,distance);           % simulate the transmission
    bs_dec_no_ecc = bs_out(1:3:3*num_bits);             % detection without coding
    BER_no_ecc(i) = compute_BER(bs_raw,bs_dec_no_ecc);  % compute bit error rate

    % Modify the code below to  
    %    1. identify the total number of codewords  
    %    2. decode the codewords 
    %    3. compute the BER performance
    %BER_ecc(i) = 0.5;
    bs_dec = [];
    for j = 1:(length(bs_out)/3),              % loop to get all codewords
        codeword = bs_out((j-1)*3+1:j*3);      % get the ith codeword 
        if sum(codeword) >= 2;
            bs_dec = [bs_dec 1];
        else
            bs_dec = [bs_dec 0];
        end;
    end
    BER_ecc(i) = compute_BER(bs_raw, bs_dec);
    
    % display the results, do not modify the code below

end
figure(1)
plot(distance_list,BER_no_ecc,'r','LineWidth',2);
hold on;
plot(distance_list,BER_ecc,'bx','LineWidth',2);
hold off;
axis([0 50 0 0.5]);
legend('BER\_no\_ecc','BER\_ecc','Location','southeast');
title('BER as a function of distance');
ylabel('BER');
grid;