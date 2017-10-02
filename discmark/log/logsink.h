#ifndef __LOGSINK_H__
#define __LOGSINK_H__

class LogSink
{
public:
    virtual LogSink& operator<< (const char* psz) = 0;
    virtual LogSink& operator<< (const std::string& val) = 0;
    virtual LogSink& operator<< (std::ostream&(rhs)(std::ostream&) ) = 0;
    virtual LogSink& operator<< (long rhs) = 0;
private:
};

class FileLog : public LogSink
{
public:
    FileLog(const char* pszFilename);
    LogSink& operator<< (const char* rhs);
    LogSink& operator<< (const std::string& rhs);
    LogSink& operator<< (std::ostream&(rhs)(std::ostream&));
    LogSink& operator<< (long rhs);
    virtual ~FileLog() {};
private:
    std::string m_Filename;
};

#endif // __LOGSINK_H__
