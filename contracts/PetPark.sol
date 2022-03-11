//SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.0;


contract PetPark {

    address owner;

    enum AnimalType {
        None,
        Fish,
        Cat,
        Dog,
        Rabbit,
        Parrot
    }

    enum Gender {
        Male,
        Female
    }
    
    constructor() {
        owner = msg.sender;
    }

    struct Borrower {
        uint age;
        Gender gender;
    }

    mapping(address => Borrower) petBorrower;
    // mapping(AnimalType => uint) petPark;


    event Added(AnimalType _animalType, uint AnimalCount);
    event Borrowed(AnimalType _animalType);
    event Returned(AnimalType _animalType);

    function add(AnimalType _animalType, uint _count) public onlyOwner {
        if (_animalType == AnimalType.None) {
            revert ("Invalid animal");
        }

        


        emit Added(_animalType, _count);


    }

    function borrow(uint _age, Gender _gender, AnimalType _animalType) public {

        if (_age == 0) {
            revert ("Invalid Age");
        }

    }

    function giveBackAnimal() public {

    }



    modifier onlyOwner() {
        require(msg.sender == owner, "Not an owner");
        // Underscore is a special character only used inside
        // a function modifier and it tells Solidity to
        // execute the rest of the code.
        _;
    }

}