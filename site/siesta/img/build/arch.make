# 
# Copyright (C) 1996-2016	The SIESTA group
#  This file is distributed under the terms of the
#  GNU General Public License: see COPYING in the top directory
#  or http://www.gnu.org/copyleft/gpl.txt.
# See Docs/Contributors.txt for a list of contributors.
#
#-------------------------------------------------------------------
# arch.make file for gfortran compiler.
# To use this arch.make file you should rename it to
#   arch.make
# or make a sym-link.
# For an explanation of the flags see DOCUMENTED-TEMPLATE.make

.SUFFIXES:
.SUFFIXES: .f .F .o .c .a .f90 .F90

SIESTA_ARCH = unknown

CC = gcc
FPP = $(FC) -E -P -x c
FC = mpif90
FC_SERIAL = gfortran

FFLAGS = -O2 -fPIC -ftree-vectorize -march=native -fallow-argument-mismatch 

AR = ar
RANLIB = ranlib

SYS = nag

SP_KIND = 4
DP_KIND = 8
KINDS = $(SP_KIND) $(DP_KIND)

LDFLAGS =

BLAS_LIBS = -lblas
LAPACK_LIBS = -llapack
SCALAPACK_LIBS = -lscalapack-openmpi

#COMP_LIBS = libsiestaLAPACK.a libsiestaBLAS.a

MPI_INTERFACE = libmpi_f90.a
MPI_INCLUDE = .

NETCDF_ROOT = /usr
NETCDF_INCFLAGS = -I$(NETCDF_ROOT)/include
NETCDF_LIBS = -L$(NETCDF_ROOT)/lib/x86_64-linux-gnu -lnetcdff -lnetcdf

FPPFLAGS = $(DEFS_PREFIX)-DFC_HAVE_ABORT
FPPFLAGS += -DMPI -DCDF

LIBS = $(NETCDF_LIBS) $(SCALAPACK_LIBS) $(LAPACK_LIBS) $(BLAS_LIBS) 
# Dependency rules ---------

FFLAGS_DEBUG = -g -O0   # your appropriate flags here...

# The atom.f code is very vulnerable. Particularly the Intel compiler
# will make an erroneous compilation of atom.f with high optimization
# levels.
atom.o: atom.F
	$(FC) -c $(FFLAGS_DEBUG) $(INCFLAGS) $(FPPFLAGS) $(FPPFLAGS_fixed_F) $< 

.c.o:
	$(CC) -c $(CFLAGS) $(INCFLAGS) $(CPPFLAGS) $< 
.F.o:
	$(FC) -c $(FFLAGS) $(INCFLAGS) $(FPPFLAGS) $(FPPFLAGS_fixed_F)  $< 
.F90.o:
	$(FC) -c $(FFLAGS) $(INCFLAGS) $(FPPFLAGS) $(FPPFLAGS_free_F90) $< 
.f.o:
	$(FC) -c $(FFLAGS) $(INCFLAGS) $(FCFLAGS_fixed_f)  $<
.f90.o:
	$(FC) -c $(FFLAGS) $(INCFLAGS) $(FCFLAGS_free_f90)  $<

