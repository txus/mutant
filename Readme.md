# DEAD DEVELOPMENT

Development at this location is dead. It moved to [mbj/mutant](https://github.com/mbj/mutant) where it was rewritten from scratch with more features and higher stability.

# mutant [![Build Status](https://secure.travis-ci.org/txus/mutant.png)](http://travis-ci.org/txus/mutant) [![Dependency Status](https://gemnasium.com/txus/mutant.png)](https://gemnasium.com/txus/mutant)

Mutant is a mutation tester. It modifies your code and runs your tests to make sure they fail. The idea is that if code can be changed and your tests don't notice, either that code isn't being covered or it doesn't do anything.

Largely based on [heckle](https://github.com/seattlerb/heckle), this is a rewrite on top of [Rubinius](http://rubini.us).

## Usage

````
mutate "ClassName#method_to_test" spec
````

To test a class method, use:

````
mutate "ClassName.class_method_to_test" spec
````

## Development roadmap

As an experiment, I've set up a [public Trello board](https://trello.com/board/mutant/4f452510101d860b203b542d) with the development roadmap up to the 1.0 release. You can vote and comment cards to give constructive feedback to the project. Just have a look and leave a comment! :)

## Who's this

This project was originally created by [@justinko](http://twitter.com/justinko) (derived from [this gist](https://gist.github.com/1065789) by [@dkubb](http://twitter.com/dkubb)) and is released under the MIT license. I am pleased to be the current maintainer :) I'm [@txustice](http://twitter.com/txustice) on twitter (where you should probably follow me!).
