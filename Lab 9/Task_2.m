rep = 3;
tx_msg = tx_msg_gen();                          % pick a random text message
display(['The encoded message: ' tx_msg]);      % display the text message
bs_raw = text2bitseq(tx_msg);                   % change text message to bit sequence
bs_enc = rep_encode_bs(bs_raw, rep);
% Simulate transmission with noise. Here we assume that at most one bit
% error is introduced in every rep=3 bit codeword.
bs_out = binary_channel(bs_enc,rep,'max_one'); 


bs_dec = [];
for i = 1:(length(bs_out)/rep),                 % loop to get all codewords
    codeword = bs_out((i-1)*rep+1:i*rep);      % get the ith codeword 
    % --------Repetition Decoder-----------
    % decode codewords with error correction    
 
    % Modify the code below to 
    %  1. decode the repetition codeword with error correction and return 1 bit information for each code word
    %  2. reconstruct the original bit sequence
    %bs_dec = codeword;
    if sum(codeword) >= 2;
        bs_dec = [bs_dec 1];
    else
        bs_dec = [bs_dec 0];
    end;
    % do not modify the code below

end

rx_msg = bitseq2text(bs_dec);    % Recover the text message from bit sequence
display(['The decoded message: ' rx_msg]); % display the decoded message