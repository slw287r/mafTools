
include ../../../include.mk
binPath = ../../../bin
libPath = ../../../lib

#cflags = ${cflags_opt}
cflags = ${cflags_dbg}

cflags += -I${libPath}
ifneq ($(wildcard ${kentLibWeb}),)
mafJoinObjs = mafJoin.o jkmaf.o genome.o mafTree.o malnComp.o malnBlk.o malnBlkCursor.o malnBlkSet.o malnSet.o malnJoinBlks.o malnJoinWithinSet.o malnJoinSets.o malnMergeComps.o malnMultiParents.o malnCompCompMap.o
mafOverlapObjs = mafOverlap.o jkmaf.o
mafMultiParentCheckObjs = mafMultiParentCheck.o jkmaf.o genome.o mafTree.o malnComp.o malnBlk.o malnBlkCursor.o malnBlkSet.o malnSet.o malnCompCompMap.o malnMultiParents.o
cflags += -I ${kentInc}
progs = ${binPath}/mafJoin ${binPath}/mafOverlap ${binPath}/mafMultiParentCheck
endif

# holy didn't read the make manual batman
CFLAGS=${cflags} -std=c99 -pedantic


all: ${mafJoinObjs} ${progs}

${mafJoinObjs} ${mafOverlapObjs}: $(wildcard *.h)


${binPath}/mafJoin: ${mafJoinObjs}
	${CC} ${cflags} -I ${libPath} -I ${kentInc} -o $@ $^ ${kentLibWeb} ${libPath}/sonLib.a

${binPath}/mafMultiParentCheck: ${mafMultiParentCheckObjs}
	${CC} ${cflags} -I ${libPath} -I ${kentInc} -o $@ $^ ${kentLibWeb} ${libPath}/sonLib.a

${binPath}/mafOverlap: ${mafOverlapObjs}
	${CC} ${cflags} -I ${libPath} -I ${kentInc} -o $@ $^ ${kentLibWeb} ${libPath}/sonLib.a

clean: 
	rm -f ${mafJoinObjs} ${mafOverlapObjs}

${objs}: *.h

test::
	python mafJoinTest.py

savebak:
	savebak mafJoin *.[ch] mafJoinTest.py Makefile 
