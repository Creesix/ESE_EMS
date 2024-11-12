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

%Condition aux limites 
V(1,1:Ny)=v0;
V(Nx,1:Ny)=v0;
V(1:Nx,1)=v0;
V(1:Nx,Ny)=v0;
%sources
V(26:29,8:34)=v1;
V(5:22,20:21)=v2;


%% Equation de calcul
%i=1;j=1;
for k=1:20
    for i=2:Nx-1
        for j=2:Ny-1
        V(i,j)=0.25*( V(i+1,j) + V(i-1,j) + V(i,j+1) + V(i,j-1) );
        end
    end
    %Condition aux limites 
    V(1,1:Ny)=v0;
    V(Nx,1:Ny)=v0;
    V(1:Nx,1)=v0;
    V(1:Nx,Ny)=v0;
    %sources
    V(26:29,8:34)=v1;
    V(5:22,20:21)=v2;
end




%% Figure
figure(1)
colormap(jet);
pcolor(V);
title("20 itérations");