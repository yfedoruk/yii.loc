#!/bin/bash

function create_dir {
  if [ ! -d $1 ];
  then
    mkdir $1
  fi
}

echo "create the src directory..."
create_dir src
echo "create the test directory..."
create_dir test

echo "write the package.json file..."
echo '{
  "name": "sample_project",
  "version": "0.0.1",
  "engines": {
    "node": "0.6.6"
  },
  "scripts": {"test": "./node_modules/mocha/bin/mocha"},
  "dependencies":{
    "mocha": "latest",
    "should": "latest",
    "sinon": "latest"
  }
}' > package.json

echo "install npm packages..."
npm install

echo "create a sample spec file..."
echo "var should = require('should');
var Person = require(__dirname + '/../src/person');

describe('Person', function() {
  it('should be able to say hello', function() {
    var Person = global.theApp.Person();
    var personInstance = new Person();
    var message = personInstance.sayHelloTo('adomokos');

    message.should.equal('Hello, adomokos!');
  });
});" > test/person_spec.js

echo "create a sample src file..."
echo "global.theApp = {};

global.theApp.Person = function() {

  var Person = function() {
   this.sayHelloTo = function(anotherPerson) {
      return 'Hello, ' + anotherPerson + '!';
    };
  };

  return Person;

};" > src/person.js

echo "run the spec with mocha..."
node_modules/mocha/bin/mocha

echo "run the spec with list reporter..."
node_modules/mocha/bin/mocha -R list