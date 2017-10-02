#include <pthread.h>
#include <stdio.h>
#include <unistd.h>
#include "mutex.h"

Mutex::Mutex()
{
    pthread_mutex_init(&m_Mutex, NULL);
}

void Mutex::lock()
{
    pthread_mutex_lock(&m_Mutex);
}

void Mutex::unlock()
{
    pthread_mutex_unlock(&m_Mutex);
}


static char const rcsid[] = "$Id: mutex.cpp,v 1.1 2001/09/30 22:36:23 irfan Exp $";

/***************************************************************************
 *
 * $Log: mutex.cpp,v $
 * Revision 1.1  2001/09/30 22:36:23  irfan
 * half sensible 1st cut
 *
 *
 ***************************************************************************/

