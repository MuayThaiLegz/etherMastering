pragma solidity 0.7.0;

//  Compaison In Vyper and Solidity: To understand what features Vyper does not have, and why.
// Here we explore those features and why they have been omitted.

// Modifiers EX: the following function, changeOwner, will run the code in a modifier called onlyBy 
// as part of its execution:
contract rocket{

function changeOwner(address _newOwner) public
        onlyBy(_newOwner)
{
        owner = _newOwner;
}

modifier onlyBy(address _account){

    require(msg.sender == _account);
    _;
}

enum Stages {
    SafeStage, 
    DangerStage,
    FinalStage
}

uint public creationTime = now;
Stages public stage = Stages.SafeStage;

function nextStafe() internal {
stage = Stages(uint(stage) + 1);
}

modifier stageTimeConfirmation() {
    if (stage == Stages.Safe.Stage && now >= creationTime + 10 days)
        nextStage();
    _;
}

function a()
    public
    stageTimeConfirmation
    // More code does here 
{}
}

// Inline Assembly: the following inline assembly adds 3 memory location 0x80:
//  3 0x80 mload add 0x80 mstore

// Variable Typecasting: Two sorts of typecasting implicit and explicit 
// EExplicit typecast can be inserted in Solidity
// Viper instead has a convert fucntion to perform explicit casts

/*
def convert(expr, context):
    output_type = expr.args[1].s
    if output_type in conversion_table:
        return conversion_table[output_type](expr, context)
    else:
        raise Exception('Conversion to {} is invalid.'format(output_type))

*/

// Note the use of cnversion_table
/* 
convertion_table = {
    'int128': to_int128,
    'uint256': to_unint256,
    'decimal': to_decimal,
    ''bytes32': to_bytes32,
}

@signature(('int128', 'uint256', 'bytes32', 'bytes'), 'str_literal')
def to_int128(expr, args, kwargs, context):
    in_node = args[0]
    typ, len = get_type(in_node)
    if typ in ('int128', 'uint256', 'bytes32'):
        if in_node.typ.is_literal
        and not SizeLimits.Minnum <= in_node.value), expr
        raise InvalidLiteralException(
            "Number out of range: {}".format(in_node.value), expr
        )
    return LLLnode.from_list(
        ['clamp', ['mload', MemoryPositions.MINNUM], in_node,
        ['mload', MemoryPosotions.MAXNUM]], typ=BaseType('int128'),
        pos=getpost(expr)
    )
    else:
        return byte_array_to_num(in_node, expr, 'int128')
*/

// Function and variable Ordering

contract ordering {
    function  topFunction()
    external
    returns (bool){
        intiatizedBelowTopFunction = this.lowerFunction();
        return intiatizedBelowTopFunction;
    }

    bool intiatizedBelowTopFunction;
    bool lowerFunctionVar;

    function lowerFunction()
    external
    returns (bool) {
        lowerfunctionVar = true;
        return lowerFunctionVar;
    }
}

// Vyper is logical 

/*
# Declare a variable called theBool

theBool : public(bool)

# Declare a fucntion called topFunction
@public
def topFunction() -> bool:
    # Assing a value to the already decalred fucntion caleed theBool
    self.theBool = True
    return self.theBool

# Declare a fucntion called lowerFucntion 
@public
def lowerFunction():
    # Call the already declared fucntion called topFucntion
    assert self.topFunction()
