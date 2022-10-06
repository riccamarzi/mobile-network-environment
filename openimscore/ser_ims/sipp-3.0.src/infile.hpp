/*

 *  This program is free software; you can redistribute it and/or modify
 *  it under the terms of the GNU General Public License as published by
 *  the Free Software Foundation; either version 2 of the License, or
 *  (at your option) any later version.
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *  GNU General Public License for more details.
 *
 *  You should have received a copy of the GNU General Public License
 *  along with this program; if not, write to the Free Software
 *  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307, USA
 *
 *  Author : Richard GAYRAUD - 04 Nov 2003
 *           From Hewlett Packard Company.
 *	     Charles P. Wright from IBM Research
 */

#ifndef __FILECONTENTS__
#define __FILECONTENTS__

#include <vector>

class FileContents {
public:
  FileContents(const char *file);
  int getLine(int line, char *dest, int len);
  int getField(int line, int field, char *dest, int len);
  int numLines();
  int nextLine(int userId);
  void dump();
private:
  typedef enum {
    InputFileSequentialOrder = 0,
    InputFileRandomOrder,
    InputFileUser
  } InputFileUsage;
  int usage;
  int lineCounter;

  std::vector<std::string> fileLines;
  const char *fileName;
  int numLinesInFile;
};

#endif
