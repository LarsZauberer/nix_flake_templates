CXX := g++
CXXFLAGS := -O3 -Wall

LIBS := -lgtest -lgtest_main -lgmock -lgmock_main -pthread

all: $(BUILD_DIR)/main $(BUILD_DIR)/tests

clean:
	rm $(BUILD_DIR)/*.o
	rm $(BUILD_DIR)/main
	rm $(BUILD_DIR)/tests

$(BUILD_DIR)/main: $(BUILD_DIR)/main.o
	$(CXX) $(CXXFLAGS) $(LIBS) -o $(BUILD_DIR)/main $(BUILD_DIR)/main.o

$(BUILD_DIR)/tests: $(BUILD_DIR)/tests.o
	$(CXX) $(CXXFLAGS) $(LIBS) -o $(BUILD_DIR)/tests $(BUILD_DIR)/tests.o

$(BUILD_DIR)/main.o: main.cpp
	$(CXX) $(CXXFLAGS) $(LIBS) -c -o $(BUILD_DIR)/main.o main.cpp

$(BUILD_DIR)/tests.o: tests.cpp
	$(CXX) $(CXXFLAGS) $(LIBS) -c -o $(BUILD_DIR)/tests.o tests.cpp

