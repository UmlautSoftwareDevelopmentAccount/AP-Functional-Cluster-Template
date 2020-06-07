#include <catch2/catch.hpp>
#include <catch2/trompeloeil.hpp>

#include <lib1.hpp>

struct Mock : public library1::Interface
{
    MAKE_MOCK1(Function, int(const std::string&), override);
};

int InterfaceTest(library1::Interface& i)
{
    int acc = 0;

    acc += i.Function("One");
    acc += i.Function("Three");
    acc += i.Function("Two");

    return acc;
}

TEST_CASE("Answer is given", "[answer]")
{
    // REQUIRE(library1::answer() == 123);
    REQUIRE(library1::answer() == 42);
}

TEST_CASE("Mock test")
{
    Mock m;

    trompeloeil::sequence seq;
    REQUIRE_CALL(m, Function("One")).RETURN(1).IN_SEQUENCE(seq);
    REQUIRE_CALL(m, Function("Three")).RETURN(3).IN_SEQUENCE(seq);
    REQUIRE_CALL(m, Function("Two")).RETURN(2).IN_SEQUENCE(seq);

    CHECK(InterfaceTest(m) == 6);
}

TEST_CASE("Matchers test")
{
    using namespace Catch::Matchers;

    CHECK_THAT("Some string", Contains("Some"));
    REQUIRE_THAT("Some string", Contains("string"));
}

SCENARIO("vectors can be sized and resized", "[vector]")
{

    GIVEN("A vector with some items")
    {
        std::vector<int> v(5);

        REQUIRE(v.size() == 5);
        REQUIRE(v.capacity() >= 5);

        WHEN("the size is increased")
        {
            v.resize(10);

            THEN("the size and capacity change")
            {
                REQUIRE(v.size() == 10);
                REQUIRE(v.capacity() >= 10);
            }
        }
        WHEN("the size is reduced")
        {
            v.resize(0);

            THEN("the size changes but not capacity")
            {
                REQUIRE(v.size() == 0);
                REQUIRE(v.capacity() >= 5);
            }
        }
        WHEN("more capacity is reserved")
        {
            v.reserve(10);

            THEN("the capacity changes but not the size")
            {
                REQUIRE(v.size() == 5);
                REQUIRE(v.capacity() >= 10);
            }
        }
        WHEN("less capacity is reserved")
        {
            v.reserve(0);

            THEN("neither size nor capacity are changed")
            {
                REQUIRE(v.size() == 5);
                REQUIRE(v.capacity() >= 5);
            }
        }
    }
}
