function [ features ] = reductionOverTimeSteps_WithStd( S )
%reductionOverFrequency Given a spectrogram, reduce frequencies down to 1
%   Compute the expected frequency for each timestep
%   Return a column vector of expected frequencies

S = abs(S);

averageOverTime = zeros(size(S, 1), 1);
stdOverTime = zeros(size(S, 1), 1);

for i = 1:size(S, 1)
    averageOverTime(i) = mean(S(i, 1:size(S, 2)));
    stdOverTime(i) = std(S(i, 1:size(S, 2)));
%     for j = 1:size(S, 2)
%         %count = count + S(j, i) * j;
%         averageOverTime(i) = averageOverTime(i) + S(i,j);
%     end
%     averageOverTime(i) = averageOverTime(i) / size(S,2);
end

features = [averageOverTime; stdOverTime];

end

