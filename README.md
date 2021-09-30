[![View createcolormap on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://jp.mathworks.com/matlabcentral/fileexchange/100084-createcolormap)
## createcolormap.m
This function allows to create colormap Nx3 array (RGB) with an arbitrary combination of colors. 
RGB values between the specified colors will be smoothly connected by linear interpolation.

## Usage
+ blue-white-red (polar)
  ```matlab
  b = [0,0,1];
  w = [1,1,1];
  r = [1,0,0];

  bwr = createcolormap(b,w,r); % 256x3 array
  
  colormap(cmap)
  colorbar
  ```

  If you want to use dark blue and red colors, try below:
  ```matlab
  b = [0.0,0.0,0.5];
  w = [1.0,1.0,1.0];
  r = [0.5,0.0,0.0];

  bwr = createcolormap(b,w,r); % 256x3 array

  colormap(cmap)
  colorbar
  ```

  To create a more discrete color structure, input the number of elements in the first argument as shown below.
  ```matlab
  bwr = createcolormap(16,b,w,r); % 16x3 array 
  ```

+ more complicated combination
  ```matlab
  colorA = [0.0,1.0,0.0];
  colorB = [1.0,0.5,0.5];
  colorC = [0.5,0.5,0.5];
  colorD = [1.0,1.0,0.0];

  cmap = createcolormap(64,colorA,colorB,colorC,colorD); % 64x3 array

  surf(peaks); 
  colormap(cmap);
  caxis([-4,4]);
  colorbar;
  ```

## License
MIT

## Author
[Takuya Miyashita](https://hydrocoast.jp)   
Disaster Prevention Research Institute, Kyoto University  

## Update
  v0.1  2021/10/01

