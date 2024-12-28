#include "util.h"

#include <sstream>
#include <algorithm>

using std::string;

std::vector<string> split (const string &s, char delim) {
	std::vector<string> result;
	std::stringstream ss (s);
    string item;

    while (getline (ss, item, delim)) {
        result.push_back (item);
    }

    return result;
}

string lowercase(string s)
{
    string s2 = s;
    std::transform(s2.begin(), s2.end(), s2.begin(), [](unsigned char c){ return std::tolower(c); });
    return s2;
}
