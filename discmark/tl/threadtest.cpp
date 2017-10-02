#include <pthread.h>
#include <stdlib.h>
#include <stdio.h>
//#include <iostream>
#include <unistd.h>
#include <string>

using namespace std;

#include "thread.h"
#include "mutexlock.h"
#include "mutex.h"

Mutex globalMutex;

class MyThread : public Thread
{
public:
    MyThread(int i) { m_iThreadId = i; }
    void run()
    {
        int i=0;
        while (i < 50)
        {
            {
            Thread& mt = Thread::CurrentThread();
            MutexLock lock(globalMutex);
            printf("my thread %d %ld is running %s\n", m_iThreadId,
                  mt.getId(), mt.getName().c_str());
            }
            
            double thing;
            if (m_iThreadId < 25)
                thing = 1000.0;
            else
                thing = 10.0;
            long l = 1 + (long) (thing*rand()/(RAND_MAX+1.0));
            usleep(l);
            //cout << "iter " << i << " thread " << m_iThreadId << endl;
            printf("iter %d, thread %d\n", i, m_iThreadId);
            i++;
        }
        printf("my thread %d is dying\n", m_iThreadId);
    }
private:
    int m_iThreadId;
};

int main(int argc, char* argv[])
{
    int i;
#define NUMTHREADS 50
    MyThread* pThread[NUMTHREADS];
    Thread::Initialise();

    for (i = 0; i < NUMTHREADS; i++)
    {
       char szThreadName[256];

       sprintf(szThreadName, "thread%d", i);
        string threadName = szThreadName;
        pThread[i] = new MyThread(i);
        pThread[i]->setName(threadName);
        pThread[i]->create();
    }
    for (i = 0; i < NUMTHREADS; i++)
    {
        pThread[i]->join();
        delete pThread[i];
    }
    return 0;
}

static char const rcsid[] = "$Id: threadtest.cpp,v 1.2 2001/09/30 22:54:31 irfan Exp $";

/***************************************************************************
 *
 * $Log: threadtest.cpp,v $
 * Revision 1.2  2001/09/30 22:54:31  irfan
 * now using getName setName
 *
 * Revision 1.1  2001/09/30 22:36:23  irfan
 * half sensible 1st cut
 *
 *
 ***************************************************************************/

