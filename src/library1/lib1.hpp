#ifndef SRC_LIBRARY1_LIB1
#define SRC_LIBRARY1_LIB1
#include <string>

namespace library1 {
/**
 * @brief
 *
 * @return int The Answer
 */
int answer();

/**
 * @brief
 *
 */
struct Interface
{
    virtual ~Interface()                       = default;
    virtual int Function(const std::string& s) = 0;
};

}  // namespace library1
#endif /* SRC_LIBRARY1_LIB1 */
