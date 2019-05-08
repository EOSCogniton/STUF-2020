%% Pacejka mat file creation

% Ce script permet de créer un fichier .mat pour MZ, FX et FY dans lequels on peut directement ccéder aux coefficients de Pacejka, sans passer 
% par les longues fonctions d'optimisation à chaque fois

%% Initial parameters

clear all
close all

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

% File containing the coefficients

FX_pacejka_coeff_Rx = struct;
FY_pacejka_coeff_Rx = struct;
MZ_pacejka_coeff_Rx = struct;

%% Cornering calculation 

% for every pressure except 8psi

for FZ=1:length(Fz_C)
    for P=2:length(Pressure)
        for IA=1:length(Camber_C)
            fichier = strcat('C', int2str(round), '_HB137_', Pressure(P), '_25_', int2str(Fz_C(FZ)), '_', int2str(Camber_C(IA)));
            
            FY_coeff = coeff_pacejka_FY(Camber_C(IA), Fz_C(FZ), Pressure(P), round);
            MZ_coeff = coeff_pacejka_MZ(Camber_C(IA), Fz_C(FZ), Pressure(P), round);
            
            FY_pacejka_coeff_Rx.(fichier) = FY_coeff;   % Attention à bien mettre les parenthèse ! Sinon le nom du champs sera file et non la valeur de file
            MZ_pacejka_coeff_Rx.(fichier) = MZ_coeff;   
        end
    end
end

% for 8 psi

for FZ=1:length(Fz_C_8)
        for IA=1:length(Camber_C) 
            fichier = strcat('C', int2str(round), '_HB137_', '8', '_25_', int2str(Fz_C_8(FZ)), '_', int2str(Camber_C(IA)));
                
            FY_coeff = coeff_pacejka_FY(Camber_C(IA), Fz_C_8(FZ), '8', round);
            MZ_coeff = coeff_pacejka_MZ(Camber_C(IA), Fz_C_8(FZ), '8', round);
                
            FY_pacejka_coeff_Rx.(fichier) = FY_coeff;   % Attention à bien mettre les parenthèse ! Sinon le nom du champs sera file et non la valeur de file
            MZ_pacejka_coeff_Rx.(fichier) = MZ_coeff;
        end
end

%% Save for cornering

save(strcat('FY_pacejka_coeff_R',int2str(round),'.mat'), 'FY_pacejka_coeff_Rx')
save(strcat('MZ_pacejka_coeff_R',int2str(round),'.mat'), 'MZ_pacejka_coeff_Rx')

%% Braking calculation 

% for every pressure except 8psi

for FZ=1:length(Fz_B)
    for P=2:length(Pressure)
        for IA=1:length(Camber_B) 
            for SA=1:length(slipe_angles)
                fichier = strcat('B', int2str(round), '_HB137_', Pressure(P), '_25_', int2str(Fz_B(FZ)), '_', int2str(Camber_B(IA)), '_', int2str(slipe_angles(SA)));
                
                FX_coeff = coeff_pacejka_FX(Camber_B(IA), Fz_B(FZ), Pressure(P), round, slipe_angles(SA));
                
                FX_pacejka_coeff_Rx.(fichier) = FX_coeff;
            end
        end
    end
end

% for 8psi
for FZ=1:length(Fz_B_8)
        for IA=1:length(Camber_B) 
            for SA=1:length(slipe_angles)
                fichier = strcat('B', int2str(round), '_HB137_', '8', '_25_', int2str(Fz_B_8(FZ)), '_', int2str(Camber_B(IA)), '_', int2str(slipe_angles(SA)));
                
                FX_coeff = coeff_pacejka_FX(Camber_B(IA), Fz_B_8(FZ), '8', round, slipe_angles(SA));
                
                FX_pacejka_coeff_Rx.(fichier) = FX_coeff;
        end
    end
end

%% Save for braking

save(strcat('FX_pacejka_coeff_R',int2str(round),'.mat'), 'FX_pacejka_coeff_Rx')

