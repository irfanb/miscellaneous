#include "absl/log/log.h"
#include "absl/log/check.h"

extern "C" void sayhello() {
    LOG(INFO) << "Found " << 1 << " cookies";
    CHECK("hello world");
}
