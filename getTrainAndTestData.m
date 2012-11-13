function [trainX, trainY, testX, testY] = getTrainAndTestData(people, root, reductionHandle, taskType, testFraction)

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

for personIndex = 1:length(people)
    
    % the people are a cell array, people(personIndex) is too
    % make it a string again with char()
    files = findFiles(char(people(personIndex)), root);
    perm = randperm(length(files)); % you must randomize!
    
    for fileIndex = perm
        fileName = char(files(fileIndex));
        [x,phoneme,endpoints] = wavReadTimit(fileName);
        display(length(x));
        x = x(1:28000); % BIG PROBLEM HERE. WHAT IF A CLIP IS SHORTER THAN 1.75 seconds?
        S = spectrogram(x', 320, 160, 512, 16000);
        features = reductionHandle(S); % expect a column vector
        
        if fileIndex > (1 - testFraction) * length(files)
            % then you are test data
            testX = [testX; features']; % add the features as a row
            
            if (strcmp(taskType, 'verification') == 1) % 1 for equality
                if personIndex == 1
                    testY = [testY; 1];
                else
                    testY = [testY; 0];
                end
            else
                testY = [testY; personIndex];
            end
            
        else
            % then you are train data
            trainX = [trainX; features']; % add the features as a row
            
            if (strcmp(taskType, 'verification') == 1) % 1 for equality
                if personIndex == 1
                    trainY = [trainY; 1];
                else
                    trainY = [trainY; 0];
                end
            else
                trainY = [trainY; personIndex];
            end
                        
        end
    end
end