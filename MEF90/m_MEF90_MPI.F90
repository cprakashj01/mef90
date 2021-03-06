Module m_MEF90_MPI
#include "finclude/petscdef.h"
   Use m_MEF90_Parameters
   Use petsc
   Implicit None

   Private
   Integer,Public,protected   :: Vect2D_MPIType
   Integer,Public,protected   :: Vect3D_MPIType
   
   Integer,Public,protected   :: Mat2D_MPIType
   Integer,Public,protected   :: Mat3D_MPIType
   Integer,Public,protected   :: MatS2D_MPIType
   Integer,Public,protected   :: MatS3D_MPIType
   
   Integer,Public,protected   :: Tens4OS2D_MPIType
   Integer,Public,protected   :: Tens4OS3D_MPIType
   
   PetscInt,Public,protected  :: MEF90_MyRank
   PetscInt,Public,protected  :: MEF90_NumProcs

   
   Public   :: MEF90MPIInitialize_Private
   Public   :: MEF90MPIFinalize_Private
   
Contains

!!!
!!!  
!!!  MEF90MPIInitialize_Private:
!!!  
!!!  (c) 2014 Blaise Bourdin bourdin@lsu.edu
!!!
#undef __FUNCT__
#define __FUNCT__ "MEF90MPIInitialize_Private"
   Subroutine MEF90MPIInitialize_Private(ierr)
      PetscErrorCode,Intent(OUT)            :: ierr
      PetscInt,Dimension(:),Pointer         :: BlkCounts,Offsets,DataTypes
      PetscInt                              :: NumBlk
#ifdef PETSC_USE_DEBUG
      Character(len=MEF90_MXSTRLEN)         :: IOBuffer
      Character(len=MPI_MAX_PROCESSOR_NAME) :: procName
      Integer                               :: procNameLength
#endif      
      Call MPI_COMM_RANK(MPI_COMM_WORLD,MEF90_MyRank,ierr)
      Call MPI_COMM_SIZE(MPI_COMM_WORLD,MEF90_NumProcs,ierr)

      !!! Vect2D,Vect3D,Mat2D,MatS2D,Mat3D,MatS3D,Tens4OS2D,Tens4OSD3D
      NumBlk=1
      Allocate(BlkCounts(0:NumBlk-1))
      Allocate(Offsets(0:NumBlk-1))
      Allocate(DataTypes(0:NumBlk-1))
      
      
      Offsets(0)   = 0
      DataTypes(0) = MPIU_SCALAR
      
      BlkCounts(0) = 2
      Call MPI_TYPE_STRUCT(1,BlkCounts,Offsets,DataTypes,Vect2D_MPIType,ierr)
      Call MPI_TYPE_COMMIT(Vect2D_MPIType,ierr)
      
      BlkCounts(0) = 3
      Call MPI_TYPE_STRUCT(1,BlkCounts,Offsets,DataTypes,Vect3D_MPIType,ierr)
      Call MPI_TYPE_COMMIT(Vect3D_MPIType,ierr)
      
      
      BlkCounts(0) = 4
      Call MPI_TYPE_STRUCT(1,BlkCounts,Offsets,DataTypes,Mat2D_MPIType,ierr)
      Call MPI_TYPE_COMMIT(Mat2D_MPIType,ierr)
      
      BlkCounts(0) = 3
      Call MPI_TYPE_STRUCT(1,BlkCounts,Offsets,DataTypes,MatS2D_MPIType,ierr)
      Call MPI_TYPE_COMMIT(MatS2D_MPIType,ierr)
      
      BlkCounts(0) = 9
      Call MPI_TYPE_STRUCT(1,BlkCounts,Offsets,DataTypes,Mat3D_MPIType,ierr)
      Call MPI_TYPE_COMMIT(Mat3D_MPIType,ierr)
      
      BlkCounts(0) = 6
      Call MPI_TYPE_STRUCT(1,BlkCounts,Offsets,DataTypes,MatS3D_MPIType,ierr)
      Call MPI_TYPE_COMMIT(MatS3D_MPIType,ierr)
      
      BlkCounts(0) = 6
      Call MPI_TYPE_STRUCT(1,BlkCounts,Offsets,DataTypes,Tens4OS2D_MPIType,ierr)
      Call MPI_TYPE_COMMIT(Tens4OS2D_MPIType,ierr)
      
      BlkCounts(0) = 21
      Call MPI_TYPE_STRUCT(1,BlkCounts,Offsets,DataTypes,Tens4OS3D_MPIType,ierr)
      Call MPI_TYPE_COMMIT(Tens4OS3D_MPIType,ierr)
      DeAllocate(BlkCounts,Offsets,DataTypes)
      
      Call MPI_COMM_RANK(MPI_COMM_WORLD,MEF90_MyRank,ierr)
      Call MPI_COMM_SIZE(MPI_COMM_WORLD,MEF90_NumProcs,ierr)

#ifdef PETSC_USE_DEBUG
      call MPI_Get_processor_name(procName,procNameLength,ierr)
      Write(IOBuffer,100) MEF90_MyRank,MEF90_NumProcs,trim(procName)
      Call PetscSynchronizedPrintf(PETSC_COMM_WORLD,IOBuffer,ierr);CHKERRQ(ierr)
      Call PetscSynchronizedFLush(PETSC_COMM_WORLD,ierr);CHKERRQ(ierr)
100 format(' # Task ',I6,'/',I6,' running on processor ',A,'\n')
#endif
   End Subroutine MEF90MPIInitialize_Private
   
!!!
!!!  
!!!  MEF90MPIFinalize_Private:
!!!  
!!!  (c) 2014 Blaise Bourdin bourdin@lsu.edu
!!!
#undef __FUNCT__
#define __FUNCT__ "MEF90MPIFinalize_Private"
   Subroutine MEF90MPIFinalize_Private(ierr)
      PetscInt,Intent(OUT)             :: ierr
      
      Call MPI_TYPE_FREE(Vect2D_MPIType,ierr)
      Call MPI_TYPE_FREE(Vect3D_MPIType,ierr)
      Call MPI_TYPE_FREE(Mat2D_MPIType,ierr)
      Call MPI_TYPE_FREE(MatS2D_MPIType,ierr)
      Call MPI_TYPE_FREE(Mat3D_MPIType,ierr)
      Call MPI_TYPE_FREE(MatS3D_MPIType,ierr)
      Call MPI_TYPE_FREE(Tens4OS2D_MPIType,ierr)
      Call MPI_TYPE_FREE(Tens4OS3D_MPIType,ierr)
   End Subroutine MEF90MPIFinalize_Private
End Module m_MEF90_MPI
