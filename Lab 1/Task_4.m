tx_msg = 'Hello';  % message to transmit
SPB = 10;        % bit time in samples per bit

% transmitter %
tx_bs = text2bitseq(tx_msg);           % change text message to bit sequence
tx_wave = bitseq2waveform(tx_bs,SPB);  % change bit sequence to waveform

% The following command is needed so that we satisfy the communication 
% protocol.  We will study this later in the part of the course.
tx_wave1 = satisfy_protocol(tx_wave,SPB); 

% channel %
rx_wave = txrx(tx_wave1);     % transmit waveform through channel

% receiver
rx_bs = waveform2bitseq(rx_wave,SPB);  % change waveform to bit sequence 

%------rx_msg=bitseq2text(rx_bs)-------
% % % Revise the following code % % %
num_chars = length(tx_msg);       % assume receiver knows length of tx_msg
rx_msg = [];                      % initialize the message
for i=1:num_chars,                % cycle through bit stream
    byte = rx_bs((i-1)*8+[1:8]);  % extract i'th byte
    data = byte(1)*128+byte(2)*64+byte(3)*32+byte(4)*16+byte(5)*8+byte(6)*4+byte(7)*2+byte(8);
    rx_msg(i) = char(data);       % convert decimal data to character 
end
% % % Do not change the code below % % %

diagram_lab01(tx_bs,tx_wave,rx_wave,rx_bs,SPB);  % generate plots
display_lab01(tx_msg,rx_msg);                    % display text messages
