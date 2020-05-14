#ifndef SRC_TESTING_FRAMEWORK_TESTSESSION
#define SRC_TESTING_FRAMEWORK_TESTSESSION

namespace test::framework
{

class TestSession
{
public:
    TestSession();

    int run(int argc, char *argv[]);
};

} // namespace test::framework

#endif /* SRC_TESTING_FRAMEWORK_TESTSESSION */
