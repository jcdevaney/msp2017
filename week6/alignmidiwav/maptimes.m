function u = maptimes(t,intime,outtime)
% u = maptimes(t,intime,outtime)
%   map the times in t according to the mapping that each point 
%   in intime corresponds to that value in outtime
% 2008-03-20 Dan Ellis dpwe@ee.columbia.edu

[tr, tc] = size(t);
t = t(:)';  % make into a row
nt = length(t);
nr = length(intime);

% Decidedly faster than outer-product-array way
u = t(:);
for i = 1:nt
  u(i) = outtime(min([find(intime > t(i)),length(outtime)]));
end
u = reshape(u,tr,tc);

