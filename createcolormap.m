function cmap = createcolormap(varargin)
%% create a user-specified colormap
% 
% This function allows to create colormap Nx3 array (RGB) with an arbitrary combination of colors. 
% RGB values between the specified colors will be smoothly connected by linear interpolation.
% 
% Usage examples:
% 1) blue-white-red (polar)
%   ```matlab
%   b = [0,0,1];
%   w = [1,1,1];
%   r = [1,0,0];
% 
%   bwr = createcolormap(b,w,r); % 256x3 array
%   
%   colormap(cmap)
%   colorbar
%   ```
% 
%   If you want to use dark blue and red colors, try below:
%   ```matlab
%   b = [0.0,0.0,0.5];
%   w = [1.0,1.0,1.0];
%   r = [0.5,0.0,0.0];
% 
%   bwr = createcolormap(b,w,r); % 256x3 array
% 
%   colormap(cmap)
%   colorbar
%   ```
% 
%   To create a more discrete color structure, input the number of elements in the first argument as shown below.
%   ```matlab
%   bwr = createcolormap(16,b,w,r); % 16x3 array 
%   ```
% 
% 
% 2) more complicated combination
% 
%   ```matlab
%   colorA = [0.0,1.0,0.0];
%   colorB = [1.0,0.5,0.5];
%   colorC = [0.0,0.0,0.0];
%   colorD = [1.0,1.0,0.0];
% 
%   cmap = createcolormap(64,colorA,colorB,colorC,colorD); % 64x3 array
% 
%   colormap(cmap)
%   colorbar
%   ```
% 
% License:
%   MIT
% 
% Author:
%   Takuya Miyashita
%   Disaster Prevention Research Institute, Kyoto University, Japan
%   miyashita@hydrocoast.jp
% 
% Update (yyyy/mm/dd):
%   v0.1  2021/10/01
% 
% 

%% narg check
if nargin < 2
    error('At least two input arguments are required.')
end
arg1 = varargin{1};
arg2 = varargin{2};

%% 2 colors && 2 args
%      cmap = createcolormap(colorA, colorB)
%  ->  cmap = createcolormap(256, colorA, colorB)
if nargin==2
    if numel(arg1)~=3 || numel(arg2)~=3
        error('At least two different colors must be specified.')
    end
    color1 = arg1;
    color2 = arg2;    
    n = 256;
    cmap = createcolormap(n,color1,color2);
    return
end

%% assign args
switch numel(arg1)
    case 1
        n = arg1;
        offset_color = 1;
        ncolor = nargin-1;
        color1 = arg2;
        color2 = varargin{3};
        if ncolor > 2
            color3 = varargin{4};
        end
    case 3
        n = 256;
        offset_color = 0;
        ncolor = nargin;
        color1 = arg1;
        color2 = arg2;
        color3 = varargin{3};
    otherwise
        error('The number of elements in the input argument is invalid. It must be 1 or 3.');
end

%% arg validity
if numel(color1)~=3 || numel(color2)~=3
    error('Each color must be a three-element RGB array.')
end
if any(color1>1) || any(color2>1)  || ...
   any(color1<0) || any(color2<0)
    error('All RGB values must be in a range between 0 and 1.')
end
if n < 2*ncolor
    error('The number of segments is too small for the number of colors.')
end

%% 2 colors; main routine of this function
if ncolor == 2
    rv = linspace(color1(1),color2(1),n);
    gv = linspace(color1(2),color2(2),n);
    bv = linspace(color1(3),color2(3),n);
    cmap = [rv(:),gv(:),bv(:)];
    return
end

%% 3 colors; the main routine is recursively applied
if ncolor == 3
    if mod(n,2)==1
        nmid = floor(n/2);
        cmap1 = createcolormap(nmid,color1,color2);
        cmap2 = createcolormap(nmid,color2,color3);
        cmap = vertcat(cmap1,[color2(1),color2(2),color2(3)],cmap2);
    else
        nmid = n/2;
        cmap1 = createcolormap(nmid,color1,color2);
        cmap2 = createcolormap(nmid,color2,color3);
        cmap = vertcat(cmap1,cmap2);
    end
    return
end

%% 4+ colors; the main routine is recursively applied
if ncolor > 3
    n_each = diff(round(linspace(0,n,ncolor+1)));
    cmap = cell(ncolor,1);
    for i = 1:ncolor-1
        cmap{i} = createcolormap(n_each(i),varargin{i+offset_color},varargin{i+1+offset_color});
    end
    cmap = vertcat(cmap{:});
end

end