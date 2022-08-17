// SPDX-License-Identifier: MIT
pragma solidity >=0.8.15;

contract Todos {
    struct Todo {
        string text;
        bool completed;
    }

    Todo[] private todos;

    modifier checkIndex(uint256 _index) {
        require(_index < todos.length, "index too big.");
        _;
    }

    function create(string calldata _text) public {
        todos.push(Todo(_text, false));
    }

    function get(uint256 _index) public view checkIndex(_index) returns(string memory text, bool completed) {
        return(todos[_index].text, todos[_index].completed);
    }

    function updateText(uint256 _index, string calldata _text) public checkIndex(_index) {
        todos[_index].text = _text;
    } 

    function toggleCompleted(uint256 _index) public checkIndex(_index) {
        todos[_index].completed = !todos[_index].completed;
    }
}