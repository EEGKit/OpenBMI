function [ cf_out ] = func_predict( in, varargin )
%PROC_APPLY_CLASSIFIER Summary of this function goes here
%   Detailed explanation goes here

if isstruct(varargin{:})
    opt=varargin{:};    
else
    opt=varargin{:}{:}; % cross-validation procedure
end

if isstruct(in)
dat=in.x;
else
    dat=in;
end
switch lower(opt.classifier)
    case 'lda'
        [ntri ndim]=size(dat);
        if ntri~=1
           dat=dat';
        end
        cf_out= real( dat*opt.cf_param.w+opt.cf_param.b);% + repmat(opt.cf_param.b, [1 size(fv.x,1)]) );
end

end

