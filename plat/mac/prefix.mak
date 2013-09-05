# architecture makefile configure

# prefix & suffix
BIN_PREFIX 			= 
BIN_SUFFIX 			= .b

OBJ_PREFIX 			= 
OBJ_SUFFIX 			= .o

LIB_PREFIX 			= lib
LIB_SUFFIX 			= .a

DLL_PREFIX 			= 
DLL_SUFFIX 			= .dylib

ASM_SUFFIX 			= .S

# tool
PRE 				= 
CC 					= $(PRE)gcc
MM 					= $(PRE)gcc
AR 					= $(PRE)ar
STRIP 				= $(PRE)strip
RANLIB 				= $(PRE)ranlib
LD 					= $(PRE)g++
AS					= yasm
RM 					= rm -f
RMDIR 				= rm -rf
CP 					= cp
CPDIR 				= cp -r
MKDIR 				= mkdir -p
MAKE 				= make
PWD 				= pwd

# cxflags: .c/.cc/.cpp files
CXFLAGS_RELEASE 	= -fomit-frame-pointer -freg-struct-return -fno-bounds-check -fvisibility=hidden
CXFLAGS_DEBUG 		= -g -D__tb_debug__
CXFLAGS 			= -c -Wall -D__tb_arch_$(ARCH)__
CXFLAGS-I 			= -I
CXFLAGS-o 			= -o

# arch
ifeq ($(ARCH),x86)
CXFLAGS 			+= -arch i386 -mssse3
endif

ifeq ($(ARCH),x64)
CXFLAGS 			+= -m64 -mssse3
endif

# opti
ifeq ($(SMALL),y)
CXFLAGS_RELEASE 	+= -Os
else
CXFLAGS_RELEASE 	+= -O3
endif

# small
CXFLAGS-$(SMALL) 	+= -D__tb_small__

# cflags: .c files
CFLAGS_RELEASE 		= 
CFLAGS_DEBUG 		= 
CFLAGS 				= \
					-std=c99 \
					-D_GNU_SOURCE=1 -D_REENTRANT \
					-fno-math-errno \
					-Wno-parentheses -Wstrict-prototypes \
					-Wno-switch -Wno-format-zero-length -Wdisabled-optimization \
					-Wpointer-arith -Wwrite-strings \
					-Wundef -Wmissing-prototypes  \
					-fno-tree-vectorize \
					-Werror=unused-variable -Wno-pointer-sign -Wno-pointer-to-int-cast \
					-Werror=implicit-function-declaration -Werror=missing-prototypes 

# ccflags: .cc/.cpp files
CCFLAGS_RELEASE 	= 
CCFLAGS_DEBUG 		= 
CCFLAGS 			= \
					-D_ISOC99_SOURCE -D_FILE_OFFSET_BITS=64 -D_LARGEFILE_SOURCE \
					-D_POSIX_C_SOURCE=200112 -D_XOPEN_SOURCE=600

# mxflags: .m/.mm files
MXFLAGS_RELEASE 	= \
					-O3 -DNDEBUG \
					-fomit-frame-pointer -freg-struct-return -fno-bounds-check \
					-fvisibility=hidden

MXFLAGS_DEBUG 		= -g -DDEBUG=1
MXFLAGS 			= -c -Wall -mssse3 $(ARCH_CXFLAGS) -D__tb_arch_$(ARCH)__ \
					-fmessage-length=0  -Wreturn-type -Wunused-variable \
					-pipe -Wno-trigraphs -fpascal-strings \
					"-DIBOutlet=__attribute__((iboutlet))" \
					"-DIBOutletCollection(ClassName)=__attribute__((iboutletcollection(ClassName)))" \
					"-DIBAction=void)__attribute__((ibaction)" 
MXFLAGS-I 			= -I
MXFLAGS-o 			= -o

# mflags: .m files
MFLAGS_RELEASE 		= 
MFLAGS_DEBUG 		= 
MFLAGS 				= -std=gnu99

# mmflags: .mm files
MMFLAGS_RELEASE 	= 
MMFLAGS_DEBUG 		=	 
MMFLAGS 			=

# ldflags
LDFLAGS_RELEASE 	= -static -s
LDFLAGS_DEBUG 		= -rdynamic -pg
LDFLAGS 			= 
LDFLAGS-L 			= -L
LDFLAGS-l 			= -l
LDFLAGS-o 			= -o

# arch
ifeq ($(ARCH),x86)
LDFLAGS 			+= -arch i386
endif

# asflags
ASFLAGS_RELEASE 	= Wa,-march=native
ASFLAGS_DEBUG 		= 
ASFLAGS 			= -f elf $(ARCH_ASFLAGS)
ASFLAGS-I 			= -I
ASFLAGS-o 			= -o

# arch
ifeq ($(ARCH),x86)
ASFLAGS 			+= -arch i386
endif

ifeq ($(ARCH),x64)
ASFLAGS 			+= -m amd64
endif

# arflags
ARFLAGS 			= -cr

# share ldflags
SHFLAGS 			= $(ARCH_LDFLAGS) -dynamiclib

# config
include 			$(PLAT_DIR)/config.mak


