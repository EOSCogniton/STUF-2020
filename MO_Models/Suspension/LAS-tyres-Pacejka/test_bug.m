%% 1

clear all

round = 6;

% For Cornering
Fz_C = [50 100 150 250 350];  
if round == 5
    Fz_C_8 = [50 100 150 250 350];
    Camber_C = [0 1 2 3 4];
elseif round == 6
    Fz_C_8 = [50 100 150 250 300];
    Camber_C = [0 2 4];
end

% For braking at the pressure of 8psi
if round == 5
    Fz_B_8 = [50 150 200 250];
elseif round == 6
    Fz_B_8 = [50 150 250 300];
end
Fz_B = [50 150 250 350];  % In braking for every other pressure
Camber_B = [0 2 4];
slipe_angles = [0 3 6];

Pressure = ["8" "10" "12i" "12f" "14"];

% Pressure = ["12i" "8"];
% Fz_C = [150];
% Camber_C = [0 4];

file = strcat('Round',int2str(round),'_Corner_all_run.mat');
load(file);

%% 2

for FZ=1:length(Fz_C)
    for P=2:length(Pressure)
        for IA=1:length(Camber_C)
            fichier = strcat('C', int2str(round), '_HB137_', Pressure(P), '_25_', int2str(Fz_C(FZ)), '_', int2str(Camber_C(IA)));

            %chargement du fichier
            fichier=eval(fichier);       %permet d'accéder à la variable ayant comme nom 'fichier' , si on fait pas ça ça ne marche pas
            MZ_discret=fichier.FY;      %On accède à MZ
            SA=fichier.SA;
            
            m=1;
            while m<=length(SA)
                if abs(SA(m))>12
                    MZ_discret(m)=[];
                    SA(m)=[];
                    m=m-1;
                end
                m=m+1;
            end

            MZ_pacejka = @(a, SA) a(1)*sin(a(2)*atan(a(3)*(SA-a(5))-a(4)*(a(3)*(SA-a(5))-atan(a(3).*(SA-a(5)))))) + a(6);
            %a = [D, C, B, E, Sh, Sv]

            %condition initiale

            %voir le document PCVpneu
            Sv = mean(MZ_discret);
            a0 = [0, 0, 0, 0, 0, 0];
            MZmax = max(MZ_discret);
            SAzero = [];
            SAmax = [];
            for i=1:length(MZ_discret)
                if abs(MZ_discret(i)- Sv)<MZmax*0.05 && abs(SA(i))<4
                    SAzero = [SAzero SA(i)];
                end
                if MZ_discret(i)> 0.90*MZmax
                    SAmax = [SAmax SA(i)];
                end
            end
            Sh = mean(SAzero);
            xm = mean(SAmax);
            
            %Regression linéaire pour avoir la dérivée à l'origine
            borne_inf = Sh-1;
            borne_sup = Sh+1;
            x = [];
            y = [];
            for i=1:length(MZ_discret)
                if SA(i)>borne_inf && SA(i)<borne_sup
                    x = [x SA(i)];
                    y = [y MZ_discret(i)];
                end
            end
            [a, b] = reg_lin(x,y);
%             figure
%             hold on
%             plot(SA,MZ_discret,'o')
%             plot((Sh-3:0.01:Sh+3),a*(Sh-3:0.01:Sh+3)+b)

            a0(1) = MZmax;
            a0(2) = 1.3;
            a0(3) = a / (a0(2)*a0(1));   %valeur mise au pif mais elle marche ! 
            % a0(4) = (a0(3)*5.5*pi/180-tan(pi/(2*a0(2))))/(a0(3)*5.5*pi/180-atan(a0(3)*5.5*pi/180));
            a0(4) = (a0(3)*xm-tan(pi/(2*a0(2))))/(a0(3)*xm-atan(a0(3)*xm*pi/180));
            a0(5) = Sh; %Il faut initialiser à la valeur de SA tq MZ(SA)=0
            a0(6) = Sv;
            
            figure
            hold on
            plot(SA,MZ_discret,'o')
            plot(SA,fonction_pacejka(a0,SA))

         end
    end
end

% for 8 psi

% for FZ=1:length(Fz_C_8)
%         for IA=1:length(Camber_C) 
%             fichier = strcat('C', int2str(round), '_HB137_', '8', '_25_', int2str(Fz_C_8(FZ)), '_', int2str(Camber_C(IA)));
%                 
% 
%         end
% end