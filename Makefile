# gpSP makefile
# Gilead Kutnick - Exophase
# pandora port - notaz
# respberry pi - DPR
# powkiddy q90 - PhongPhan

# Global definitions

CC        = /opt/miyoo/bin/arm-linux-gcc

OBJS      = main.o cpu.o memory.o video.o input.o sound.o gui.o \
            cheats.o zip.o  arm_stub.o  warm.o cpu_threaded.o video_blend.o sha1.o imageio.o

BIN       = gpsp

# Platform specific definitions 

VPATH      += .. ../arm
CFLAGS     += -DARM_ARCH -DPC_BUILD -Wall
CFLAGS     += -Ofast -fdata-sections -ffunction-sections -flto -fno-PIC -fprofile-use
CFLAGS     += `/opt/miyoo/arm-miyoo-linux-uclibcgnueabi/sysroot/usr/bin/sdl-config --cflags`

# expecting to have PATH set up to get correct sdl-config first

LIBS       = -lc -lgcc -lSDL -lpng -lasound -lz -Wl,--as-needed -Wl,--gc-sections -flto -s

# Compilation:

all: $(BIN)

%.o: %.S
	$(CC) $(CFLAGS) -c -o $@ $<


cpu.o cpu_threaded.o: CFLAGS += -Wno-unused-variable -Wno-unused-label

$(BIN): $(OBJS)
	$(CC) $(OBJS) $(LIBS) -o $(BIN)

clean:
	rm -f *.o $(BIN)
