Dex = 44; %Diametro Externo (mm)
din = 15; %Diametro Interno (mm)
L = 110; %Comprimento do Grao (mm)
d = 1.7927e-6; %Densidade do Grao (Kg/mm3)
A = 0.01271e+6; %Area de queima do Grao Propelente (mm2)
y = 1.1332; %gama - coef específico 
R = 8.314e+9; %Constante Universal dos gases (Pa*mm3/mol*K)
MM = 0.037192; %Massa Molar do propelente (Kg/mol)
wt = 0.60809; %Massa Molar Total dos gases de saída (Kg/mol)
g = 9797.18; %Gravidade(mm/s^2)
a = 8.260; % MPa
n = 0.319; % mm/s
Me = 1; %Coeficiente de Mach
Pe = [1 0.1 0.10135 0.10135 0.1 1]; %Pressao de exaustao (Mpa)
Pc = [1 2 6.895 6.895 2 1]; %Pressão de Combustão (MPa)
Tc = [1 100 1750 1750 100 1]; %Temperatura de Combustão (K)
m = [0.2650, 0.01, 0]; %Massa do propelente (Kg)
t = [0.1 1 10 100 1000]; %Tempo (s)
%Pc = 6.895e+6 %Pressão de Combustão (MPa)
%Tc = 1722; %Temperatura de Combustao (K)
%Ae = 502.55; Area de Saida da Tubeira (mm2) 


%c = sqrt(((Tc * R)/(MM))/(y * ((2)/(y + 1))^((y + 1)/(y - 1))));%%Velocidade Característica de Exaustao (mm/s)

%r = a.*(Pc).^(n)%Taxa de queima (mm/s)
% r = [0;0.1;1000];

%mdot = A*d.*r; %Taxa Massica (Kg/s)
%mdot = [0;0.1;1000];

%fm = ((Ag.*Pc)./ sqrt(Tc)).* sqrt(y / R).* ((y + 1)/2).^-((y + 1)/ (2 *(y- 1))); 
%Fluxo da Taxa Mássica (Kg/s)
%fm = [0;0.1;1000]; 

%Ve = sqrt (((2 * y * R * Tc)./( MM * (y - 1))).* (1 - ((Pe * Pc.^(-1)).^((y - 1)/(y))))); 
%Velocidade de Saida da Tubeira (mm/s)

%Veq = Ve + (((Pc - Pe) * Ae)/(fm)); %Velocidade Equivalente (mm/s)

%Isp = Veq / g; %Impulso Especifico (s)
%Isp = [0;0.1;1000];

%figure(1);plot(mdot,Pc);grid;title('Vazão Mássica x Pressão de Combustão');xlabel('pressão');ylabel('taxa mássica')
%figure(2);plot(fm,Pc);grid;title('Pressão de Combustão x Fluxo da Taxa mássica')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Para Pe = P0 %%%%%%%%
r = a.*(Pc).^(n)

Te = Tc.*((1 + (Me^(2))*(y-1)/2).^(-1))

Pt = Pe.*((1 + ((Me^2)*((y-1)/2))).^-(y/(y-1))) %Pressão na Garganta do bocal(MPa)

Ag = (wt./Pc).*(sqrt((R.*Te)./(y.*g))) %Área da Garganta (mm2)

Ae = Ag.*(((y + 1)./2).^-((y + 1)/(2.*(y-1))).*(((1 + ((y -1)./2)).*Me^2).^((y + 1)/(2*(y -1)))./Me)) %Área de Saída do bocal

mdot = (Ag.*Pt./(sqrt(Tc.*1))).*sqrt(y/R).*(((y + 1)./2).^(-(((y + 1)/(2*(y -1)))))) %Taxa Mássica (Kg/s)

ve = Me.*sqrt(y.*R.*Te) %Velocidade de Saída (mm/s)

syms F(t)
F = (mdot.*ve) %Força Empuxo (Kg*mm/s^2)
I(t) = int(F,t,0.1,10) %Impulso Total (s)

cf = F./(Pc.*Ag) %Coeficiente de Empuxo


figure(1);ezplot(t,F);grid;title('Empuxo x tempo')
figure(2);fplot(I,[0.1 10]);grid;title('Impulso x tempo')
figure(3);ezplot(t,mdot);grid;title('Taxa massica x tempo')
figure(4);ezplot(t,cf);grid;title('Coeficiente de empuxo x tempo')
figure(5);plot(cf,Pe);grid;title('Pressão de Exaustão x Coeficiente de Empuxo')















