class Thread
{
public:
    void create(void);
    virtual void run() = 0;
    void join(void);
    static Thread& CurrentThread();
    const std::string& getName() const;
    void setName(const std::string& strName);
    static void Initialise();
    long getId() { return (long) this; }
    virtual ~Thread() {};

protected:
    static void* ThreadFunction(void *pThreadObject);
private:
    pthread_t m_ThreadHandle;
    string m_ThreadName;
    static pthread_key_t s_ThreadKey;
};

/***************************************************************************
 *
 * $Log: thread.h,v $
 * Revision 1.5  2002/04/01 13:30:01  irfan
 * added std namespace qualifier for msvc
 *
 * Revision 1.4  2001/11/19 21:35:46  irfan
 * whitespace change
 *
 * Revision 1.3  2001/11/03 16:56:30  irfan
 * added a virtual destructor
 *
 * Revision 1.2  2001/09/30 22:44:08  irfan
 * removed the rcsid's because they were interfering with those in the cpp
 * files
 *
 * Revision 1.1  2001/09/30 22:37:39  irfan
 * half sensible 1st stab
 *
 *
 ***************************************************************************/

