#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include <string>

using namespace std;

#include "thread.h"

pthread_key_t Thread::s_ThreadKey;

void Thread::Initialise()
{
   pthread_key_create(&s_ThreadKey, NULL);
}

void* Thread::ThreadFunction(void *pThreadObject)
{
    Thread* pThread = reinterpret_cast<Thread*>(pThreadObject);
    pthread_setspecific(s_ThreadKey, pThread);
    pThread->run();
}
void Thread::create(void)
{
    pthread_create(&m_ThreadHandle, NULL, Thread::ThreadFunction,
        (void*) this);
}

void Thread::join(void)
{
    pthread_join(m_ThreadHandle, NULL);
}

Thread& Thread::CurrentThread()
{
   Thread* pThread = NULL;

   pThread = reinterpret_cast<Thread*>(pthread_getspecific(s_ThreadKey));
   return *pThread;
}

const string& Thread::getName() const
{
   return m_ThreadName;
}

void Thread::setName(const string& strName)
{
   m_ThreadName = strName;
}

static char const rcsid[] = "$Id: thread.cpp,v 1.1 2001/09/30 22:36:23 irfan Exp $";

/***************************************************************************
 *
 * $Log: thread.cpp,v $
 * Revision 1.1  2001/09/30 22:36:23  irfan
 * half sensible 1st cut
 *
 *
 ***************************************************************************/

