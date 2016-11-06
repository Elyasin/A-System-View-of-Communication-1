% create a random 4 bit message 
my_msg = rand(1,4) > 0.5;
 
% call your function to get the codeword for the message msg
my_codeword = blk_encoder(my_msg);

% show the message and the codeword
display(sprintf('Message:\t[%s]',num2str(my_msg)));
display(sprintf('Codeword:\t[%s]',num2str(my_codeword)));
