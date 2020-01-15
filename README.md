# DeepMetaPSICOV_Kebnekaise_setup
This repo should let you setup DeepMetaPSICOV (DMP) in Kebnekaise.  

## Steps:
1. Enter to your Kebnekaise's user.  
2. Check if you have already created the *~/pfs* soft link in your $HOME, otherwise you have to do it like this:  
```
~$ ln -s /pfs/nobackup$HOME $HOME/pfs
```  

3. Clone this repository to one of your user folder.  
Checking and creating if need it a possible user folder:  

```
~$ mkdir -p ~/pfs/softwares/<YOUR-PATH>
```  
Using HTTPS:  
```
~$ git clone https://github.com/tinchogb/DeepMetaPSICOV_Kebnekaise_setup ~/pfs/softwares/<YOUR-PATH>
```  
Or using SSH:  
```
~$ git clone git@github.com:tinchogb/DeepMetaPSICOV_Kebnekaise_setup ~/pfs/softwares/<YOUR-PATH>
```  
4. Clone DMP from the corresponded github-site [here](https://github.com/psipred/DeepMetaPSICOV) to one folder of your own *~/pfs*. Cloud be *~/pfs/softwares/<YOUR-PATH>*.  
  
```
~$ git clone https://github.com/psipred/DeepMetaPSICOV ~/pfs/softwares/<YOUR-PATH>
```    
5. Check if you already have the hidden folder *~/.lmod.d* in your $HOME. If not, create it in your *~/pfs*, otherwise move it from $HOME to *~/pfs*. At the end, you should have this: *~/pfs/.lmod.d*.  
```
~$ if [[ -d ~/.lmod.d ]] ; then mv ~/.lmod.d ~/pfs/.lmod.d; else mkdir -p ~/pfs/.lmod.d; fi
```  
6. From this cloned repository, move the file:  
  6.1. [**mgb-ml-DMP**](https://github.com/tinchogb/DeepMetaPSICOV_Kebnekaise_setup/mgb-ml-DMP) to *~/pfs/.lmod.d*  
```
~$ if [[ -ef ~/pfs/softwares/<YOUR-PATH>/DeepMetaPSICOV_Kebnekaise_setup/mgb-ml-DMP ]] ; then mv ~/pfs/softwares/<YOUR-PATH>/DeepMetaPSICOV_Kebnekaise_setup/mgb-ml-DMP ~/pfs/.lmod.d; else echo "Check if your file path is correct.."; fi
```  
  6.2. [**run_DMP-Kebnekaiser-installation.sh**](https://github.com/tinchogb/DeepMetaPSICOV_Kebnekaise_setup/run_DMP-Kebnekaiser-installation.sh) to DMP/ directory (defined in step 4)  
```
~$ if [[ -ef ~/pfs/softwares/<YOUR-PATH>/DeepMetaPSICOV_Kebnekaise_setup/run_DMP-Kebnekaiser-installation.sh ]] ; then mv ~/pfs/softwares/<YOUR-PATH>/DeepMetaPSICOV_Kebnekaise_setup/run_DMP-Kebnekaiser-installation.sh ~/pfs/softwares/<YOUR-PATH>/DeepMetaPSICOV; else echo "Check if your file path is correct.."; fi
```  

7. Purge your current modules at Kebnekaise and then load the module collection:\
  7.1. Purge modules
```
~$ ml purge
```
  7.2. Loading module collection  
```
~$ ml restore mgb-ml-DMP
```
  7.3. Check that all the modular are loaded
```
~$ ml restore mgb-ml-DMP
```
8. Go to your DMP/ directory and run **run_DMP-Kebnekaiser-installation.sh**:  
  - Basic run like this (MANDATORY positional parameters):  
```~$ ./run_DMP-Kebnekaiser-installation.sh hhsuite-database-path blast-database-path```  
  - Full run like this (Optional positional parameters):  
```~$ ./run_DMP-Kebnekaiser-installation.sh hhsuite-database-path blast-database-path hhblits-threats psiblast-threats psicov-threats ccmpred-threats freecontact-threats ccmpred-time psicov-time```  
9. When you have run it, one file is created in that folder, called **old_unmodify_run_DMP.sh**. This is a copy from the real unmodify running script (**run_DMP.sh**). This **old_unmodify_run_DMP.sh** is just for backup if you missed something or you want to change other settings and run again step 8 (like change databases, threats, etc).  
10. If you need further information, you can open **run_DMP-Kebnekaiser-installation.sh** and read the first lines.  

Thanks to DMP's group for the software!  

Feel free to improve everything!
