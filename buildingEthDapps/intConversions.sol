pragma solidity >=0.4.0 <0.8.0;

contract IntConversions {
    int256 bigNumber = 150000000000;
    int32 mediumNegativeNumber = -450000;
    uint16 smallPostitiveNumber = 15678;

    int16 newSmallNumber = bigNumber;

    uint64 newMediumPositiveNumber = mediumNegativeNumber;

    uint32 public newMediumNumber = smallPostitiveNumber;

    uint256 public newBigNumber = mediumNegativeNumber;
}