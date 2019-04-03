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

    % Pick out letters and spaces from tline, converting to a number from 1 to 27.
    substr = lower(tline(find(isletter(tline) | tline == 32)));
    ordLet = charToOrder(substr);

    % Not efficient but does the trick.
    for i=1:length(ordLet)
        count(ordLet(i)) = count(ordLet(i)) + 1;
    end
    tline = fgets(fid);
end
fclose(fid);

% Normalize the pdf.
p = (count./sum(count));

%s = 1;
%zipf = 1./((1:length(p)).^s);
%zipf = zipf / sum(zipf);
%sortp = -sort(-p);
%figure(2)
%stem(sortp)
%hold on
%plot(1:length(p), zipf, 'k--')
%hold off;
%grid
%set(gca,'FontSize',18)
%xlabel('Letter, Order of Occurrance')
%ylabel('Probability of Letter')
%set(gca,'ylim',[0 0.3])
%legend('Experimental','Zipf, s=1')
%print -depsc plotLetterOrderPMF_vs_Zipf.eps

% Compute the entropy
H = entropy(p)

% Plot output pmf
bar(0:26, p)
set(gca,'xlim',[-2 28])
set(gca,'FontSize',24)
set(gca,'xTick',[0, 6:5:26])
set(gca,'xTickLabel',{'sp', 'f', 'k', 'p', 'u', 'z'})
xlabel('Space or Letter')
ylabel('P{occurrence}')

