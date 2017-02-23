function [output] = rms(val1, val2)

if nargin < 2
  val2 = 0;
end

output =  sqrt(mean((val1-val2).^2)); 