clear all; close all; clc;


R=366;
r=61;
%h_max=sqrt( abs(R^2 - (R-r)^2) );
H_max=(acos((R-61)/R) * 180/pi)/360 * 2*pi*R;
n=4; %ilosc p³atów

% cur = @(H)R * cos(H.*360./(2*pi*R)* pi/180) - R + r;
Ha = @(c)acos((c-r+R)/R)./(360./(2*pi*R)* pi/180); %- argumentem jest PROMIEÑ KOPU£KI, wartoœci¹ podzia³ka krzywizny H
Ha = @(x)acos((R-r+x)./R)*180/pi  *2*pi*R./360;

cir = @(x)2*pi*x ./ n;%d³ugoœæ dolnej krawêdzi n-tego brytu

[x_max, val]=fzero(Ha,r); %przeciêcie dolnej krawêdzi brytu z podstaw¹

x = linspace(0,x_max,1000);%promienie kopu³ki - z tego bêd¹ obwody podstaw brytow


bryt = [flip(Ha(x)),Ha(x)]; %kszta³ty brytów na podstawie promieni - na wykresie maj¹ byæ obwody zamiast promieni!
net = repmat(bryt,1,n);

% cir_bryt=@(x)2*pi*x./n; %d³ugoœæ podstawy obwodowej brytu
cir_line= linspace(0, 2*pi*x_max, length(net));

figure(1);
plot(cir_line,net,2*pi*x_max./n,val,'x');
xlabel('L - podstawa rozwiniêtego p³ata [mm]'); ylabel({'H - podzia³ka wysokoœci rozwiniêtego p³ata /', 'krzywizna krawêdzi [mm]'})
xlim([min(cir_line),max(cir_line)]); ylim([min(Ha(x)), max(Ha(x))]);
grid on;
% set(gca,'xtick',[0:20:max(cir_line)])
% set(gca,'ytick',[0:20:max(Ha(x))])
daspect([1,1,1])
pbaspect([1 1 1])


%drukowanie pojedynczej ³aty
figure('PaperType','a3','PaperUnits','centimeters','PaperOrientation','portrait');
b_line=linspace(0,2*x_max,length(bryt));
plot(bryt,b_line);
ylabel('L - podstawa rozwiniêtego p³ata [mm]'); xlabel({'H - podzia³ka wysokoœci rozwiniêtego p³ata /', 'krzywizna krawêdzi [mm]'})
ylim([min(b_line),max(b_line)]); xlim([min(Ha(x)), max(Ha(x))]);
grid on;
% set(gca,'xtick',[0:20:max(cir_line)])
% set(gca,'ytick',[0:20:max(Ha(x))])
% daspect([1,1,1])
% pbaspect([1 1 1])


set(gca,'units','centimeters')
set(gca,'xlimmode','manual','ylimmode','manual')
% Get the axes position in cm, [locationX locationY sizeX sizeY]
% so that we can reuse the locations
axpos = get(gca,'position');
% Use the existing axes location, and map the axes size (in cm) to the
%  axes limits so there is a true size correspondence
set(gca,'position',[axpos(1:2) abs(diff(xlim))/10 abs(diff(ylim))/10])
% Print the figure to paper in real size.
print
% Print to a file in real size and look at the result
print(gcf,'-dpng','-r0','sine.png')
