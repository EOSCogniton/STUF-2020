%% verification

%% Initial parameters
clear all
close all

round = 5;

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

%% FY verification

%chargement du fichier initial
file = strcat('Round',int2str(round),'_Corner_all_run.mat');
load(file);   %permet d'importer la grande matrice dans le workplace
% Chargement des coef de pacejka
file_paj = load(strcat('FY_pacejka_coeff_R',int2str(round),'.mat'));
inter = 'FY_pacejka_coeff_Rx';

% For a pressure different than 8psi
for FZ=1:length(Fz_C)
    for P=2:length(Pressure)
        for IA=1:length(Camber_C)
            fichier = strcat('C', int2str(round), '_HB137_', Pressure(P), '_25_', int2str(Fz_C(FZ)), '_', int2str(Camber_C(IA)));
            
            fichier_disc = eval(fichier);
            FY_discret=fichier_disc.FY;
            SA_discret=fichier_disc.SA;
            
            coeff = file_paj.(inter).(fichier);
            SA_paj = (-(max(SA_discret)+1):0.05:(max(SA_discret)+1));
            
            figure
            hold on
            plot(SA_discret, FY_discret, 'o')
            plot(SA_paj, fonction_pacejka(coeff, SA_paj), 'r')
            legend('Raw TT data', 'Pacejka Fitting')
            xlabel('SA °')
            ylabel('FY (N)')
            title(strcat('Cornering round ',int2str(round),', load :',int2str(Fz_C(FZ)),', pressure :',Pressure(P) ,', Camber :',int2str(Camber_C(IA))))
        end
    end
end

%% For a pressure of 8psi

for FZ=1:length(Fz_C_8)
        for IA=1:length(Camber_C) 
            fichier = strcat('C', int2str(round), '_HB137_', '8', '_25_', int2str(Fz_C(FZ)), '_', int2str(Camber_C(IA)));
            
            fichier_disc = eval(fichier);
            FY_discret=fichier_disc.FY;
            SA_discret=fichier_disc.SA;
            
            coeff = file_paj.(inter).(fichier);
            SA_paj = (-(max(SA_discret)+1):0.05:(max(SA_discret)+1));
            
            figure
            hold on
            plot(SA_discret, FY_discret, 'o')
            plot(SA_paj, fonction_pacejka(coeff, SA_paj), 'r')
            legend('Raw TT data', 'Pacejka Fitting')
            xlabel('SA °')
            ylabel('FY (N)')
            title(strcat('Cornering round ',int2str(round),', load :',int2str(Fz_C(FZ)),', pressure 8, Camber :',int2str(Camber_C(IA))))
        end
end

%% MZ verification

%chargement du fichier initial
file = strcat('Round',int2str(round),'_Corner_all_run.mat');
load(file);   %permet d'importer la grande matrice dans le workplace
% Chargement des coef de pacejka
file_paj = load(strcat('MZ_pacejka_coeff_R',int2str(round),'.mat'));
inter = 'MZ_pacejka_coeff_Rx';

% For a pressure different than 8psi
for FZ=1:length(Fz_C)
    for P=2:length(Pressure)
        for IA=1:length(Camber_C)
            fichier = strcat('C', int2str(round), '_HB137_', Pressure(P), '_25_', int2str(Fz_C(FZ)), '_', int2str(Camber_C(IA)));
            
            fichier_disc = eval(fichier);
            MZ_discret=fichier_disc.MZ;
            SA_discret=fichier_disc.SA;
            
            coeff = file_paj.(inter).(fichier);
            SA_paj = (-(max(SA_discret)+1):0.05:(max(SA_discret)+1));
            
            figure
            hold on
            plot(SA_discret, MZ_discret, 'o')
            plot(SA_paj, fonction_pacejka(coeff, SA_paj), 'r')
            legend('Raw TT data', 'Pacejka Fitting')
            xlabel('SA °')
            ylabel('MZ (Nm)')
            title(strcat('Cornering round ',int2str(round),', load :',int2str(Fz_C(FZ)),', pressure :',Pressure(P) ,', Camber :',int2str(Camber_C(IA))))
        end
    end
