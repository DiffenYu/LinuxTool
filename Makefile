CC = gcc
XX = g++
CFLAGS = -Wall -O -g
LDFLAGS = 

TARGET = test

CFLAGS += `pkg-config --cflags gstreamer-1.0`
LDFLAGS += `pkg-config --libs gstreamer-1.0`

%.o:%.c
	$(CC) $(CFLAGS) -c $< -o $@ 
%.o:%.cpp
	$(xx) $(CFLAGS) -c $< -o $@ 
 
SOURCES = $(wildcard *.c *.cpp)
OBJS = $(patsubst %.c,%.o,$(patsubst %.cpp,%.o,$(SOURCES)))

$(TARGET):$(OBJS) 
	$(CC) $(OBJS) -o $(TARGET) $(LDFLAGS)
	chmod a+x $(TARGET) 

clean:
	rm $(OBJS) $(TARGET)
