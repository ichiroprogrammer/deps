MAKEFILE:=$(word $(words $(MAKEFILE_LIST)), $(MAKEFILE_LIST))

TARGET:=o/dependency_generator.md
TITLE=Dependency generator(Deps/$(VERSION))

#MD_SEC_NUM:=--sec_num

MD_GEN:=./md_gen/export/py

VPATH=./md:deep/md/

MDS:=deps.md  appendix.md

INDEX_OPT:=--exclude $(addsuffix :1,$(MDS) sample_code.md)

include deep/make/md.mk
