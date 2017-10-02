#include <stdio.h>
#include <iostream>
#include <fstream>
#include <string>
#ifdef WIN32
#include <streamb.h>
#else
#include <streambuf>
#endif

using namespace std;

#include "logsink.h"
/*
LogSink& LogSink::operator<< (const char* psz)
{
   cout << psz << endl;
   return *this;
}
*/

FileLog::FileLog(const char* pszFilename)
{
   m_Filename = pszFilename;
}

LogSink& FileLog::operator<< (const char* rhs)
{
   //cout << psz << endl;
   std::ofstream outFile(m_Filename.c_str(), ios::app|ios::binary);
   outFile << rhs;

   return *this;
}

LogSink& FileLog::operator<< (const std::string& rhs)
{
    return *this << rhs.c_str();
}

LogSink& FileLog::operator<< (long rhs)
{
    ::ofstream outFile(m_Filename.c_str(), ios::app|ios::binary);
    outFile << rhs;
    return *this;
}

LogSink& FileLog::operator<< (std::ostream&(rhs)(::ostream&))
{
    std::ofstream outFile(m_Filename.c_str(), ios::app|ios::binary);
   outFile << rhs;

   return *this;
}
