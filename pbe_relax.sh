#!/bin/bash
#$ -cwd
#$ -e .
#$ -o .
#$ -l mem=3800M
#$ -q mq-16-4
#$ -pe mpi_16 16 

export MPIBIN=/home/novotny/intel/parallel_studio_xe_2018/compilers_and_libraries_2018/linux/mpi/intel64/bin
export LD_LIBRARY_PATH="/home/novotny/intel/lib/intel64:/home/novotny/intel/mkl/lib/intel64:/lib:/home/novotny/intel/parallel_studio_xe_2018/compilers_and_libraries_2018/linux/mpi/intel64/lib:$LD_LIBRARY_PATH"



mkdir a_2 b_7 c_2 d_7 e_2

cd a_2
cp ../PO* ../KPOINTS .

cat>>INCAR<<!
SYSTEM=Mn2CO2 (AFM)

            #general
#ISTART=1     #restart-to read the file WAVECAR (=0 no, =1 read WAVECAR, =2,3...)
ISPIN=2      #closed/open shell calculation (=2 spin polarized calulation, =1 no spin)
NPAR=4       #switched on parallelization (and data distribution) over bands,number of cores/NPAR must be integer,recommended:NPAR=approx SQRT( number of cores)


            #electronic calc.
PREC=ACCURATE #default for four sets of parameters (ENCUT; NGX, NGY, NGZ; NGXF, NGYF, NGZF and ROPT)
ENCUT=500    #Cut-off energy for plane wave basis set in eV, default= largest ENMAX from POTCAR-file
ISMEAR=0     #how the partial occupancies are set for each orbital (=-1 Fermi smearing, =0 Gaussian, =1..N method of Methfessel-Paxton order N, =-5 tetrahedron method with Blochl corr., =-3 loop)
SIGMA=0.05   #width of the smearing
#NBANDS=64   #actual number of bands in the calculation (occupied+empty)
EDIFF=1E-7   #energy stopping-criterion for electronic convergence
MAGMOM = 2*4.0 3*0

            #geometry optimization

NSW=100       #sets the maximum number of ionic steps
EDIFFG=-0.01  #energy stopping-criterion for ionic moves
IBRION=2       #how the ions are updated and moved (=0 MD,=1 RMM-DIIS, =2 Conj.grad, =5,6 finite differences Hessian&phonons, =7,8 DFPT)
ISIF=2         #whether the stress tensor is calculated (=2 relax ions, =4 ions+cell shape, =3 ions+shape+cell volume)


             #output
LORBIT = 11    #wavefunction analysis,whether the PROCAR or PROOUT files are written ()

             #density functional

              #other properties, calculations
#LOPTICS=.TRUE. #frequency dependent dielectric matrix
#LRPA=.TRUE.    #local field effect are included
NEDOS=2000     #number of grid points in DOS
#NOMEGA=128     #number of frequency grid points
!

date
$MPIBIN/mpirun -n 16 /home/novotny/dev/vasp.6.1.0/bin/vasp_std
date

cd ../b_7
cp ../a_2/CONTCAR POSCAR
cp ../POTCAR ../KPOINTS .

cat>>INCAR<<!
SYSTEM=Mn2CO2 (AFM)

            #general
#ISTART=1     #restart-to read the file WAVECAR (=0 no, =1 read WAVECAR, =2,3...)
ISPIN=2      #closed/open shell calculation (=2 spin polarized calulation, =1 no spin)
NPAR=4       #switched on parallelization (and data distribution) over bands,number of cores/NPAR must be integer,recommended:NPAR=approx SQRT( number of cores)


            #electronic calc.
PREC=ACCURATE #default for four sets of parameters (ENCUT; NGX, NGY, NGZ; NGXF, NGYF, NGZF and ROPT)
ENCUT=500    #Cut-off energy for plane wave basis set in eV, default= largest ENMAX from POTCAR-file
ISMEAR=0     #how the partial occupancies are set for each orbital (=-1 Fermi smearing, =0 Gaussian, =1..N method of Methfessel-Paxton order N, =-5 tetrahedron method with Blochl corr., =-3 loop)
SIGMA=0.05   #width of the smearing
#NBANDS=64   #actual number of bands in the calculation (occupied+empty)
EDIFF=1E-7   #energy stopping-criterion for electronic convergence
MAGMOM = 2*4.0 3*0

            #geometry optimization

