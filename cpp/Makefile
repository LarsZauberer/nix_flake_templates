CXX := g++
CXXFLAGS := -O3 -Wall -std=c++17 -Iinclude
LDFLAGS := 
LIBS := -lgtest -lgtest_main -lgmock -lgmock_main -pthread

# Directories
SRC_DIR := src
INCLUDE_DIR := include
TEST_DIR := tests
BUILD_DIR := build
LIB_DIR := lib
BIN_DIR := bin

# Source files
SOURCES := $(wildcard $(SRC_DIR)/*.cpp)
TEST_SOURCES := $(wildcard $(TEST_DIR)/*.cpp)
OBJECTS := $(SOURCES:$(SRC_DIR)/%.cpp=$(BUILD_DIR)/%.o)
TEST_OBJECTS := $(TEST_SOURCES:$(TEST_DIR)/%.cpp=$(BUILD_DIR)/test_%.o)

# Library name
LIB_NAME := mylib
STATIC_LIB := $(LIB_DIR)/lib$(LIB_NAME).a
SHARED_LIB := $(LIB_DIR)/lib$(LIB_NAME).so

# Executables
MAIN_EXEC_NAME := main
MAIN_EXEC := $(BIN_DIR)/$(MAIN_EXEC_NAME)
TEST_EXEC := $(BIN_DIR)/tests

.PHONY: all clean executable static shared test run run-tests

all: executable static shared test

executable: $(MAIN_EXEC)

static: $(STATIC_LIB)

shared: $(SHARED_LIB)

test: $(TEST_EXEC)

clean:
	rm -rf $(BUILD_DIR)/*
	rm -rf $(LIB_DIR)/*
	rm -rf $(BIN_DIR)/*

run: $(MAIN_EXEC)
	$(MAIN_EXEC)

run-tests: $(TEST_EXEC)
	$(TEST_EXEC)

# Create directories
$(BUILD_DIR) $(LIB_DIR) $(BIN_DIR):
	mkdir -p $@

# Executable target
$(MAIN_EXEC): $(OBJECTS) | $(BIN_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $^ $(LDFLAGS) $(LIBS)

# Static library target
$(STATIC_LIB): $(OBJECTS) | $(LIB_DIR)
	ar rcs $@ $^

# Shared library target
$(SHARED_LIB): $(OBJECTS) | $(LIB_DIR)
	$(CXX) $(CXXFLAGS) -shared -fPIC -o $@ $^ $(LDFLAGS)

# Test executable target
$(TEST_EXEC): $(TEST_OBJECTS) $(STATIC_LIB) | $(BIN_DIR)
	$(CXX) $(CXXFLAGS) -o $@ $(TEST_OBJECTS) -L$(LIB_DIR) -l$(LIB_NAME) $(LIBS)

# Object files for source
$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -fPIC -c -o $@ $<

# Object files for tests
$(BUILD_DIR)/test_%.o: $(TEST_DIR)/%.cpp | $(BUILD_DIR)
	$(CXX) $(CXXFLAGS) -c -o $@ $<

# Help target
help:
	@echo "Available targets:"
	@echo "  all         - Build executable, static library, shared library, and tests"
	@echo "  executable  - Build main executable"
	@echo "  static      - Build static library"
	@echo "  shared      - Build shared library"
	@echo "  test        - Build test executable"
	@echo "  run         - Run main executable"
	@echo "  run-tests   - Run tests"
	@echo "  clean       - Clean build artifacts"
	@echo "  help        - Show this help message"