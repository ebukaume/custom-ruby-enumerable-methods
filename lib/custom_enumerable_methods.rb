module Enumerable
    def my_each
        return self.to_enum(:my_each) unless block_given?

        0.upto(self.size - 1) {|index| yield(self.to_a[index])}
        self
    end

    def my_each_with_index
        return self.to_enum(:my_each_with_index) unless block_given?

        0.upto(self.size - 1) {|index| yield(self.to_a[index], index)}
        self
    end

    def my_select
        return self.to_enum(:my_select) unless block_given?

        result = []
        0.upto(self.size - 1) {|index| result << self.to_a[index] if yield(self.to_a[index])}
        result
    end

    def my_all?(*arg)
        return self.grep(arg.first).length == self.size unless arg.empty?
    
        self.my_each { |el| return false unless yield(el) } if block_given?

        self.my_each { |el| return false unless el } unless block_given?

        true
    end

    def my_any?(*arg)
        return !self.grep(arg.first).empty? unless arg.empty?

        self.my_each { |el| return true if yield(el) } if block_given?

        self.my_each { |el| return true if el } unless block_given?

        false
    end

    def my_none?(*arg)
        return self.grep(arg.first).empty? unless arg.empty?
    
        self.my_each { |el| return false if yield(el) } if block_given?

        self.my_each { |el| return false if el } unless block_given?

        true
    end
    
    def my_count(*arg)
        return self.my_select {|el| el == arg.first}.length unless arg.empty?

        return self.my_select {|el| yield el}.length if block_given?

        self.size
    end

    def my_map(*proc)
        raise ArgumentError.new("Supplied argument not a proc") unless block_given? || proc.is_a?(Proc)
        
        result = []
        unless proc.empty?
            0.upto(self.length - 1) {|index| result << proc.first.call(self.to_a[index])}
            return result
        end

        return self.to_enum(:my_map) unless block_given?

        0.upto(self.size - 1) {|index| result << yield(self.to_a[index])}
        result
    end

    def my_inject(*arg)
        return self.to_enum(:my_inject) unless block_given?

        result = arg.empty? ? self.first : arg.first
        1.upto(self.length - 1){|index| result = yield(result, self.to_a[index])}
        result
    end
end


def multiply_els(arr)
    arr.my_inject {|product, current| product * current}
end

p [2,3,4,6].my_any? {|x| x.even?}