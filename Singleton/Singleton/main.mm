//
//  main.m
//  Singleton
//
//  Created by xiang lin on 2020/5/28.
//  Copyright © 2020 xiang lin. All rights reserved.
//
/**
 单列模式要求类的实例，在整个应用的生命周期只会实例化一次
 无论任何时候，返回的都是同一个实例
 */
#import <Foundation/Foundation.h>
#import <pthread.h>

//这种写法出现在多线程中就会出现实例化多个singleInstance
class SingletonDemo1{
private:
    static SingletonDemo1* singleInstance;
public:
    static SingletonDemo1* sharedInstance(){
        if (NULL == singleInstance) {
            singleInstance = new SingletonDemo1();
        }
        return singleInstance;
    }
};
SingletonDemo1* SingletonDemo1::singleInstance = NULL;

//这种写法性能相对较差，每次获取的时候都会加锁，初始化成功之后就不需要加锁
class SingletonDemo2{
private:
    static SingletonDemo2* singleInstance;
    static pthread_mutex_t mutex;
public:
    static SingletonDemo2* sharedInstance(){
        pthread_mutex_lock(&mutex);
        if (NULL == singleInstance) {
            singleInstance = new SingletonDemo2();
        }
        pthread_mutex_unlock(&mutex);
        return singleInstance;
    }
};
SingletonDemo2* SingletonDemo2::singleInstance = NULL;
pthread_mutex_t SingletonDemo2::mutex = PTHREAD_MUTEX_INITIALIZER;

// 这种写法在多线程中还是有问题的，当线程1，线程2同时读取到 NULL == singleInstance
// 此时线程1优先级高，先拿到锁，然后实例化单列对象，线程2处于等待线程1释放锁，线程1
// 释放之后，线程2 将会重新分配内存，让singleInstance指向新分配的对象
class SingletonDemo3{
private:
    static SingletonDemo3* singleInstance;
    static pthread_mutex_t mutex;
public:
    static SingletonDemo3* sharedInstance(){
        if (NULL == singleInstance) {
            pthread_mutex_lock(&mutex);
            singleInstance = new SingletonDemo3();
            pthread_mutex_unlock(&mutex);
        }
        return singleInstance;
    }
};
SingletonDemo3* SingletonDemo3::singleInstance = NULL;
pthread_mutex_t SingletonDemo3::mutex = PTHREAD_MUTEX_INITIALIZER;

// 这种写法完美避免 上面出现的问题，性能最优，实例化一次对象
class SingletonDemo4{
private:
    static SingletonDemo4* singleInstance;
    static pthread_mutex_t mutex;
public:
    static SingletonDemo4* sharedInstance(){
        if (NULL == singleInstance) {
            pthread_mutex_lock(&mutex);
            if (NULL == singleInstance) {
                singleInstance = new SingletonDemo4();
            }
            pthread_mutex_unlock(&mutex);
        }
        return singleInstance;
    }
};

SingletonDemo4* SingletonDemo4::singleInstance = NULL;
pthread_mutex_t SingletonDemo4::mutex = PTHREAD_MUTEX_INITIALIZER;

//单列之终极版，最完美的是使用模板
template <typename T>
class SingletonDemo5{
private:
    static T* singleInstance;
    static pthread_mutex_t mutex;
public:
    static T* sharedInstance(){
        if (NULL == singleInstance){
            pthread_mutex_lock(&mutex);
            if (NULL == singleInstance) {
                singleInstance = new T();
            }
            pthread_mutex_unlock(&mutex);
        }
        return singleInstance;
    }
};
template<typename T> T*SingletonDemo5<T>::singleInstance = NULL;
template<typename T> pthread_mutex_t SingletonDemo5<T>::mutex = PTHREAD_MUTEX_INITIALIZER;

//OC单例，由苹果系统保证性能，仅仅返回一个对象
id ocSingleton(){
    static id singleInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        //singleInstance = [Class alloc]init];
    });
    return singleInstance;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
