.PHONY: all tools push clean commit
.SECONDARY: tools/.sentinel

all:   tools
push:  tools
	docker push     innovanon/lfs-$<
tools: sources/.sentinel
	docker build -t innovanon/lfs-$@ $(TEST) .
commit:
	git add .
	git commit -m '[Makefile] commit' || :
	git pull
	git push

sources/.sentinel: $(shell find sources -type f) # Makefile
	touch $@
	#openssl rand -out $@ $(shell echo '2 ^ 10' | bc )

clean:
	rm -vf stage-*.$(EXT) */.sentinel .sentinel

