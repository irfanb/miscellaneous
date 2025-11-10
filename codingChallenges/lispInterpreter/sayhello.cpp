#include "absl/log/check.h"
#include "absl/log/log.h"

void sayhello() {
    // LOG(INFO) << "Found " << 1 << " cookies";
    CHECK( "hello world" );
}
