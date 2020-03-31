% Purpose: Estimate the entropy of a letter from a sequence of English text.
%
% Author: Neal Patwari
%

% Consider characters ' abcdefghijklmnopqrstuvwxyz'
considerChars = ' abcdefghijklmnopqrstuvwxyz';

% Initialize histogram
count = zeros(1,length(considerChars));

fname = 'romeo.txt';  % pick anything here.
fid   = fopen(fname);
% Read in one line at a time into a string, tline.
tline = fgets(fid);
while (tline ~= -1)

    % Pick out letters and spaces from tline, 
    % convert them to lower case, and then
    % convert lower case letters and space to a number from 1 to 27.
    substr = lower(tline(find(isletter(tline) | tline == 32)));
    ordLet = charToOrder(substr);

    % Increment the count for each character read on this line
    % Not efficient but does the trick.
    for i=1:length(ordLet)
        count(ordLet(i)) = count(ordLet(i)) + 1;
    end
    tline = fgets(fid);
end
fclose(fid);

% Normalize the pmf so it sums to 1.0
p = (count./sum(count));

% Compute the entropy
H = entropy(p)

% Plot output pmf
bar(0:26, p)
set(gca,'xlim',[-2 28])
set(gca,'FontSize',24)
set(gca,'xTick',[0, 6:5:26])
set(gca,'xTickLabel',{'sp', 'f', 'k', 'p', 'u', 'z'})
xlabel('Space or Letter')
ylabel('Probability Mass')

