Dex = 44; % mm (Diametro Externo)
din = 15; % mm (Diametro Interno)
L = 110; % mm (Comprimento do Grao)
d = 1.7927e-6; % Kg/mm3 (Densidade do Grao)
A = 0.01271e+6; % mm2 (Area de queima do Grao Propelente)
Ae = 502.55;% mm2 (Area de Saida da Tubeira) 
Ag = 39.37; % mm2 (Area da garganta)
y = 1.1332; % y = gama (Cp/Cv)
% Tc = 1722; K (Temperatura de Combustao)
R = 8.314e+9; % Pa*mm3/mol*K (Constante Universal dos gases)
MM = 0.037192; % Kg/mol (Massa Molar)
% Pc = 6.895e+6
g = 9797.18; % mm/s^2
a = 8.260; % MPa
n = 0.319; % mm/s
Me = 1;
m = 0.2650; % Kg (massa do propelente)
Pe = 1.0135e+5; % Pa (Pressao de exaustao)
Pc = [0,2000,6.895e+6];
Tc = [0,100,1750];
%n = [0:0.01:0,319];


c = sqrt(((Tc * R)/(MM))/(y * ((2)/(y + 1))^((y + 1)/(y - 1)))); % mm/s (Velocidade de Exaustao)

r = a*(Pc).^(n);

% r = [0;0.1;1000];

mdot = A*d.*r; % Kg/s (Taxa Massica)

% mdot = [0;0.1;1000];

fm = ((Ag.*Pc)./ sqrt(Tc)).* sqrt(y / R).* ((y + 1)/2).^(- y + 1)/ (2 * (y - 1)); % Fluxo da Taxa Mássica 

% m1 = [0;0.1;1000]; 

Ve = sqrt (((2 * y * R * Tc)./( MM * (y - 1))).* (1 - ((Pe * Pc.^(-1)).^ ((y - 1)/(y))))); % Velocidade de Saida da Tubeira

Veq = Ve + (((Pc - Pe) * Ae)/(fm)); % Velocidade Equivalente

Isp = Veq / g; % Impulso Especifico 

% Isp = [0;0.1;1000];

Te = Tc./ ( 1 + ((y - 1)/2) * (Me) ^ 2);


figure(1);plot(mdot,Pc);grid;title('Vazão Mássica x Pressão de Combustão');xlabel('pressão');ylabel('taxa mássica')
figure(2);plot(fm,Pc);grid;title('Pressão de Combustão x Fluxo da Taxa mássica')