#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include "mutex.h"
#include "mutexlock.h"

MutexLock::MutexLock(Mutex& mutex) : m_Mutex(mutex)
{
    m_Mutex.lock();
}

MutexLock::~MutexLock()
{
    m_Mutex.unlock();
}

static char const rcsid[] = "$Id: mutexlock.cpp,v 1.1 2001/09/30 22:36:23 irfan Exp $";

/***************************************************************************
 *
 * $Log: mutexlock.cpp,v $
 * Revision 1.1  2001/09/30 22:36:23  irfan
 * half sensible 1st cut
 *
 *
 ***************************************************************************/

