function files = findFiles(person, root)

if nargin < 2
    root = 'dr7';
end

filePath = strcat(root, '/', person, '/');
fileName = '*.wav';

files = dir([filePath fileName]);
files = {files.name}; % just get the namesfin