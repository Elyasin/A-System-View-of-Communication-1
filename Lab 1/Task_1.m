% % % Revise the following code % % %
tx_msg = 'Finished!';  % message to transmit
SPB = 20;       % bit time in samples per bit
% % % Do not change the code below % % %

% transmitter %
tx_bs = text2bitseq(tx_msg);           % change text message to bit sequence
tx_wave = bitseq2waveform(tx_bs,SPB);  % change bit sequence to waveform
% The following command is needed so that we satisfy the communication 
% protocol.  We will study this later in the course.
tx_wave1 = satisfy_protocol(tx_wave,SPB); 

% channel %
rx_wave = txrx(tx_wave1);     % transmit waveform through channel

% receiver %
rx_bs = waveform2bitseq(rx_wave,SPB);  % change waveform to bit sequence 
rx_msg = bitseq2text(rx_bs);           % change bit sequence to text message

diagram_lab01(tx_bs,tx_wave,rx_wave,rx_bs,SPB);  % generate plots
display_lab01(tx_msg,rx_msg);                    % display text messages