#make指令默认会查找 GNUmakefile,makefile,Makefile 文件，优先级从左到右，建议用 Makefile
#如果想手动指定，-f name 或者 --file=name

#包含其他文件
#-I --include-dir=dir 指定多个默认搜索路径
include foo *.mk $(bar)
=
include foo a.mk b.mk c.mk bish bash



target: prerequisites
	recipe


#example-1
edit: main.o tmp.o
	cc main.o tmp.o -o main

main.o: main.c main.h
	cc -c main.c
tmp.o: tmp.c tmp.h
	cc -c tmp.c
clean:
	rm main main.o tmp.o

#example-2
objs = main.o tmp.o

edit: $(objs)
	cc -o main $(objs)
main.o: main.c main.h
	cc -c main.c
tmp.o: tmp.c tmp.h
	cc -c tmp.c

#example-3
#let make deduce the recipes
objs = main.o tmp.o

edit: $(objs)
	cc -o main $(objs)
main.o: main.h
tmp.o: tmp.h

.PHONY : clean
clean :
    rm main $(objs)

#example-4
objects = main.o kbd.o command.o display.o \
          insert.o search.o files.o utils.o

edit : $(objects)
        cc -o edit $(objects)

$(objects) : defs.h
kbd.o command.o files.o : command.h
display.o insert.o search.o files.o : buffer.h



