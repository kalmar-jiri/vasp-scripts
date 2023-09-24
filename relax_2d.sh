#!/bin/bash
#$ -cwd
#$ -e .
#$ -o .
#$ -l mem=3800M
#$ -q mq-16-4
#$ -pe mpi_16 16 

export MPIBIN=/home/novotny/intel/parallel_studio_xe_2018/compilers_and_libraries_2018/linux/mpi/intel64/bin
export LD_LIBRARY_PATH="/home/novotny/intel/lib/intel64:/home/novotny/intel/mkl/lib/intel64:/lib:/home/novotny/intel/parallel_studio_xe_2018/compilers_and_libraries_2018/linux/mpi/intel64/lib:$LD_LIBRARY_PATH"


mkdir isif4 isif2

cp PO* INCAR KPOINTS ./isif4
cd isif4

sed -i 's/ISIF=4/ISIF=4/' INCAR

date
$MPIBIN/mpirun -n 16 /home/novotny/dev/vasp.6.1.0/bin/vasp_std
date


cd ../

cp POTCAR INCAR KPOINTS ./isif2
cp isif4/CONTCAR isif2/POSCAR
cd isif2

sed -i 's/ISIF=4/ISIF=2/' INCAR

date
$MPIBIN/mpirun -n 16 /home/novotny/dev/vasp.6.1.0/bin/vasp_std
date
