class Mutex;

class MutexLock
{
public:
    MutexLock(Mutex& mutex);
    ~MutexLock();
private:
    MutexLock();
    Mutex& m_Mutex;
};

/***************************************************************************
 *
 * $Log: mutexlock.h,v $
 * Revision 1.2  2001/09/30 22:44:08  irfan
 * removed the rcsid's because they were interfering with those in the cpp
 * files
 *
 * Revision 1.1  2001/09/30 22:37:39  irfan
 * half sensible 1st stab
 *
 *
 ***************************************************************************/

