%Background1
BG1 = imread("BackgroundImg01.jpg");

Br1 = BG1(:,:,1); %access red
Bg1 = BG1(:,:,2); %access green
Bb1 = BG1(:,:,3); %access blue

Br1 = double(Br1);
Bg1 = double(Bg1);
Bb1 = double(Bb1);

%Background2
BG2 = imread("BackgroundImg02.jpg");

Br2 = BG2(:,:,1); %access red
Bg2 = BG2(:,:,2); %access green
Bb2 = BG2(:,:,3); %access blue

Br2 = double(Br2);
Bg2 = double(Bg2);
Bb2 = double(Bb2);

%Composite1
Cp1 = imread("CompositeImg01.jpg");

Cr1 = Cp1(:,:,1); %access red
Cg1 = Cp1(:,:,2); %access green
Cb1 = Cp1(:,:,3); %access blue

Cr1 = double(Cr1);
Cg1 = double(Cg1);
Cb1 = double(Cb1);

%Composite2
Cp2 = imread("CompositeImg02.jpg");

Cr2 = Cp2(:,:,1); %access red
Cg2 = Cp2(:,:,2); %access green
Cb2 = Cp2(:,:,3); %access blue

Cr2 = double(Cr2);
Cg2 = double(Cg2);
Cb2 = double(Cb2);

%Find alpha
up = (Cr1 - Cr2).*(Br1 - Br2) + (Cg1 - Cg2).*(Bg1 - Bg2) + (Cb1 - Cb2).*(Bb1 - Bb2);
down = (Br1 - Br2).^2  + (Bg1 - Bg2).^2 + (Bb1 - Bb2).^2;
alpha = 1 - (up./down);

%Equation
fr = (Cr1 - (1 - alpha).* Br1)./alpha;
fg = (Cg1 - (1 - alpha).* Bg1)./alpha;
fb = (Cb1 - (1 - alpha).* Bb1)./alpha;

newbg = imread('NewBackground01.jpg');

NBr = newbg(:,:,1);
NBg = newbg(:,:,2);
NBb = newbg(:,:,3);

NBr = double(NBr);
NBg = double(NBg);
NBb = double(NBb);

%composite
Ncr = alpha.*fr + (1 - alpha).*NBr;
Ncg = alpha.*fg + (1 - alpha).*NBg;
Ncb = alpha.*fb + (1 - alpha).*NBb;

Ncr = uint8(Ncr);
Ncg = uint8(Ncg);
Ncb = uint8(Ncb);
%add foreground with new background
NewComposite = cat(3,Ncr,Ncg,Ncb);
imwrite(NewComposite,'NewCompoOutput.png');

%get size
[row, col, ncolor]=size(Cp1);

%create white chanel
Wr = zeros(row, col);
Wg = zeros(row, col);
Wb = zeros(row, col);

%set pixel
Wr(:,:) = 255;
Wg(:,:) = 255;
Wb(:,:) = 255;

cWr = alpha.*fr + (1 - alpha).*Wr;
cWg = alpha.*fg + (1 - alpha).*Wg;
cWb = alpha.*fb + (1 - alpha).*Wb;

cWr = uint8(cWr);
cWg = uint8(cWg);
cWb = uint8(cWb);
%show matte picture
Matte = cat(3,cWr,cWg,cWb);
imwrite(Matte,'MatteOutput.png');

%figure
subplot(3,3,1), imshow(BG1)
subplot(3,3,2), imshow(BG2)
subplot(3,3,3), imshow(Cp1)
subplot(3,3,4), imshow(Cp2)
subplot(3,3,5), imshow(NewComposite)
subplot(3,3,6), imshow(Matte)
subplot(3,3,7), imshow(newbg)
