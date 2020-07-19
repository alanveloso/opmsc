pragma solidity >=0.4.16 <0.7.0;

library Messages {
    // This is a type for a simple message.
    struct Message {
        address sender;
        address receiver;
        string content;
    }
}