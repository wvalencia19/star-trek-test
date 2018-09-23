# Translate a name written in English to Klingon and find out its species

* This ruby application receives Stark trek's english name character and translte it to hexadecimal, each hexadecimal has its correspondent Klingon symbol.
* If the english name is traductable, it will search the specie from [stapi](http://stapi.co)
* The name must be passed it with double quotes.

## Use example:

```
# ruby main.rb "Or'Eq"                                                  
-> "0xF8DD 0xF8E1 0xF8E9 0xF8D4 0xF8DF"
-> "Klingon"
```

## Run tests:
```
    rspec
```
## Requirements
* Ruby environment
* Redis server

## Install Ruby: 

In the app there is a file `.ruby-version` with the required version of Ruby.

```
$ cd <path_to_repo_with_.ruby-version_file>
$ cat .ruby-version
2.2.7
$ rbenv install 'rbenv local'
```

Now initialize rbenv local with:

```
rbenv local
rbenv rehash
```
Install bundler and all gems stuff with:

```
gem install bundler
rbenv rehash
bundle install
```

## Design considerations

* Single responsability.
* Dependency inversion for decoupling modules.
* Cache layer was added to enhance performance.

 