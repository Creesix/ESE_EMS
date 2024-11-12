% Resolution equation de Laplace
%
clear
close all
clc

%% Dimensions / maillage
dx=1; % cm
dy=1; % cm
Nx = 40;
Ny = 40;

%% Potentiels / sources
v0 = 0; % condition aux limites (en V)
v1 = 100; % conducteur 1
v2 = -100; % conducteur 2

% Initialisation la matrice de calcul
V = zeros(Nx,Ny); % mettre toute la matrice a zero
Vold=zeros(Nx,Ny);
N=1;
diff=v1;
seuil=0.001;

%Condition aux limites 
V(1,1:Ny)=v0;
V(Nx,1:Ny)=v0;
V(1:Nx,1)=v0;
V(1:Nx,Ny)=v0;
%sources
V(26:29,8:34)=v1;
V(5:22,20:21)=v2;


%% Equation de calcul

while diff > seuil
    N=N+1;
    i=2:Nx-1;
    j=2:Ny-1;
    Vold=V;
    V(i,j)=0.25*( V(i+1,j) + V(i-1,j) + V(i,j+1) + V(i,j-1) );
       
    %Condition aux limites 
    V(1,1:Ny)=v0;
    V(Nx,1:Ny)=v0;
    V(1:Nx,1)=v0;
    V(1:Nx,Ny)=v0;
    %sources
    V(26:29,8:34)=v1;
    V(5:22,20:21)=v2;
    diff=max(max(Vold-V));
    %diff= norm(abs(Vold-V)); %énormément de changement au niveau du nombre d'itération en utilisant la norme au lieu du max
end

[Ex,Ey]=gradient(V);
Ex=-Ex;
Ey=-Ey;
x=1:Nx;
y=1:Ny;



%% Figure
figure(1)
hold on
colormap(jet);
quiver(x,y,Ex,Ey)
contour(V);
title("le nombre d'itération est :", N)
hold off