#include <iostream>
#include <fstream>
#include <cstdlib>

using namespace std;

int main() {
    // Step 1: Download GoogleTranslate.py using wget
    system("wget https://raw.githubusercontent.com/Coolshanlan/HighlightTranslator/master/GoogleTranslate.py");

    // Step 2: Replace "import pyuseragents" with "import pyuseragents\nimport sys"
    string filename = "GoogleTranslate.py";
    ifstream fin(filename);
    string content((istreambuf_iterator<char>(fin)), (istreambuf_iterator<char>()));
    fin.close();
    size_t pos = content.find("import pyuseragents");
    if (pos != string::npos) {
        content.replace(pos, 20, "import pyuseragents\nimport sys\n");
    }
    ofstream fout(filename);
    fout << content;
    fout.close();

    // Step 3: Replace the print statements with command line arguments
    string search_str = "#print(get_translate(\"And say mean things\", \"en\",\"zh-TW\"))\n    print(get_translate(\"insert\", \"en\",\"zh-TW\"))";
    string replace_str = "if len(sys.argv) < 2:\n        print(\"Please provide a string to translate as the first argument.\")\n        exit()\n    A = sys.argv[1]\n    print(get_translate(A, \"en\",\"zh-TW\"))#en->zh-TW\n";
    pos = content.find(search_str);
    if (pos != string::npos) {
        content.replace(pos, search_str.length(), replace_str);
    }
    fout.open(filename);
    fout << content;
    fout.close();

    return 0;
}
