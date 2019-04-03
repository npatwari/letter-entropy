% Purpose: Estimate the entropy of a four letter sequence from a sequence of English text.
%
% Comments: See comments for countLetterEntropy.m
%
% Author: Neal Patwari
%


% Consider characters ' abcdefghijklmnopqrstuvwxyz'
considerChars = ' abcdefghijklmnopqrstuvwxyz';
count = zeros(length(considerChars),length(considerChars),length(considerChars),length(considerChars));

fname = 'romeo.txt';
fid   = fopen(fname);
tline = fgets(fid);
lastLet = '';
while (tline ~= -1),
    tline = [lastLet tline];
    substr = lower(tline(find(isletter(tline) | tline == 32)));
    ordLet = charToOrder(substr);
    for i=1:length(ordLet)-3,
        count(ordLet(i), ordLet(i+1), ordLet(i+2), ordLet(i+3)) = count(ordLet(i), ordLet(i+1), ordLet(i+2), ordLet(i+3)) + 1;
    end
    if ~isempty(ordLet),
        lastLet = ordLet(max(1,length(ordLet)-2):end);
    else
        lastLet = '';
    end
    tline = fgets(fid);
end
fclose(fid)

p = (count./sum(sum(sum(sum(count)))));
H = entropy(p(:))

% % Plot output pmf
% imagesc(0:26, 0:26, p)
% set(gca,'xlim',[-2 28])
% set(gca,'FontSize',24)
% set(gca,'xTick',[0, 6:5:26])
% set(gca,'xTickLabel',{'sp', 'f', 'k', 'p', 'u', 'z'})
% xlabel('Space or Letter')
% ylabel('P{occurrence}')
% 
