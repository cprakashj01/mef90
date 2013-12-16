all:
	-@make -C ${MEF90_DIR} ThermoElasticity
test: test2D test3D
test2D: 
	-@for OPTIONSFILE in test1.opts test2.opts test3.opts; do \
	make testThermoElasticity PREFIX=SquareNG_X-tri3 OPTIONSFILE=$${OPTIONSFILE};\
	make testThermoElasticity PREFIX=SquareNG_X-tri6 OPTIONSFILE=$${OPTIONSFILE};\
	make testThermoElasticity PREFIX=SquareNG_Y-tri3 OPTIONSFILE=$${OPTIONSFILE};\
	make testThermoElasticity PREFIX=SquareNG_Y-tri6 OPTIONSFILE=$${OPTIONSFILE};\
	done

test3D: 
	-@for OPTIONSFILE in test1.opts test2.opts test3.opts; do \
	make testThermoElasticity PREFIX=CubeNG_X-tetra4  OPTIONSFILE=$${OPTIONSFILE};\
	make testThermoElasticity PREFIX=CubeNG_X-tetra10 OPTIONSFILE=$${OPTIONSFILE};\
	make testThermoElasticity PREFIX=CubeNG_Y-tetra4  OPTIONSFILE=$${OPTIONSFILE};\
	make testThermoElasticity PREFIX=CubeNG_Y-tetra10 OPTIONSFILE=$${OPTIONSFILE};\
	make testThermoElasticity PREFIX=CubeNG_Z-tetra4  OPTIONSFILE=$${OPTIONSFILE};\
	make testThermoElasticity PREFIX=CubeNG_Z-tetra10 OPTIONSFILE=$${OPTIONSFILE};\
	done

include ${PETSC_DIR}/conf/rules
include ${PETSC_DIR}/conf/variables
include ${MEF90_DIR}/Makefile.include
include ${MEF90_DIR}/MEF90/Makefile.include
include ${MEF90_DIR}/m_DefMech/Makefile.include
include ${MEF90_DIR}/m_Elasticity/Makefile.include
BASE_DIR=${MEF90_DIR}/ThermoElasticity

ThermoElasticity:${MEF90_DIR}/bin/${PETSC_ARCH}/ThermoElasticity
	-@echo "      $@"

${MEF90_DIR}/bin/${PETSC_ARCH}/ThermoElasticity: ThermoElasticity.o
	-@echo "      $@"
	-@${FLINKER} -o $@ ThermoElasticity.o ${MEF90_OBJS} ${MEF90_DEFMECH_OBJS} ${PETSC_FORTRAN_LIB} ${PETSC_LIB} 

ThermoElasticity.o: ${BASE_DIR}/ThermoElasticity.F90 ${MEF90_DEFMECH_OBJS}
	@echo "      $<"
	-@${FC} ${FC_FLAGS} ${FCPPFLAGS} -I${MEF90_INCLUDE} -c -o $@ $<

testThermoElasticity:
	@echo "Testing ThermoElasticity with $${PREFIX} $${OPTIONSFILE}"
	@ARGS="-prefix data/$${PREFIX} -options_file data/$${OPTIONSFILE}";\
	${MPIEXEC} -n 2 ${MEF90_DIR}/bin/${PETSC_ARCH}/ThermoElasticity $${ARGS} > $${PREFIX}-$${OPTIONSFILE}.out 2>&1;\
	if (${DIFF} -B ${MEF90_DIR}/ThermoElasticity/results/${PREFIX}-$${OPTIONSFILE}.out ${PREFIX}-$${OPTIONSFILE}.out) then echo "         ... passed";\
	else echo "Possible problem. Diffs above \n========================================="; fi
	-@${RM} $${PREFIX}-$${OPTIONSFILE}.out 
	
MEF90:
	make -C ${MEF90_DIR} MEF90
m_DEFMECH:
	make -C ${MEF90_DIR} m_DEFMECH
	
clean::
	-@rm ThermoElasticity
allclean:
	make -C ${MEF90_DIR} clean
	
debug::
	@echo FFLAGS ${FFLAGS} 
	@echo FC_FLAGS ${FC_FLAGS}
	@echo FCFLAGS ${FCFLAGS}
	@echo FCPPFLAGS ${FCPPFLAGS}
	@echo FCPP_FLAGS ${FCPP_FLAGS}