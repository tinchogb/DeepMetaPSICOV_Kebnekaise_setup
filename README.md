# DeepMetaPSICOV_Kebnekaise_setup
This repo should let you setup DeepMetaPSICOV (DMP) in Kebnekaise.

## Steps:
1. Enter to your Kebnekaise's user.
2. Check if you have already created the *~/pfs* soft link in your $HOME, otherwise you have to do it first.
3. Clone this repository to one of your user folder.
4. Clone DMP from the corresponded github-site [(here)](https://github.com/psipred/DeepMetaPSICOV) to one folder of your own *~/pfs*. Cloud be *~/pfs/softwares/<YOUR-PATH>*.
5. Check if you if you already have the hidden folder *~/.lmod.d* in your $HOME. If not, create it in your *~/pfs* the hidden folder *~/.lmod.d*, otherwise move it from $HOME to *~/pfs*. At the end, you should have this: *~/pfs/.lmod.d*
6. From this cloned repository, move the file:
  6.1. **mgb-ml-DMP** to *~/pfs/.lmod.d*
  6.2. **run_DMP-Kebnekaiser-installation.sh** to DMP/ directory (defined in step 4).
7. Purge your current modules and then load the module collection: `ml restore mgb-ml-DMP`
  7.1. Check that all the modular are loaded: `ml`
8. Go to DMP/ directory and run **run_DMP-Kebnekaiser-installation.sh**:
  - Basic run it like this (MANDATORY positional parameters):
  `./run_DMP-Kebnekaiser-installation.sh hhsuite-database-path blast-database-path`
  - Full run it like this (Optional positional parameters):
  `./run_DMP-Kebnekaiser-installation.sh hhsuite-database-path blast-database-path hhblits-threats psiblast-threats psicov-threats ccmpred-threats freecontact-threats ccmpred-time psicov-time`
9. When you have run it, one file is created in that folder, called **old_unmodify_run_DMP.sh**. This is a copy from the real unmodify running script (**run_DMP.sh**). This **old_unmodify_run_DMP.sh** is just for backup if you missed something or you want to change other settings and run again step 8 (like change databases, threats, etc).
10. If you need further information, you can open **run_DMP-Kebnekaiser-installation.sh** and read the first lines.

Thanks to DMP's Team for the software!

Feel free to improve everything!


