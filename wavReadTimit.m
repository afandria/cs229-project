function [x,phoneme,endpoints] = wavReadTimit(fileName)
% function [x,phoneme,endpoints] = wavReadTimit(fileName)
%
% This file reads a TIMIT 'wav' file (1024 header, 16-bit PCM data)
% Mark Skowronski, April 15, 2004
% Input: fileName -- character string of TIMIT wavfile (w/ or w/o .wav extension)
% Output: x -- raw PCM data
%         phoneme -- character array of phonemes uttered in x (optional, requires .phn file)
%         endpoints -- first and last sample number of each phoneme listed (optional, requires .phn file)

if nargin<1,
   errordlg('Must specify TIMIT file name!','ERROR: No file name');
end;

fileName=lower(fileName); % Convert all letters to lower case.
suffix=fileName(end-3:end);
if strcmp(suffix,'.wav'),
   fileName = fileName(1:end-4); % Remove .wav if appended
end;

% Open .wav file:
fid = fopen([fileName,'.wav'],'r'); % Open file for reading
if fid==-1,
   errordlg('Specify _valid_ TIMIT .wav file name!','ERROR: Invalid file name');
else
   fseek(fid,1024,-1); % Skip past header, which is 1024 bytes long.
   x=fread(fid,inf,'int16'); % 16-bit signed integers
   x = x(:)'; % Row vector
   fclose(fid);
end;

if nargout>1 % If user also wants phoneme info
   % Open .phn file:
   fid = fopen([fileName,'.phn'],'r'); % Open file for reading
   if fid==-1,
      errordlg('Specify _valid_ TIMIT .phn file name!','ERROR: Invalid file name');
   else
      % Read in 2 integers and 1 string per line until string is empty:
      phnCounter = 0;
      phoneme = ['    '];
      endpoints = [];
      TempEndpoint = fscanf(fid,'%i',[1,2])+1; % Read 2 integers and store as a row in TempEndpoint
      TempPhoneme = fscanf(fid,'%s',1); % Read 1 string (the phoneme)
      while ~isempty(TempPhoneme),
         phnCounter = phnCounter + 1;
         endpoints(phnCounter,1:2) = TempEndpoint;
         phoneme(phnCounter,1:4) = ['    '];
         phoneme(phnCounter,1:length(TempPhoneme)) = TempPhoneme;
         TempEndpoint = fscanf(fid,'%i',[1,2]);
         TempPhoneme = fscanf(fid,'%s',1);
      end;
      fclose(fid);
   end;
end;


% Bye!