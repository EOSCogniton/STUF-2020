# Pacejka Tyre Model from @GTE
lire la docuemntation (redigé par GTE)
── Utilisation et explication (1).docx
├── Utilisation et explication (1).pdf
├── Utilisation et explication.docx


# Folders
## Raw et nomenclaturee
fiches donnees brutes

├── table pneus.xlsx
├── Nomenclature.pdf 
├── raw
│   ├── Round5_Brake_all_run.mat
│   ├── Round5_Corner_all_run.mat
│   ├── Round6_Brake_all_run.mat
│   └── Round6_Corner_all_run.mat

## Results

##  fiches d'affichage et plot
├── plot_FY.m
├── plot_MZ.m


# Matlab files 
## coeff_pajecka_XX.m
XX prends les valeur FX, Fy, Mz. Il s'agit des function d'interpolation des donnees 
brutes selon le modele de Pacejka '84

## f_pacejka.m
fonction d'interpolation de Pacejka '84, elle est valide pour tout modeles FX FY et MZ

## fichers inconnus

├── reg_lin.m
├── reg_lin.mat
├── replay_pid31112.log
├── pacejka_mat_file_creation.m
├── test_bug.asv
├── test_bug.m
├── Verification(1).m
├── Verification.m
├── Verification.mat




