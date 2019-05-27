# Custom Ruby Enumerable Methods (just a few)

This is a solo project as a way to enforce my understanding of creating and using ruby methods, module and enumerator. In this project, I implemented some commonly used enumerable methods as part of the ruby built-in Enumerable module for Array and Enumerator classes. Check below to the full list of methods implemented in this project.

This project is part of a series of projects to be completed by students of [Microverse](https://www.microverse.org/ "The Global School for Remote Software Developers!").

## Technologies

- Ruby

## Scope

The methods implemented in this project include:

- #my_each
- #my_each_with_index
- #my_select
- #my_all?
- #my_any?
- #my_none?
- #my_count
- #my_map
- #my_inject

  > _Note: #my_inject is a partial implementation as it does not take into account certain complexities._

## Usage

> Clone the repository to your local machine

```sh
$ git clone https://github.com/ebukaume/custom-ruby-enumerable-methods.git
```

> cd into the directory

```sh
$ cd custom-ruby-enumerable-methods
```

> load the module. _Note: make sure to prepend the current path_

```ruby
require "./custom-methods.rb>"
```

> Then use the methods like you would use built-in ruby enumerable methods

```ruby
arr = [2,3,4,5].my_each {|val| puts "#{val} apples!"}

# => 2 apples!
# => 3 apples!
# => 4 apples!
# => 5 apples!

puts (1..10).my_count {|num| num % 2 == 0}

# => 5
```

## Contributors

This is a solo project by me: [Ebuka Umeokonkwo](https://github.com/ebukaume)

## Contributing

1. Fork it (https://github.com/ebukaume/custom-ruby-enumerable-methods/fork)
2. Create your feature branch (git checkout -b feature/[choose-a-name])
3. Commit your changes (git commit -am 'what this commit will fix/add')
4. Push to the branch (git push origin feature/[chosen-name])
5. Create a new Pull Request

## License

This project is licensed under the MIT License - see the [LICENSE](./LICENSE.md) file for details
