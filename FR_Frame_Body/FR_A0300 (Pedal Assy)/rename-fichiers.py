import os

#chemin du dossier où se trouvent les fichiers à renommer
#mettre le fichier texte dans ce dossier
path='C:\Users\Calixthe\Desktop\EPSA\STUF-2020\FR_Frame_Body\FR_A0300 (Pedal Assy)' #à modifier, ne pas oublier les \\ ou le /




def rename(path):
    os.chdir(path)
    list_old,list_new=[],[]
    fichier = open('nomenclature.txt','r')# r : read / w : write / a : append
    for ligne in fichier:
        champs=ligne.strip().split(';')
        list_old.append(champs[0]+'.CATProduct'*('ensemble' in champs[0])+'.CATPart'*('ensemble' not in champs[0]))
        list_new.append(champs[1]+'.CATProduct'*('ensemble' in champs[0])+'.CATPart'*('ensemble' not in champs[0]))
    fichier.close()
    for k in range(len(list_old)):
        try:
            os.rename(list_old[k],list_new[k])
            print('FICHIER '+str(list_old[k])+' RENOMME EN '+str(list_new[k]))
        except:
            print('fichier à ce nom non trouvé')