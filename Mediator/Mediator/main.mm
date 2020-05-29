/*
 设计模式总体原则 - 开闭原则：对开展开放，对修改关闭，在拓展的时候，不能去修改原有的代码，而是拓展原有的代码，实现一个
 热插拔的效果，要达到这样的效果，需要使用接口和抽象类
 */
#import <Foundation/Foundation.h>
#import <list>
#import <iostream>
#import <pthread.h>
#define kReportService  "kReportService"
#define kLoggerService  "kLoggerService"

template<typename T>
class Singleton{
protected:
    Singleton(){
    }
    virtual ~Singleton(){
    }
protected:
    static T* m_pInstance;
    static pthread_mutex_t m_mutex;
public:
    static T* GetInstance(){
        if (NULL == m_pInstance) {
            pthread_mutex_lock(&m_mutex);
            if (NULL == m_pInstance) {
                m_pInstance = new T();
            }
            pthread_mutex_unlock(&m_mutex);
        }
        return m_pInstance;
    }
};
template<typename T> T*Singleton<T>::m_pInstance = NULL;
template<typename T> pthread_mutex_t Singleton<T>::m_mutex = PTHREAD_MUTEX_INITIALIZER;

class IPluginService;
class MediatorPlugin;

class IPlugin{
protected:
    MediatorPlugin* m_pMediatorPlugin;
public:
    virtual ~IPlugin(){
    }
    virtual const char* GetName() const = 0;
    virtual IPluginService* GetServiceByName(const char* serviceName) = 0;
    virtual MediatorPlugin* GetPuginManager() = 0;
    virtual void RegisterPlugin(IPlugin* plugin) = 0;
public:
    
};

//插件管理中心
class MediatorPlugin:public Singleton<MediatorPlugin>{
private:
    std::list<IPlugin*> list;
public:
    
    void Install(IPlugin* plugin){
        if (!plugin) {
            return;
        }
        std::list<IPlugin*>::iterator iter = std::find(list.begin(), list.end(), plugin);
        if (iter == list.end()) {
            list.push_back(plugin);
        }
    }
    
    void Uninstall(IPlugin* plugin){
        if (!plugin) {
            return;
        }
        std::list<IPlugin*>::iterator iter = std::find(list.begin(), list.end(), plugin);
        if (iter != list.end()) {
            list.erase(iter);
        }
    }
    
    IPlugin* GetPluginByName(const char* pluginName){
        if (!pluginName) {
            return NULL;
        }
        
        for (std::list<IPlugin*>::iterator iter = list.begin(); iter != list.end(); ++iter) {
            IPlugin* plugin = (IPlugin*)*iter;
            if(strcmp(pluginName, plugin -> GetName()) == 0){
                return plugin;
            }
        }
    
        return NULL;
    }
};

class IPluginService{
public:
    virtual void Report(const char* data,int len){
        
    };
    virtual void Logger(const char* data,int len){
        
    };
};

class ReportPluginService:public Singleton<ReportPluginService>,public IPluginService{
public:
    void Report(const char* data,int len){
        std::cout<< "ReportPluginService report data:"<<data << " len: "<<len<<std::endl;
    }
};

class LoggerPluginService:public Singleton<LoggerPluginService>,public IPluginService{
public:
    void Logger(const char* data,int len){
        std::cout<< "LoggerPluginService logger data:"<<data << " len: "<<len<<std::endl;
    }
};

class PluginBase:public IPlugin{
public:
    PluginBase(){
        m_pMediatorPlugin = NULL;
    }
    const char* GetName() const{
        return "";
    }

    void RegisterPlugin(IPlugin* plugin){
        m_pMediatorPlugin = MediatorPlugin::GetInstance();
        m_pMediatorPlugin -> Install(plugin);
    }

    MediatorPlugin * GetPuginManager(){
        return m_pMediatorPlugin;;
    }

    IPluginService* GetServiceByName(const char* serviceName){
        return NULL;;
    }
};

//性能数模插件
class PerformancePlugin:public Singleton<PerformancePlugin>,public PluginBase{

public:
    const char* GetName() const{
        return "Performance";
    }
    IPluginService* GetServiceByName(const char* serviceName){
        return NULL;
    }
};
//数据上报插件
class ReportPlugin:public Singleton<ReportPlugin>,public PluginBase{
public:
    const char* GetName() const{
        return "Report";
    }
    
    IPluginService* GetServiceByName(const char* serviceName){
        if (strcmp(serviceName, kReportService) == 0) {
            return ReportPluginService::GetInstance();
        }
        return NULL;
    }
};

//日志插件
class LoggerPlugin:public Singleton<LoggerPlugin>,public PluginBase{
public:
    const char* GetName() const{
        return "Logger";
    }
    
    IPluginService* GetServiceByName(const char* serviceName){
        if (strcmp(serviceName, kLoggerService) == 0) {
            return LoggerPluginService::GetInstance();
        }
        return NULL;
    }
};

//日志处理插件
static void RegisterPlugin(IPlugin* plugin){
    if (!plugin) {
        return;
    }
    plugin -> RegisterPlugin(plugin);
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //注册
        {
            RegisterPlugin(PerformancePlugin::GetInstance());
            RegisterPlugin(ReportPlugin::GetInstance());
            RegisterPlugin(LoggerPlugin::GetInstance());
        }
        //1、先拿到当前数据性能模块实例；
        IPlugin* currentPlugin = PerformancePlugin::GetInstance();
        if (!currentPlugin) {
            return 0;
        }
        //2、根据当前数据性能模块实例拿到插件管理中心实例；
        MediatorPlugin* pluginManager = currentPlugin -> GetPuginManager();
        if (!pluginManager) {
            return 0;
        }
        //3、从插件管理中心根据数据上报模块提供的名字拿到数据上报模块实例；
        IPlugin* reportPlugin = pluginManager -> GetPluginByName("Report");
        if (!reportPlugin) {
            return 0;
        }
        //4、此时，数据上报模块实例根据数据上报模块提供的服务名称，得到相应的服务；
        IPluginService* reportService = reportPlugin -> GetServiceByName(kReportService);
        if (!reportService) {
            return 0;
        }
        //5、通过服务进行相应的函数调用，这样性能数据就能通过数据上报模块进行数据上报；
        reportService -> Report("数据上报1", strlen("数据上报1"));
        reportService -> Report("数据上报2", strlen("数据上报2"));
        
        //附加：获取日志处理插件

        IPlugin* loggerPlugin = pluginManager -> GetPluginByName("Logger");
        if (!loggerPlugin) {
            return 0;
        }
        //获取日志处理提供的服务
        IPluginService* loggerService = loggerPlugin -> GetServiceByName(kLoggerService);
        if (!loggerService) {
            return 0;
        }
        loggerService -> Logger("日志1", strlen("日志1"));
        loggerService -> Logger("日志2", strlen("日志2"));
        
    }
    return 0;
}
