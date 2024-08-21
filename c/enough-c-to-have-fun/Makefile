CC = clang
DBG = lldb

build-main: build-dir
	$(CC) -Wall -O0 -g -o build/main src/main.c

check:
	@which $(CC) > /dev/null && echo "Success: $(CC) is installed" || echo "Error: $(CC) not found"
	@which $(DBG) > /dev/null && echo "Success: $(DBG) is installed" || echo "Error: $(DBG) not found"

build-dir:
	if [ ! -d build ]; then mkdir build; fi

build-test: build-dir
	$(CC) -Wall -O0 -g -o build/test src/test.c

run: build-main
	./build/main

test: build-test
	./build/test

debug: build-main
	$(DBG) ./build/main

debug-test: build-test
	$(DBG) ./build/test
