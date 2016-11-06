function codeword = blk_encoder(msg)
% BLK_ENCODER encode a 4 bit message using an (8,4,3) parity bit code
%     CODEWORD = BLK_ENCODER(MSG) takes an 4 bit input vector (MSG)
%     and returns a 8 bit vector CODEWORD composed of the message 
%     and 4 parity bits

% Modify the code below 
% 1. Calculate the 4 parity bits by taking the exclusive or (xor)
%    of bits 1 and 2, 3 and 4, 1 and 3 and 2 and 4.
% 2. Concatenate the parity bits to the message bits
    parity = [xor(msg(1),msg(2)) xor(msg(3),msg(4)), xor(msg(1),msg(3)), xor(msg(2),msg(4))];
    codeword = [msg parity];
end

