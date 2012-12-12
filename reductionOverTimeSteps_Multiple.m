function [ features ] = reductionOverTimeSteps_Multiple( S )
%reductionOverFrequency Given a spectrogram, reduce frequencies down to 1
%   Compute the expected frequency for each timestep
%   Return a column vector of expected frequencies

MULTIPLE = 3;
S = abs(S);

averageOverTime = zeros(size(S, 1), MULTIPLE);

for i = 1:size(S, 1)
    mylast = 0;
    for j=1:MULTIPLE
        start = mylast + 1;
        last = floor(j * size(S, 2) / MULTIPLE);
        averageOverTime(i, j) = mean(S(i, start:last));
        mylast = last;
    end
end

features = reshape(averageOverTime, [size(S, 1)*MULTIPLE 1]);

end

