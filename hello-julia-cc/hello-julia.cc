#include <iostream>
#include <dlfcn.h>

using namespace std;

int main(int argc, char * argv[]) {
    if(argc != 2) {
        cerr << "Invalid arguments passed: argc=" << argc << endl;
        return 1;
    }
    cout << "Opening Julia shared library: " << argv[1] << endl;
    auto libjulia = dlopen(argv[1], RTLD_LAZY);

    auto jl_init = (void (*)()) dlsym(libjulia, "jl_init");
    auto jl_eval_string = (void* (*)(const char*)) dlsym(libjulia, "jl_eval_string");

    cout << "Calling jl_init()" << endl;
    jl_init();

    cout << "Calling jl_eval_string(...)" << endl;
    jl_eval_string("@info \"Hello from Julia!\" sqrt(2.0)");

    cout << "Closing Julia shared library" << endl;
    dlclose(libjulia);
    return 0;
}