NSW=100       #sets the maximum number of ionic steps
EDIFFG=-0.01  #energy stopping-criterion for ionic moves
IBRION=2       #how the ions are updated and moved (=0 MD,=1 RMM-DIIS, =2 Conj.grad, =5,6 finite differences Hessian&phonons, =7,8 DFPT)
ISIF=7         #whether the stress tensor is calculated (=2 relax ions, =4 ions+cell shape, =3 ions+shape+cell volume)


             #output
LORBIT = 11    #wavefunction analysis,whether the PROCAR or PROOUT files are written ()

             #density functional

              #other properties, calculations
#LOPTICS=.TRUE. #frequency dependent dielectric matrix
#LRPA=.TRUE.    #local field effect are included
NEDOS=2000     #number of grid points in DOS
#NOMEGA=128     #number of frequency grid points
!

date
$MPIBIN/mpirun -n 16 /home/novotny/dev/vasp.6.1.0/bin/vasp_std
date

cd ../c_2
cp ../b_7/CONTCAR POSCAR
cp ../POTCAR ../KPOINTS .

cat>>INCAR<<!
SYSTEM=Mn2CO2 (AFM)

            #general
#ISTART=1     #restart-to read the file WAVECAR (=0 no, =1 read WAVECAR, =2,3...)
ISPIN=2      #closed/open shell calculation (=2 spin polarized calulation, =1 no spin)
NPAR=4       #switched on parallelization (and data distribution) over bands,number of cores/NPAR must be integer,recommended:NPAR=approx SQRT( number of cores)


            #electronic calc.
PREC=ACCURATE #default for four sets of parameters (ENCUT; NGX, NGY, NGZ; NGXF, NGYF, NGZF and ROPT)
ENCUT=500    #Cut-off energy for plane wave basis set in eV, default= largest ENMAX from POTCAR-file
ISMEAR=0     #how the partial occupancies are set for each orbital (=-1 Fermi smearing, =0 Gaussian, =1..N method of Methfessel-Paxton order N, =-5 tetrahedron method with Blochl corr., =-3 loop)
SIGMA=0.05   #width of the smearing
#NBANDS=64   #actual number of bands in the calculation (occupied+empty)
EDIFF=1E-7   #energy stopping-criterion for electronic convergence
MAGMOM = 2*4.0 3*0

            #geometry optimization

NSW=100       #sets the maximum number of ionic steps
EDIFFG=-0.01  #energy stopping-criterion for ionic moves
IBRION=2       #how the ions are updated and moved (=0 MD,=1 RMM-DIIS, =2 Conj.grad, =5,6 finite differences Hessian&phonons, =7,8 DFPT)
ISIF=2         #whether the stress tensor is calculated (=2 relax ions, =4 ions+cell shape, =3 ions+shape+cell volume)


             #output
LORBIT = 11    #wavefunction analysis,whether the PROCAR or PROOUT files are written ()

             #density functional

              #other properties, calculations
#LOPTICS=.TRUE. #frequency dependent dielectric matrix
#LRPA=.TRUE.    #local field effect are included
NEDOS=2000     #number of grid points in DOS
#NOMEGA=128     #number of frequency grid points
!

date
$MPIBIN/mpirun -n 16 /home/novotny/dev/vasp.6.1.0/bin/vasp_std
date

cd ../d_7
cp ../c_2/CONTCAR POSCAR
cp ../POTCAR ../KPOINTS .

cat>>INCAR<<!
SYSTEM=Mn2CO2 (AFM)

            #general
#ISTART=1     #restart-to read the file WAVECAR (=0 no, =1 read WAVECAR, =2,3...)
ISPIN=2      #closed/open shell calculation (=2 spin polarized calulation, =1 no spin)
NPAR=4       #switched on parallelization (and data distribution) over bands,number of cores/NPAR must be integer,recommended:NPAR=approx SQRT( number of cores)


            #electronic calc.