end

% For a pressure of 8psi
for FZ=1:length(Fz_C_8)
        for IA=1:length(Camber_C) 
            fichier = strcat('C', int2str(round), '_HB137_', '8', '_25_', int2str(Fz_C(FZ)), '_', int2str(Camber_C(IA)));
            
            fichier_disc = eval(fichier);
            MZ_discret=fichier_disc.MZ;
            SA_discret=fichier_disc.SA;
            
            coeff = file_paj.(inter).(fichier);
            SA_paj = (-(max(SA_discret)+1):0.05:(max(SA_discret)+1));
            
            figure
            hold on
            plot(SA_discret, MZ_discret, 'o')
            plot(SA_paj, fonction_pacejka(coeff, SA_paj), 'r')
            legend('Raw TT data', 'Pacejka Fitting')
            xlabel('SA °')
            ylabel('MZ (Nm)')
            title(strcat('Cornering round : ',int2str(round),', load : ',int2str(Fz_C(FZ)),', pressure 8, Camber : ',int2str(Camber_C(IA))))
        end
end

%% FX verification

%chargement du fichier initial
file = strcat('Round',int2str(round),'_Brake_all_run.mat');
load(file);   %permet d'importer la grande matrice dans le workplace
% Chargement des coef de pacejka
file_paj = load(strcat('FX_pacejka_coeff_R',int2str(round),'.mat'));
inter = 'FX_pacejka_coeff_Rx';

% For a pressure different than 8psi
for FZ=1:length(Fz_C)
    for P=2:length(Pressure)
        for IA=1:length(Camber_B)
            for SA=1:length(slipe_angles)
                fichier = strcat('B', int2str(round), '_HB137_', Pressure(P), '_25_', int2str(Fz_B(FZ)), '_', int2str(Camber_B(IA)), '_', int2str(slipe_angles(SA)));
            
                fichier_disc = eval(fichier);
                FX_discret=fichier_disc.FX;
                SL_discret=fichier_disc.SL;
            
                coeff = file_paj.(inter).(fichier);
                SL_paj = (-(max(SL_discret)+0.01):0.0001:(max(SL_discret)+0.01));

                figure
                hold on
                plot(SL_discret, FX_discret, 'o')
                plot(SL_paj, fonction_pacejka(coeff, SL_paj), 'r')
                legend('Raw TT data', 'Pacejka Fitting')
                xlabel('SL °')
                ylabel('FX (N)')
                title(strcat('Cornering round ',int2str(round),', load :',int2str(Fz_C(FZ)),', pressure :',Pressure(P) ,', Camber :',int2str(Camber_C(IA))))
            end
        end
    end
end

% For a pressure of 8psi
for FZ=1:length(Fz_B_8)
        for IA=1:length(Camber_B) 
            for SA=1:length(slipe_angles)
                fichier = strcat('B', int2str(round), '_HB137_', '8', '_25_', int2str(Fz_B(FZ)), '_', int2str(Camber_B(IA)), '_', int2str(slipe_angles(SA)));
            
                fichier_disc = eval(fichier);
                FX_discret=fichier_disc.FX;
                SL_discret=fichier_disc.SL;
            
                coeff = file_paj.(inter).(fichier);
                SL_paj = (-(max(SL_discret)+0.01):0.0001:(max(SL_discret)+0.01));

                figure
                hold on
                plot(SL_discret, FX_discret, 'o')
                plot(SL_paj, fonction_pacejka(coeff, SL_paj), 'r')
                legend('Raw TT data', 'Pacejka Fitting')
                xlabel('SL °')
                ylabel('FX (N)')
                title(strcat('Cornering round ',int2str(round),', load :',int2str(Fz_C(FZ)),', pressure : 8, Camber :',int2str(Camber_C(IA))))
            end
        end
end