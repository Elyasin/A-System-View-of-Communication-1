
bitseqs = bit_seq_gen();   % create three random bit sequences
frameseqs = cell(1,length(bitseqs)); % initialize holder for output

% this for loop runs the code for each of the three bit sequences
for c = 1:length(bitseqs),  
    bs = bitseqs{c};
    
    % start of code for frame_bs.m
    % % % Revise the following code % % %
    frame = bs;
    len = length(bs);
    if len < 1280
        frame = [ 1 bs zeros(1, 1280 - len) 0 ];
    elseif len == 1280
        frame = [ 1 bs 0 ];
    else
        frame = [ 1 bs(1:1280) 0 ];
    end
    
    % % % Do not change the code below % % %
    % end of frame_bs.m code
 
    
    frameseqs{c} = frame; 
end

check_framing(bitseqs,frameseqs); % check correctness of frames