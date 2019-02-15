# make指令默认会查找 GNUmakefile,makefile,Makefile 文件，优先级从左到右，建议用 Makefile
# 如果想手动指定，-f name 或者 --file=name

# make默认从第一个目标开始(除了.开头), 如果没有目标匹配但是有%，则匹配%.
# force: ;空规则可以阻止隐式规则

# 包含其他文件
# -I --include-dir=dir 指定多个默认搜索路径
include foo *.mk $(bar)
=
include foo a.mk b.mk c.mk bish bash
#如果以下文件夹存在也会搜索prefix/include (normally /usr/local/include 1) /usr/gnu/include, /usr/local/include, /usr/include
#如果设置了MAKEFILES环境变量，会先包含该变量包含的文件(空格隔开)

#一般调用子makefile,会用export来传递变量
export variable	= value
export variable	:= value
export variable += value


# 命令前缀 @ -
# 不用前缀，输出执行的命令和结果，出错停止
# 用前缀 @，只输出结果，出错停止
# 用前缀 -，输出执行的命令和结果，出错忽略


# = :=区别
# = make会将整个makefile展开后，再决定变量的值
x=foo
y=$(x) bar
x=xyz
all:
	@echo $(y)		#xyz bar

x=foo
y:=$(x) bar
x=xyz
all:
	@echo $(y)		#foo bar

#额外例子
find_files = $(wildcard $(dir)/*)
dirs := a b c d
files := $(foreach dir,$(dirs),$(find_files))




#变量替换
x = d.c e.c f.c
y = $(SRCS:%.c=%.o)

#变量追加 +=
x = 1 2 3
x += 4

#替换命令行指定的变量值
override src=d.c e.c f.c


#二次扩张(secondary expansion)
#其实就是延后执行并转义$
.SECONDEXPANSION:
AVAR = top
onefile: $(AVAR)
twofile: $$(AVAR)		#延后执行，所以为 bottom
AVAR = bottom




#先切换到src目录再执行makefile
make -C src
cd src && make

#命令行指定变量
make src=/usr/local

#强制重编译
make -B


#内置变量
RM=rm -f
AR=ar
CC=cc
CXX=g++

ARFLAGS		AR命令的参数
CFLAGS		C语言编译器的参数
CXXFLAGS	C++语言编译器的参数

$@			目标


# 定义多行变量
define multiline =
@echo -n "Hello"
@echo " Makefile!"
endef
all:
	$(multiline)


#条件判断 ifeq,ifneq,ifdef ifndef

all:
ifeq (1,2)
	@echo "yes"
else
	@echo "no"
endif

ifdef src
	@echo $(src)
else
	@echo "no"
endif


#函数
# 字符串替换
$(subst "t","e","maktfilt")		#makefile

# 模式字符串替换
$(patsubst %.c,%.o,A.c B.c)		#A.o B.o


# 开头和结尾一个或多个空格替换为1个空格
val = "    11 22 33   "
$(strip $(val))				# " 11 22 33 "

# 字符串查找，找到返回a，找不到返回空
$(findstring a,a b c)


#字符串过滤
sources := foo.c bar.c baz.s ugh.h
all:
	@echo $(filter %.c %.s,$(sources))		# foo.c bar.c baz.s

#字符串反过滤
sources := foo.c bar.c baz.s ugh.h
all:
	@echo $(filter-out %.c %.s,$(sources))		# ugh.h

#排序去重
$(sort foo bar lose)
#返回第n个单词
$(word 2, foo bar baz)			#bar
$(wordlist 2, 3, foo bar baz)	#bar baz

#返回单词个数， 那么最后一个单词即 $(word $(words text),text)
$(words text)
#返回第一个单词
$(firstword foo bar)
#返回最后一个单词
$(lastword foo bar)


#目录操作
all:
	@echo $(dir src/foo.c hacks)
	@echo $(notdir src/foo.c hacks)
	@echo $(suffix src/foo.c src-1.0/bar.c hacks)
	@echo $(basename src/foo.c src-1.0/bar hacks)
	@echo $(addsuffix .c,foo bar)
	@echo $(addprefix src/,foo bar)

src/ ./
foo.c hacks
.c .c
src/foo src-1.0/bar hacks
foo.c bar.c
src/foo src/bar


#join函数
all:
    @echo $(join a b c d,1 2 3 4)
    @echo $(join a b c d,1 2 3 4 5)
    @echo $(join a b c d e,1 2 3 4)
a1 b2 c3 d4
a1 b2 c3 d4 5
a1 b2 c3 d4 e

#foreach函数
targets := a b c d
objects := $(foreach i,$(targets),$(i).o)

all:
    @echo $(targets)
    @echo $(objects)

a b c d
a.o b.o c.o d.o


#if函数
val := a
objects := $(if $(val),$(val).o,nothing)
no-objects := $(if $(no-val),$(val).o,nothing)

all:
    @echo $(objects)
    @echo $(no-objects)

a.o
nothing


#call函数
$(call <expression>,<parm1>,<parm2>,<parm3>...)
log = "====debug====" $(1) "====end===="

all:
    @echo $(call log,"正在 Make")

"====debug==== 正在 Make ====end===="

#origin函数
$(origin <variable>)

undefined		<variable> 没有定义过
default			<variable> 是个默认的定义, 比如 CC 变量
environment		<variable> 是个环境变量, 并且 make时没有使用 -e 参数
file			<variable> 定义在Makefile中
command line	<variable> 定义在命令行中
override		<variable> 被 override 重新定义过
automatic		<variable> 是自动化变量

#shell函数
contents := $(shell cat foo)

#error函数
all:
    $(error there is an error!)
    @echo "这里不会执行!"

Makefile:2: *** there is an error!.  Stop.

#warning函数
all:
    $(warning there is an warning!)
    @echo "这里会执行!"

Makefile:2: there is an warning!
这里会执行!




#约定
all		所有目标的目标，其功能一般是编译所有的目标
clean	删除所有被make创建的文件
install	安装已编译好的程序，其实就是把目标可执行文件拷贝到指定的目录中去
print	列出改变过的源文件
tar		把源程序打包备份. 也就是一个tar文件
dist	创建一个压缩文件, 一般是把tar文件压成Z文件. 或是gz文件
TAGS	更新所有的目标, 以备完整地重编译使用
check 或 test	一般用来测试makefile的流程







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



