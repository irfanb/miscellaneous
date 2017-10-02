#include <stdlib.h>
#include <list>
#include <string>
#include <iostream>
#include <fstream>

#include "logsource.h"
#include "logsink.h"

LogSource* LogSource::s_pLogSource = NULL;

LogSource& LogSource::GetInstance()
{
   if (s_pLogSource == NULL)
   {
      s_pLogSource = new LogSource();
   }
   return *s_pLogSource;
}

void LogSource::DestroyInstance()
{
   if (s_pLogSource != NULL)
   {
      delete s_pLogSource;
      s_pLogSource = NULL;
   }
}

void LogSource::addSink(LogSink* pSink)
{
   m_listSinks.push_back(pSink);
}

LogSource& LogSource::operator<< (const char* psz)
{
   std::list<LogSink*>::iterator i = m_listSinks.begin();

   while (i != m_listSinks.end())
   {
      LogSink* pSink = (*i);
      *pSink << psz;
      i++;
   }
   return *this;
}

LogSource& LogSource::operator<< (const std::string& val)
{
   std::list<LogSink*>::iterator i = m_listSinks.begin();

   while (i != m_listSinks.end())
   {
      LogSink* pSink = (*i);
      *pSink << val;
      i++;
   }
   return *this;
}

LogSource& LogSource::operator<< (std::ostream&(rhs)(std::ostream&) )
{
   std::list<LogSink*>::iterator i = m_listSinks.begin();

   while (i != m_listSinks.end())
   {
      LogSink* pSink = (*i);
      *pSink << rhs;
      i++;
   }
   return *this;
}

LogSource& LogSource::operator<< (long rhs)
{
   std::list<LogSink*>::iterator i = m_listSinks.begin();

   while (i != m_listSinks.end())
   {
      LogSink* pSink = (*i);
      *pSink << rhs;
      i++;
   }
   return *this;
}

