tx_msg = tx_msg_gen();                          % pick a random text message
display(['The encoded message: ' tx_msg]);      % display the text message
bs_raw = text2bitseq(tx_msg);                   % change text message to bit sequence

% --------Repetition Encoder-----------
% encode bitstream with error correction

% Modify the code below to repeat each bit three times
%bs_enc = bs_raw;
bs_enc = [];
for i=1:length(bs_raw);
    bs_enc = [bs_enc bs_raw(i) bs_raw(i) bs_raw(i)];
end;

% Do not modify the code below     

% Simulate transmission with noise. Here we assume that at most one bit
% error is introduced in every 3 bit codeword.
bs_out = binary_channel(bs_enc,3,'max_one'); 

bs_dec = rep_decode_bs(bs_out);   % decode bitstream with error correction

rx_msg = bitseq2text(bs_dec);    % Recover the text message from bit sequence
display(['The decoded message: ' rx_msg]); % display the decoded message