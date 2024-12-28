.PHONY: clean
OBJS_DIR := ./build
OUT_DIR := ./out
TEST_SOURCE_DIR := ./testsrc
SOURCE_DIR := ./src
INCLUDE_DIR := ./include
LIB_DIR := ./lib
LIB := $(LIB_DIR)/libcommands.so
TEST_EXEC := commandsTest
CXX := g++
CXXFLAGS := -std=c++17 # -g -fsanitize=address -fno-omit-frame-pointer
LINKFLAGS :=
TEST_CXXFLAGS := $(CXXFLAGS) -I$(INCLUDE_DIR)
TEST_LINKFLAGS := $(LINKFLAGS) -L$(LIB_DIR) -lcommands
SOURCE_FILES := $(wildcard $(SOURCE_DIR)/*.cpp)
SOURCE_HEADERS := $(wildcard $(SOURCE_DIR)/*.h)
INCLUDE_HEADERS := $(subst $(SOURCE_DIR),$(INCLUDE_DIR), $(SOURCE_HEADERS))
OBJS := $(subst $(SOURCE_DIR),$(OBJS_DIR), $(patsubst %.cpp,%.o,$(SOURCE_FILES)))
TEST_SOURCE_FILES := $(wildcard $(TEST_SOURCE_DIR)/*.cpp)
TEST_SOURCE_HEADERS := $(wildcard $(TEST_SOURCE_DIR)/*.h)
TEST_OBJS := $(subst $(TEST_SOURCE_DIR),$(OBJS_DIR), $(patsubst %.cpp,%.o,$(TEST_SOURCE_FILES)))
out ?= 
INSTALL_DIR = $(out)


lib:  $(LIB) $(INCLUDE_HEADERS)
test: $(TEST_EXEC)

install: lib
	install -D -m 755 $(LIB) $(INSTALL_DIR)/lib/libcommands.so
	install -D -m 644 $(INCLUDE_DIR)/* $(INSTALL_DIR)/include/

$(LIB): $(OBJS)
	$(CXX) $(OBJS) $(CXXFLAGS) $(LINKFLAGS) -shared -o $(LIB)

$(INCLUDE_DIR)/%.h : $(SOURCE_DIR)/%.h
	cp $< $@

$(OBJS_DIR)/%.o : $(SOURCE_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) -c -fPIC $< -o $@


$(TEST_EXEC): lib $(TEST_OBJS)
	$(CXX) $(TEST_OBJS) $(TEST_CXXFLAGS) $(TEST_LINKFLAGS) -o $(TEST_EXEC)

$(OBJS_DIR)/%.o : $(TEST_SOURCE_DIR)/%.cpp
	$(CXX) $(TEST_CXXFLAGS) -c $< -o $@


#Files to be compiled
$(OBJS_DIR)/commands.o: $(SOURCE_FILES) $(SOURCE_HEADERS)
$(OBJS_DIR)/util.o: $(SOURCE_DIR)/util.cpp $(SOURCE_DIR)/util.h
$(OBJS_DIR)/main.o: $(TEST_SOURCE_FILES) $(TEST_SOURCE_HEADERS)

clean:
	rm $(OBJS_DIR)/*.o || true
	rm $(INCLUDE_DIR)/*.h || true
	rm $(LIB) || true
	rm $(TEST_EXEC) || true
