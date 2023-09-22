% Function to compute entropy
function H = textEntropy (text)
    text = upper(text);
    text = regexprep(text, '[^A-Z]', ''); % Remove non-alphabetic
    freqs = histc(double(text) - 64, 1:26);
    %idx = find (freqs > 0);
    %freqs = freqs(idx);
    freqs = freqs( freqs > 0 );
    p = freqs / length(text);
    H = - sum (p .* log2(p));
end