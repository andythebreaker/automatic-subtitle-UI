#include <iostream>
#include <fstream>
#include <string>

int main(int argc, char* argv[]) {
    if (argc < 2) {
        std::cerr << "Usage: " << argv[0] << " <srt_file>" << std::endl;
        return 1;
    }
    
    // Open input file
    std::ifstream infile(argv[1]);
    if (!infile.is_open()) {
        std::cerr << "Error: could not open file " << argv[1] << std::endl;
        return 1;
    }

    std::string line;
    while (std::getline(infile, line)) {
        // Add newline character every 36 characters
        for (int i = 36; i < line.size(); i += 36) {
            line.insert(i, "\\n");
            i++; // skip the newly inserted newline character
        }
        const char* fo = line.c_str();
        printf("%s\n", fo);
    }

    // Close files
    infile.close();

    return 0;
}
