Dex = [0.044;0.01;0]; %Diametro Externo (m)
Din = [0.015;0.01;0.020]; %Diametro Interno (m)
L = [0.110;0.01;0]; %Comprimento do Grao (m)
Dt = 0.00708; %Diametro da garganta (m)
Ae = 3.94e-5; %�rea de sa�da da garganta (m2)
pi = 3.1415926; %Valor de pi
y = 1.1332; %gama - coef espec�fico 
R = 8314; %Constante Universal dos Gases (J/kmol*K)
MM = 0.037192; %Massa Molar do propelente (kg/mol)
wt = 41.96; %Massa Molar Total dos Gases de Sa�da - 100 g / n�mero de mols de g�s (kg/kmol)
g = 9.79718; %Gravidade(m/s^2)
a = 8.260; %MPa
n = 0.00319; %m/s
d = [1792.7;100;0]; %Densidade do Grao (kg/m3)
Me = [0;0.1;1]; %Coeficiente de Mach
T = 1720; %Temperatura ideal para o KNSU (K)
Pe = [0 0.01 0.10135]; %Pressao de sa�da (MPa)
Pa = 0.06882; %Pressao atmosferica para 500m(MPa)
Tc = [0 100 1750]; %Temperatura de Combust�o (K)
mp = [0.2650;0.01;0]; %Massa do propelente (Kg)
m = 0.2650; %Massa expelida do propelente (Kg)
t = [0.01;0.1;10]; %Tempo (s)


Ab =  ((1/2).* pi).*((Dex).^2 - (Din).^2) + ((pi.*L).*(Dex + Din)) %�rea de queima do propelente (m2)

At = (1/4).* pi.*((Dt).^2) %�rea da garganta do bocal (m2)

Kn = Ab./ At %Kn_inicial = Kn_m�ximo

Kn_g = Ae./At

Pc = (Kn.*((a.*d)./(sqrt((y /(R.*T)).*(2 /(y + 1)).^((y + 1)/(y - 1)))))).^(1 / (1 - n)) %Press�o no motor de combust�o (MPa)

c = sqrt(((R.*T)/(wt.*y) * (((y + 1)/2)^((y + 1)/(y - 1))))) %Velocidade de Exaust�o Caracter�stica (m/s)

r = a.*(Pc).^(n) %Taxa de Queima (m/s)

mdot = r.* Ab.* d %Taxa m�ssica (kg/s)

mdot_time = diff(mp)./diff(t)

ve = Me.*sqrt(y.*R.*T) %Velocidade de Sa�da (m/s)

% Para Empuxo Total: F = mdot * Veq

Veq = (ve + ((Pe - Pa)./mdot).*Ae)

F = (mdot.*Veq) %For�a Empuxo (N)

I = (m.*Veq) %Impulso Total (s)

Isp = (Veq./g) %Impulso Espec�fico (s)

cf = (F./(Pc.*At)) %Coeficiente de Empuxo


t = linspace(0,1,10);
Y = F;
Z = (Y>=0).*Y;
xlabel('t')
ylabel('Z = F')
title('empuxo vs tempo')
plot(t,Z)

title('Empuxo x tempo')

%figure(2);plot(I;t);grid;title('Impulso x tempo')
%figure(3);plot(mdot,t);grid;title('Taxa massica x tempo')
%figure(4);plot(cf,t);grid;title('Coeficiente de empuxo x tempo')

%syms t
%f(t) = (mdot.*Veq) %For�a Empuxo (N)
%i(t) = int(f(t),t,0.1,10) %Impulso Total (s)

