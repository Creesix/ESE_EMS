%% Calcul de FDTD - Ondes planes
% 1D ==> Equations de Maxwell
clear
close all
clc

%% Definition des constantes 
eps0 = 8.8542*power(10,-12);
mu0 = 4*pi*power(10,-7);

%% Maillage : Discrétisation spatiale
L = 2; % Longeur du domaine de calcul
max_space = 201; % Nbr de points spatiaux (Nbr de champs E)
alpha = 1.01;
dz = L/(max_space-1);
dt = alpha*sqrt(eps0*mu0)*dz;

%% Discrétisation temporelle
max_time = 100;

% Source 
center = 101;
t0 = 40*dt;
spread = 1.6*power(10,-10);

%% Initialisation des champs E et H 
E = zeros(max_space);
H = zeros(max_space-1);

%% Conditions aux limites
% Conditions sur E => pas besoin car E = zeros(.)

E(1) = 0;
E(max_space) = 0;

%% Constantes 
gamma = - 1/eps0*dt/dz;
tau = -1/mu0*dt/dz;    
    
for n=1:max_time
    t = (n-1)*dt;
    
     % Equation : calcul du champ electrique 
    for k=2:max_space-1
        E(k) = E(k) + gamma*(H(k)-H(k-1));
    end
    
    % Source
    %E(center) = exp(-((t-t0)/spread)^2);
    %E(center) = exp( -((t-t0)/spread)*((t-t0)/spread));

    % Hard source
    pulse = exp((-1)*((t-t0)/spread)^2);
    E(center) = pulse;

    % Calcul du champ magnetique
    for k=1:max_space-1
        H(k) = H(k) + tau*(E(k+1) - E(k));
    end
end

figure(1)
plot(E)
title("on plot le champ E")
ylabel("champ")

figure(2)
plot(H)
title("on plot le champ H")
ylabel("champ")