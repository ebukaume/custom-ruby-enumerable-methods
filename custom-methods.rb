module Enumerable
    def convert_to_array(obj)
        begin
            return obj.to_a
        rescue NoMethodError
            return "#{NoMethodError} (undefined method `#{caller_locations[-2].label}' for #{obj}:#{obj.class})"
        end
    end

    def my_each
        as_array = convert_to_array(self)
        return as_array unless as_array.is_a?(Array)
        return self.to_enum(:my_each) unless block_given?
        0.upto(as_array.length-1) {|index| yield(as_array[index])}
        self
    end

    def my_each_with_index
        as_array = convert_to_array(self)
        return as_array unless as_array.is_a?(Array)
        return self.to_enum(:my_each_with_index) unless block_given?
        0.upto(as_array.length-1) do |index|
            yield(as_array[index], index)
        end
        self
    end

    def my_select
        as_array = convert_to_array(self)
        return as_array unless as_array.is_a?(Array)
        return self.to_enum(:my_select) unless block_given?
        result = []
        0.upto(as_array.length-1) do |index|
            result << as_array[index] if yield(as_array[index])
        end
        result
    end

    def my_all?
        as_array = convert_to_array(self)
        return as_array unless as_array.is_a?(Array)
        if block_given?
            0.upto(as_array.length-1) do |index|
                return false unless yield(as_array[index])
            end
        else
            0.upto(as_array.length-1) do |index|
                return false if as_array[index] == nil || as_array[index] == false
            end
        end
        true
    end

    def my_any?
        as_array = convert_to_array(self)
        return as_array unless as_array.is_a?(Array)
        if block_given?
            0.upto(as_array.length-1) do |index|
                return true if yield(as_array[index])
            end
        else
            0.upto(as_array.length-1) do |index|
                return true unless as_array[index] == nil || as_array[index] == false
            end
        end
        false
    end

    def my_none?(*arg)
        as_array = convert_to_array(self)
        return as_array unless as_array.is_a?(Array)
        unless arg.empty?
            puts "#{caller[0].split(":")[0..-2].join(":")}: warning: any given block will not be used because an argument was already passed"
            return as_array.grep(arg[0]).empty? ? true : false
        end
        if block_given?
            0.upto(as_array.length-1) do |index|
                return false if yield(as_array[index])
            end
        else
            0.upto(as_array.length-1) do |index|
                return false unless as_array[index] == nil || as_array[index] == false
            end           
        end
        true
    end
    
    def my_count(*arg)
        as_array = convert_to_array(self)
        return as_array unless as_array.is_a?(Array)
        unless arg.empty?
            puts "#{caller[0].split(":")[0..-2].join(":")}: warning: any given block will not be used because an argument was already passed"
            return as_array.my_select {|val| val == arg[0]}.length
        end
        return as_array.my_select {|b| yield b}.length if block_given?
        as_array.length
    end

    def my_map(*proc)
        as_array = convert_to_array(self)
        return as_array unless as_array.is_a?(Array)
        result = []
        unless proc.empty?
            0.upto(as_array.length - 1) do |index| 
                result << proc[0].call(as_array[index])
            end
            return result
        end
        return self.to_enum(:my_map) unless block_given?
        0.upto(as_array.length - 1) {|index| result << yield(as_array[index])} if block_given?
        result
    end

    def my_inject(*arg)
        as_array = convert_to_array(self)
        return as_array unless as_array.is_a?(Array)
        return self.to_enum(:my_inject) unless block_given?
        result = !arg.empty? ? arg[0] : as_array[0]
        1.upto(as_array.length - 1){|index| result = yield(result,as_array[index])}
        result
    end
end

# Task number 10: method to test #my_inject
def multiply_els(arr)
    arr.my_inject {|product, current| product * current}
end

p multiply_els([2,4,5])
# => 40

q = Proc.new {|x| x*x}
p (0..5).my_map(q)

p (0..5).my_map {|x| x*x}

p (0..5).my_map(q) {|x| x*x}