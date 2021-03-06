function y = TukeyMorph(a,b,lambda)
% y = TukeyMorph(a,b,lambda)
% This function implements John Tukey's suggestion for how to morph between
% two spectrogram frames.  First compute the cumulative sum, then match
% up points that are equal in (cumulative) energy.  This only works with
% inharmonic sounds (or spectral profiles without the pitch).   Also needs
% to use the interpolation scheme described on page 117 of my first IRC
% log book (TimeWarp).

if (nargin < 3) lambda = 0.5; end

if (size(a,1) > size(a,2)) a=a'; end
if (size(b,1) > size(b,2)) b=b'; end

len = length(a);

ca=cumsum(a);
ca=ca/ca(len);
cb=cumsum(b);
cb=cb/cb(len);
%plot([ca cb])

							% Find frame(a) to frame(b) match
warp1 = zeros(size(a));
for i=1:len
        diff = ca(i) - cb;
        [m ind] = min(diff.*diff);
        warp1(i) = ind;
end
%plot([ca' cb' cb(warp1)'])

							% Find frame(b) to frame(a) match
warp2 = zeros(size(a));
for i=1:len
        diff = cb(i) - ca;
        [m ind] = min(diff.*diff);
        warp2(i) = ind;
end
%plot([ca' cb' ca(warp2)'])

y = TimeWarp2(a,b,warp1,warp2,lambda)';
