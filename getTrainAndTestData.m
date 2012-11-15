function [trainX, trainY, testX, testY] = getTrainAndTestData(people, root, reductionHandle, taskType, testFraction)
% people = cell array of strings, the speakers involved
% root = directory where the folders of individuals' data are
% reductionHandle = reduction function
% taskType = 'verification' or 'recognition'
% testFraction = [0.1]; fraction of data to reserve for testing

CLIP_FRAMES = 24000;
FRAMES_PER_SECOND = 16000;
NFFT = 512;
WINDOW_SIZE = 320;
WINDOW_OVERLAP = 160;

if nargin < 5
    testFraction = .30;
end
if nargin < 4
    taskType = 'verification';
end
if nargin < 3
    reductionHandle = 'none';
end
if nargin < 2
    root = 'dr7';
end

trainX = [];
trainY = [];
testX = [];
testY = [];

bigX = [];
bigY = [];

for personIndex = 1:length(people)
    
    % the people are a cell array, people(personIndex) is too
    % make it a string again with char()
    files = findFiles(char(people(personIndex)), root);
    display(files)
    for fileIndex = 1:length(files)
        filepath = strcat(root,'/',people(personIndex),'/');
        fileName = char(files(fileIndex));
        fileName = strcat(filepath,fileName);
        [x,phoneme,endpoints] = wavReadTimit(fileName);
        
        for ind=1:CLIP_FRAMES:length(x)
            if ind+CLIP_FRAMES > length(x)
                continue % MAYBE IN THE FUTURE DON'T IGNORE
            end
            
            tempX = x(ind:ind+CLIP_FRAMES); 
            S = spectrogram(tempX', WINDOW_SIZE, WINDOW_OVERLAP, NFFT, FRAMES_PER_SECOND);
            features = reductionHandle(S); % expect a column vector

            bigX = [bigX; features']; % add the features as a row

            if (strcmp(taskType, 'verification') == 1) % 1 for equality
                if personIndex == 1
                    vec = [1, 0];
                    bigY = [bigY; vec];
                else
                    vec = [0, 1];
                    bigY = [bigY; vec];
                end
            else
                vec = zeros(1, length(people));
                vec(personIndex) = 1;
                bigY = [bigY; vec];
            end
        end
    end
end

bigX;
bigY;

perm = randperm(size(bigY, 1)); % you must randomize!
count = 0;
for i=perm
    count = count + 1;
    if count <= (1 - testFraction) * size(bigY, 1)
        trainX = [trainX; bigX(i, :)];
        trainY = [trainY; bigY(i, :)];
    else
        testX = [testX; bigX(i, :)];
        testY = [testY; bigY(i, :)];
    end
end