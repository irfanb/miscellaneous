#ifndef __LOGSOURCE_H__
#define __LOGSOURCE_H__

class LogSink;

class LogSource
{
public:
    static LogSource& GetInstance();
    static void DestroyInstance();
    void addSink(LogSink* sink);

    LogSource& operator<< (const char* psz);
    LogSource& operator<< (const std::string& val);
    LogSource& operator<< (::ostream&(rhs)(::ostream&) );
    LogSource& operator<< (long rhs);

private:
    static LogSource* s_pLogSource;
    std::list<LogSink*> m_listSinks;
};

#endif // __LOGSOURCE_H__
