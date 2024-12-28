#include "commands.h"

#include <iostream>

using std::cout, std::endl;

int main()
{
	CommandsModule commands;

	try
	{
		commands.runCommand("loadFile ./file1");
	}
	catch (Err e)
	{
		cout << "ERROR: " << e.code << " - " << e.message << endl;
	}
}
