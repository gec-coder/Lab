#include <iostream>
#include <vector>
#include <set>
#include <map>
#include <string>
using namespace std;

// Structure to store productions
struct Production {
    char nonTerminal;
    string rhs;
};

// Function to check if a character is a non-terminal (uppercase letter)
bool isNonTerminal(char c) {
    return (c >= 'A' && c <= 'Z');
}

// Function to compute First set for a symbol
void computeFirst(char symbol, map<char, set<char>>& first, vector<Production>& productions, set<char>& visited) {
    if (visited.find(symbol) != visited.end()) return; // Avoid recursion loops
    visited.insert(symbol);

    for (const auto& prod : productions) {
        if (prod.nonTerminal == symbol) {
            string rhs = prod.rhs;
            if (rhs == "#") { // Epsilon production
                first[symbol].insert('#');
            } else {
                for (size_t i = 0; i < rhs.length(); i++) {
                    char current = rhs[i];
                    if (!isNonTerminal(current)) { // Terminal
                        first[symbol].insert(current);
                        break;
                    } else { // Non-terminal
                        computeFirst(current, first, productions, visited);
                        for (char f : first[current]) {
                            if (f != '#') first[symbol].insert(f);
                        }
                        if (first[current].find('#') == first[current].end()) break; // No epsilon in First(current)
                        if (i == rhs.length() - 1) first[symbol].insert('#'); // All symbols derive epsilon
                    }
                }
            }
        }
    }
}

// Function to compute Follow set for a non-terminal
void computeFollow(char symbol, map<char, set<char>>& first, map<char, set<char>>& follow, vector<Production>& productions, set<char>& visited, char startSymbol) {
    if (visited.find(symbol) != visited.end()) return; // Avoid recursion loops
    visited.insert(symbol);

    // Add $ to Follow of start symbol
    if (symbol == startSymbol) follow[symbol].insert('$');

    for (const auto& prod : productions) {
        string rhs = prod.rhs;
        for (size_t i = 0; i < rhs.length(); i++) {
            if (rhs[i] == symbol) {
                // Case 1: Find First of the string after symbol
                bool allEpsilon = true;
                for (size_t j = i + 1; j < rhs.length() && allEpsilon; j++) {
                    char next = rhs[j];
                    if (!isNonTerminal(next)) { // Terminal
                        follow[symbol].insert(next);
                        allEpsilon = false;
                    } else { // Non-terminal
                        for (char f : first[next]) {
                            if (f != '#') follow[symbol].insert(f);
                        }
                        if (first[next].find('#') == first[next].end()) allEpsilon = false;
                    }
                }
                // Case 2: If epsilon in First of remaining string or nothing follows, add Follow of LHS
                if (allEpsilon && prod.nonTerminal != symbol) {
                    computeFollow(prod.nonTerminal, first, follow, productions, visited, startSymbol);
                    for (char f : follow[prod.nonTerminal]) {
                        follow[symbol].insert(f);
                    }
                }
            }
        }
    }
}

int main() {
    int n;
    vector<Production> productions;
    map<char, set<char>> first, follow;
    set<char> nonTerminals;

    // Input grammar
    cout << "Enter the number of productions: ";
    cin >> n;
    cout << "Enter the productions (e.g., A->aB, use # for epsilon):" << endl;
    for (int i = 0; i < n; i++) {
        string prod;
        cin >> prod;
        if (prod.length() < 4 || prod[1] != '-' || prod[2] != '>') {
            cout << "Invalid production format. Use A->α" << endl;
            return 1;
        }
        Production p;
        p.nonTerminal = prod[0];
        p.rhs = prod.substr(3);
        productions.push_back(p);
        nonTerminals.insert(p.nonTerminal);
    }

    char startSymbol = productions[0].nonTerminal; // Assume first non-terminal is start symbol

    // Compute First sets
    for (char nt : nonTerminals) {
        set<char> visited;
        computeFirst(nt, first, productions, visited);
    }

    // Compute Follow sets
    for (char nt : nonTerminals) {
        set<char> visited;
        computeFollow(nt, first, follow, productions, visited, startSymbol);
    }

    // Display First sets
    cout << "\nFirst Sets:" << endl;
    for (char nt : nonTerminals) {
        cout << "First(" << nt << ") = { ";
        for (char f : first[nt]) {
            cout << f << " ";
        }
        cout << "}" << endl;
    }

    // Display Follow sets
    cout << "\nFollow Sets:" << endl;
    for (char nt : nonTerminals) {
        cout << "Follow(" << nt << ") = { ";
        for (char f : follow[nt]) {
            cout << f << " ";
        }
        cout << "}" << endl;
    }

    return 0;
}
