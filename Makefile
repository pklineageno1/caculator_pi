CC ?= gcc
CFLAGS_common ?= -mavx2 -std=c99 -o
PERF_FLAGS = stat -r 1 -e cache-misses,cache-references,L1-dcache-load-misses,L1-dcache-store-misses,L1-dcache-prefetch-misses,L1-icache-load-misses,cs,branch-misses

EXEC = pi pi_SIMD pi_SIMD_OPT
all: $(EXEC)

pi: 
	$(CC) $(CFLAGS_common) $@ $@.c

pi_SIMD:	
	$(CC) $(CFLAGS_common) $@ $@.c
	
pi_SIMD_OPT:
	$(CC) $(CFLAGS_common) $@ $@.c

perf_pi: pi
	echo "echo 1 > /proc/sys/vm/drop_caches" | sudo sh
	perf $(PERF_FLAGS) ./pi

perf_pi_SIMD: pi_SIMD
	echo "echo 1 > /proc/sys/vm/drop_caches" | sudo sh
	perf $(PERF_FLAGS) ./pi_SIMD

perf_pi_SIMD_OPT: pi_SIMD_OPT
	echo "echo 1 > /proc/sys/vm/drop_caches" | sudo sh
	perf $(PERF_FLAGS) ./pi_SIMD_OPT

clean:
	$(RM) $(EXEC) *.o perf.*
