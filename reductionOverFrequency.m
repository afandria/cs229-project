function [ expectedFrequencies ] = reductionOverFrequency( S )
%reductionOverFrequency Given a spectrogram, reduce frequencies down to 1
%   Compute the expected frequency for each timestep
%   Return a column vector of expected frequencies

S = abs(S);

expectedFrequencies = zeros(size(S, 2), 1);

for i = 1:size(S, 2)
    count = 0;
    for j = 1:size(S, 1)
        count = count + S(j, i) * j;
    end
    expectedFrequencies(i) = count / j;
end

end

