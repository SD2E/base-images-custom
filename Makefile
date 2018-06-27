PROJECTS = reactors-python2-miniconda-probcomp reactors-python3-sbh_adapter

TESTS = $(addsuffix '-test', $(PROJECTS))

.PHONY: clean tests $(PROJECTS)
.SILENT: tests clean $(PROJECTS)

all: $(PROJECTS)

$(PROJECTS):
	cd $@ ; \
	make

tests:
	for i in $(PROJECTS); do \
		cd $$i; \
		make tests; \
		cd ../; \
	done

deploy:
	for i in $(PROJECTS); do \
		cd $$i; \
		make deploy; \
		cd ../; \
	done

clean:
	for i in $(PROJECTS); do \
		cd $$i; \
		make clean; \
		cd ../; \
	done

