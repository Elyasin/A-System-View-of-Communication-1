% create a random message
msg = rand(1,4) > 0.5;
%create codeword using the blk_encoder function
codeword = blk_encoder(msg);
% change a random bit of the message to simulate an error
error_loc = randi(8,1);
error_codeword = codeword; 
error_codeword(error_loc) = not(error_codeword(error_loc));

% test your function
msg1 = blk_decoder(codeword);
msg2 = blk_decoder(error_codeword);

% display the orginal and the received message
display(sprintf('Initial message:\t[ %s ]\n',num2str(msg)));
display(sprintf('Correct codeword:\t[ %s ]',num2str(codeword)));
display(sprintf('Decoded message:\t[ %s ]\n',num2str(msg1)));
display(sprintf('Codeword w/error:\t[ %s ]',num2str(error_codeword)));
display(sprintf('Decoded message:\t[ %s ]',num2str(msg2)));
