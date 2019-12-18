#!/bin/bash

# This script will let you adapt the running
# DMP script (run_DMP.sh) and declare the
# databases paths, threats and times. After
# that, you only need to use run_DMP.sh to
# run DeepMetaPSICOV software.


# PRECONDITIONS: 
#		Have loaded the following ml collection: mgb-ml-DMP
#		Have installed DeepMetaPSICOV in one ~/pfs/<YOUR-PATH> Kebnekaise folder.
#		Have this script (run_DMP-Kebnekaiser-installation.sh) inside the DeepMetaPSICOV/ folder.

	# Script arguments:

	# MANDATORY
	#	1) hhblits database path             // string
        #       2) psiblast database path            // string
	# OPTIONAL
	#	3) hhblits threats		     // number (int); default (4)
	#       4) psiblast threats                  // number (int); default (4)
        #       5) psicov threats                    // number (int); default (6)
        #       6) ccmpred threats                   // number (int); default (6)
        #       7) freecontact threats               // number (int); default (8)
        #       8) ccmpred time in seconds           // number (int); default (86400)
        #       9) psicov time in seconds            // number (int); default (86400)

	# Basic run it like this:
		# ./run_DMP-Kebnekaiser-installation.sh [hhsuite-database-path] [blast-database-path]
        # Full run it like this:
                # ./run_DMP-Kebnekaiser-installation.sh [hhsuite-database-path] [blast-database-path] [hhblits-threats] [psiblast-threats] [psicov-threats] [ccmpred-threats] [freecontact-threats] [ccmpred-time] [psicov-time]

# OBSERVATIONS:
	# In Kebnekaise Claudio has these databases to be used:
	# For hhblits:
	#	/home/m/mgonzale/pfs/group-storage/databases/uniclust30_2018_08/uniclust30_2018_08
	#	/home/c/cbass/pfs/databases/uniclust30_2017_04/uniclust30_2017_04
	# For psiblast:
	#	/pfs/nobackup/home/m/mircomic/databases/uniref/uniref90.fasta
	#	/home/c/cbass/pfs/databases/uniref90.fasta    <--- didn't work for me
	#
	# After run this script, you need to use only run_DMP.sh to use DeepMetaPSICOV.

### If some command fails, the script will end after that.
set -e

### Checking that arguments exists
if [[ $# -eq 0 ]]
 then
    echo "No arguments supplied. Please check if at least you are suppling the databases paths"
    exit 1
fi

### Checking that the first and second arguments are PATHs (strings with lenght > 0)
if [[ -z $1 ]] || [[ -z $2 ]]
 then
    echo "No string paths supplied. Please check if at least you are suppling the databases paths"
    exit 1
fi


### Databases basenames of HHblits and PSI-BLAST
if [[ -x run_DMP.sh ]]
then
	# Before any change, make a copy of the script to edit
	if [[ ! -x old_unmodify_run_DMP.sh ]]
	then
		cp -p run_DMP.sh old_unmodify_run_DMP.sh
		#Then you can use this file to start over.
	fi

	# Load the databases paths
	if [[ -f $1 ]] && [[ -f $2 ]]
	then
		sed -i "s+\$HOME/working/hhblitsdb/uniclust30_2018_08/uniclust30_2018_08+${1}+g" run_DMP.sh
		sed -i "s+\$maindir/data/blast/nr+${2}+g" run_DMP.sh
	else
		echo "Some database path is wrong or simply doesn't exist."
	fi
	### Modifying variables of run_DMP.sh
	# python
	use_python="$(which python3)"
	sed -i "s+python=\$HOME/miniconda3/bin/python+python=${use_python}+g" run_DMP.sh
	# hhsuite
	use_hhblits="$(which hhblits)"
	use_hhblits_dir="${use_hhblits/%\/bin*/}"
	sed -i "s+\$HOME/working/DMP/hh-suite-patched+${use_hhblits_dir}+g" run_DMP.sh
	# blastpgp
	use_blastpgp="$(which blastpgp)"
	sed -i "s+\$bindir/blastpgp+${use_blastpgp}+g" run_DMP.sh
	# makemat
	use_makemat="$(which makemat)"
	sed -i "s+\$bindir/makemat+${use_makemat}+g" run_DMP.sh
	# ccmpred
	use_ccmpred="$(which ccmpred)"
	sed -i "s+\$bindir/ccmpred+${use_ccmpred}+g" run_DMP.sh
	# freecontact
	use_freecontact="$(which freecontact)"
	sed -i "s+\$bindir/freecontact+${use_freecontact}+g" run_DMP.sh
	# env blast (BLASTMAT and BLASTDB)
	use_blast_data_dir="${use_blastpgp/%\/bin*/\/data}"
	sed -i "s+BLASTMAT=\$maindir/data/blast+BLASTMAT=${use_blast_data_dir}+g" run_DMP.sh
        sed -i "s+BLASTDB=\$maindir/data/blast+BLASTDB=${use_blast_data_dir}+g" run_DMP.sh

	### Number of threads to use in various programs
	# Threads in hhblits
	if [[ ! -z $3 ]]
	then
		sed -i "s+hhblits_threads=4+hhblits_threads=${3}+g" run_DMP.sh
	fi
	
	# Threads in psiblast
	if [[ ! -z $4 ]]
	then
        	sed -i "s+psiblast_threads=4+psiblast_threads=${4}+g" run_DMP.sh
	fi
	
	# Threads in psicov
	if [[ ! -z $5 ]]
	then
        	sed -i "s+psicov_threads=6+psicov_threads=${5}+g" run_DMP.sh
	fi

	# Threads in ccmpred
	if [[ ! -z $6 ]]
	then
        	sed -i "s+ccmpred_threads=6+ccmpred_threads=${6}+g" run_DMP.sh
	fi

	# Threads in freecontact
	if [[ ! -z $7 ]]
	then
        	sed -i "s+freecontact_threads=8+freecontact_threads=${7}+g" run_DMP.sh
	fi

	### Timeouts for CCMpred and PSICOV (in seconds)
        # Time for ccmpred
	if [[ ! -z $8 ]]
        then
                sed -i "s+ccmpred_timeout=86400+ccmpred_timeout=${8}+g" run_DMP.sh
        fi

	# Time for psicov
        if [[ ! -z $9 ]]
        then
                sed -i "s+psicov_timeout=86400+psicov_timeout=${9}+g" run_DMP.sh
	fi

	echo "run_DMP.sh edition has finished"
else
	echo "Error, run_DMP.sh does not exist".
	exit 1
fi

echo "run_DMP-Kebnekaiser-installation.sh running has finished. Please, now use only run_DMP.sh"
