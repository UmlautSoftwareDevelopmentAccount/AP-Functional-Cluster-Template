#ifndef GMOCK_CATCH_INTERCEPTOR
#define GMOCK_CATCH_INTERCEPTOR

#include "gmock/gmock.h"

namespace test::framework
{
class gmock_catch_interceptor : public ::testing::EmptyTestEventListener
{
public:
    virtual ~gmock_catch_interceptor() = default;

    // Called after a failed assertion or a SUCCEED() invocation.
    virtual void OnTestPartResult(::testing::TestPartResult const &test_part_result) override;
};
} /* namespace test::framework */

#endif /* GMOCK_CATCH_INTERCEPTOR */
