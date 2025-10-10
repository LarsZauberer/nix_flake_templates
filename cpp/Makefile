CXX := g++
CXXFLAGS := -O3 -Wall

LIBS := -lgtest -lgtest_main -lgmock -lgmock_main -pthread

BUILD_DIR := ./build
SRC_DIR := .

all: $(BUILD_DIR)/main $(BUILD_DIR)/tests

clean:
	rm $(BUILD_DIR)/*.o
	rm $(BUILD_DIR)/main
	rm $(BUILD_DIR)/tests

run: $(BUILD_DIR)/main
	$(BUILD_DIR)/main

test: $(BUILD_DIR)/tests
	$(BUILD_DIR)/tests

$(BUILD_DIR)/main: $(BUILD_DIR)/main.o
	$(CXX) $(CXXFLAGS) $(LIBS) -o $@ $<

$(BUILD_DIR)/tests: $(BUILD_DIR)/tests.o
	$(CXX) $(CXXFLAGS) $(LIBS) -o $@ $<

$(BUILD_DIR)/%.o: $(SRC_DIR)/%.cpp
	$(CXX) $(CXXFLAGS) $(LIBS) -c -o $@ $<

