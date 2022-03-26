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
        AnimalType species;
    }

    mapping(address => Borrower) petBorrower;
    mapping(address => AnimalType) borrowedPet;
    mapping(AnimalType => uint256) petPark;
    mapping(AnimalType => bool) isAnimalBorrowed;


    event Added(AnimalType _animalType, uint256 AnimalCount);
    event Borrowed(AnimalType _animalType);
    event Returned(AnimalType _animalType);

    function add(AnimalType _animalType, uint256 _count) public onlyOwner {
        if (_animalType == AnimalType.None) {
            revert ("Invalid animal");
        }

        // console.log(petPark[_animalType] = _count);
        petPark[_animalType] = _count;

        emit Added(_animalType, _count);

    }

    function borrow(uint _age, Gender _gender, AnimalType _animalType) public {

        require (_age != 0, "Invalid Age");

        // if (petPark[_animalType] <= 0) {
        //     revert ("Selected animal not available");
        // }

        // if (_animalType == AnimalType.None) {
        //     revert ("Invalid animal type");
        // }

        require (_animalType != AnimalType.None, "Invalid animal type");

        require (petPark[_animalType] > 0, "Selected animal not available");

        require(borrowedPet[msg.sender] != _animalType, "Already adopted a pet");

        if (_gender == Gender.Male) {
            require (_animalType == AnimalType.Dog || _animalType == AnimalType.Fish, "Invalid animal for men");
        }

        if (_gender == Gender.Female && _age < 40) {
            require (_animalType != AnimalType.Cat, "Invalid animal for women under 40");
        }

        // console.log(petBorrower[msg.sender] == borrower(_age, _gender));

        // require (petBorrower[msg.sender])

        // require(borrowedPet[msg.sender] != _animalType, "Already adopted a pet");

        // borrowedPet[msg.sender] = _animalType;
        // isAnimalBorrowed[_animalType] = true;

        address borrower = msg.sender; 

        if (petBorrower[borrower].age > 0 ) {
            if (petBorrower[borrower].age != _age ) {
                // Returning user has changed their age
                revert("Invalid Age");
            }
            if (petBorrower[borrower].gender != _gender) {
                revert("Invalid Gender");
            }
        }
        else {
            // First time borrower, set age and gender
            petBorrower[borrower].age = _age;
            petBorrower[borrower].gender = _gender;
        }

        if (petBorrower[borrower].species != AnimalType.None) {
            revert("Already adopted a pet");
        }

        // Borrower memory borrower;

        // if (borrower.age != _age) {
        //     revert ("Invalid Age");
        // }

        // if (borrower.gender != _gender) {
        //     revert ("Invalid Gender");
        // }

        emit Borrowed(_animalType);
        
    }

    function giveBackAnimal(AnimalType _animalType) public {

        // console.log(petPark[_animalType] = petPark[_animalType] + 1);
        petPark[_animalType] = petPark[_animalType] + 1;


    }

    function animalCounts(AnimalType _animalType) public returns (uint256) {
        // console.log(petPark[_animalType]);
        return petPark[_animalType];
    }



    modifier onlyOwner() {
        require(msg.sender == owner, "Not an owner");
        // Underscore is a special character only used inside
        // a function modifier and it tells Solidity to
        // execute the rest of the code."
        _;
    }

}