PREC=ACCURATE #default for four sets of parameters (ENCUT; NGX, NGY, NGZ; NGXF, NGYF, NGZF and ROPT)
ENCUT=500    #Cut-off energy for plane wave basis set in eV, default= largest ENMAX from POTCAR-file
ISMEAR=0     #how the partial occupancies are set for each orbital (=-1 Fermi smearing, =0 Gaussian, =1..N method of Methfessel-Paxton order N, =-5 tetrahedron method with Blochl corr., =-3 loop)
SIGMA=0.05   #width of the smearing
#NBANDS=64   #actual number of bands in the calculation (occupied+empty)
EDIFF=1E-7   #energy stopping-criterion for electronic convergence
MAGMOM = 2*4.0 3*0

            #geometry optimization

NSW=100       #sets the maximum number of ionic steps
EDIFFG=-0.01  #energy stopping-criterion for ionic moves
IBRION=2       #how the ions are updated and moved (=0 MD,=1 RMM-DIIS, =2 Conj.grad, =5,6 finite differences Hessian&phonons, =7,8 DFPT)
ISIF=7         #whether the stress tensor is calculated (=2 relax ions, =4 ions+cell shape, =3 ions+shape+cell volume)


             #output
LORBIT = 11    #wavefunction analysis,whether the PROCAR or PROOUT files are written ()

             #density functional

              #other properties, calculations
#LOPTICS=.TRUE. #frequency dependent dielectric matrix
#LRPA=.TRUE.    #local field effect are included
NEDOS=2000     #number of grid points in DOS
#NOMEGA=128     #number of frequency grid points
!

date
$MPIBIN/mpirun -n 16 /home/novotny/dev/vasp.6.1.0/bin/vasp_std
date

cd ../e_2
cp ../d_7/CONTCAR POSCAR
cp ../POTCAR ../KPOINTS .

cat>>INCAR<<!
SYSTEM=Mn2CO2 (AFM)

            #general
#ISTART=1     #restart-to read the file WAVECAR (=0 no, =1 read WAVECAR, =2,3...)
ISPIN=2      #closed/open shell calculation (=2 spin polarized calulation, =1 no spin)
NPAR=4       #switched on parallelization (and data distribution) over bands,number of cores/NPAR must be integer,recommended:NPAR=approx SQRT( number of cores)


            #electronic calc.
PREC=ACCURATE #default for four sets of parameters (ENCUT; NGX, NGY, NGZ; NGXF, NGYF, NGZF and ROPT)
ENCUT=500    #Cut-off energy for plane wave basis set in eV, default= largest ENMAX from POTCAR-file
ISMEAR=0     #how the partial occupancies are set for each orbital (=-1 Fermi smearing, =0 Gaussian, =1..N method of Methfessel-Paxton order N, =-5 tetrahedron method with Blochl corr., =-3 loop)
SIGMA=0.05   #width of the smearing
#NBANDS=64   #actual number of bands in the calculation (occupied+empty)
EDIFF=1E-7   #energy stopping-criterion for electronic convergence
MAGMOM = 2*4.0 3*0

            #geometry optimization

NSW=100       #sets the maximum number of ionic steps
EDIFFG=-0.01  #energy stopping-criterion for ionic moves
IBRION=2       #how the ions are updated and moved (=0 MD,=1 RMM-DIIS, =2 Conj.grad, =5,6 finite differences Hessian&phonons, =7,8 DFPT)
ISIF=2         #whether the stress tensor is calculated (=2 relax ions, =4 ions+cell shape, =3 ions+shape+cell volume)


             #output
LORBIT = 11    #wavefunction analysis,whether the PROCAR or PROOUT files are written ()

             #density functional

              #other properties, calculations
#LOPTICS=.TRUE. #frequency dependent dielectric matrix
#LRPA=.TRUE.    #local field effect are included
NEDOS=2000     #number of grid points in DOS
#NOMEGA=128     #number of frequency grid points
!

date
$MPIBIN/mpirun -n 16 /home/novotny/dev/vasp.6.1.0/bin/vasp_std
date
