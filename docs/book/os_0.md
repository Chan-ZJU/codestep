
虚拟化：虚拟化就是将一个 CPU 虚拟出来多个虚拟 CPU ，并分配给每一个进程，使得进程以为自己独占了 CPU，但实际上只有一个 CPU。

进程：运行中的程序。进程本身没有声明周期，是一些静态的指令，是操作系统使进程运转起来并发挥作用的。

采用时分共享技术使得 CPU 可以虚拟化，但随之而来的就是性能损失，因为 CPU 需要对多个进程共享使得每一个进程运行减慢。

根据资源的复用方式分为**时分共享**技术和**空分共享**技术，前者是按照时间来划分后者是按照空间来划分。

时分共享指的是将 CPU 的处理时间分为多段，不同时间段内处理不同的进程。不同时间段下在不同进程上的切换使得多个进程共同运行。

空分共享指的是将空间分隔为多个单位提供给不同的进程使用，再删除文件之前这块空间不会再分配给其他文件。

进程分运行，就绪，阻塞三种状态。除此之外还有初始状态，也就是创建进程是的状态。以及僵尸状态，表明进程执行完毕，允许别的进程查看，然后父进程根据返回的状态清理进程。
