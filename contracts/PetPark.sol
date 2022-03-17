//SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.0;

import "hardhat/console.sol";


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
    mapping(AnimalType => uint) petPark;


    event Added(AnimalType _animalType, uint AnimalCount);
    event Borrowed(AnimalType _animalType);
    event Returned(AnimalType _animalType);

    function add(AnimalType _animalType, uint _count) public onlyOwner {
        if (_animalType == AnimalType.None) {
            revert ("Invalid animal");
        }

        // console.log(petPark[_animalType] = _count);
        petPark[_animalType] = _count;

        emit Added(_animalType, _count);


    }

    function borrow(uint _age, Gender _gender, AnimalType _animalType) public {

        require (_age != 0, "Invalid Age");

        Borrower memory borrower;

        // if (petPark[_animalType] <= 0) {
        //     revert ("Selected animal not available");
        // }

        // if (_animalType == AnimalType.None) {
        //     revert ("Invalid animal type");
        // }

        require (_animalType != AnimalType.None, "Invalid animal type");

        require (petPark[_animalType] > 0, "Selected animal not available");

        if (_gender == Gender.Male) {
            require (_animalType == AnimalType.Dog || _animalType == AnimalType.Fish, "Invalid animal for men");
        }

        if (_gender == Gender.Female && _age < 40) {
            require (_animalType != AnimalType.Cat, "Invalid animal for women under 40");
        }

        // console.log(petBorrower[msg.sender] == borrower(_age, _gender));

        // require (petBorrower[msg.sender])

        

        // if (borrower.age != _age) {
        //     revert ("Invalid Age");
        // }

        // if (borrower.gender != _gender) {
        //     revert ("Invalid Gender");
        // }

        emit Borrowed(_animalType);

    }

    function giveBackAnimal() public {

    }





    modifier onlyOwner() {
        require(msg.sender == owner, "Not an owner");
        // Underscore is a special character only used inside
        // a function modifier and it tells Solidity to
        // execute the rest of the code."
        _;
    }

}