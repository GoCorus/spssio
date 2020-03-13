# frozen_string_literal: true

require_relative 'variable'

module SPSS
  class Writer
    attr_reader :handle
    attr_reader :variables

    def initialize(filename)
      @handle = API.open_write(filename)
      @variables = Hash.new { |hash, key| hash[key] = Variable.new(handle, key) }
      if block_given?
        yield self
        close
      end
    end

    def number_of_cases
      @number_of_cases ||= API.get_number_of_cases(handle)
    end
    alias size number_of_cases

    def close
      API.close_write(handle)
    end

    def create_variable(name, size = 10)
      API.set_var_name(handle, name, size)

      yield variables[name] if block_given?
    end

    def add_label(name, label)
      API.set_var_label(handle, name, label)

      yield variables[name] if block_given?
    end

    def write_char(attr, data)
      pointer = API.get_var_handle(handle, attr)
      API.set_value_char(handle, pointer, data)
    end

    def write_numeric(attr, data)
      pointer = API.get_var_handle(handle, attr)
      API.set_value_numeric(handle, pointer, data)
    end

    def spss_time(day, hour, minute, second)
      API.convert_time(day, hour, minute, second)
    end

    def spss_date(day, month, year)
      API.convert_date(day, month, year)
    end

    def write_record(record)
      record.each do |item|
        if item[:type] == 'string'
          write_char(item[:key], item[:val])
        elsif item[:type] == 'numeric'
          write_numeric(item[:key], item[:val])
        end
      end

      commit_case_record
    end

    def set_var_write_format(var_name, write_type, write_dec, write_wid)
      API.set_var_write_format(handle, var_name, write_type, write_dec, write_wid)
    end

    def set_var_print_format(var_name, print_type, print_dec, print_wid)
      API.set_var_print_format(handle, var_name, print_type, print_dec, print_wid)
    end

    def get_var_write_format(var_name)
      API.get_var_write_format(handle, var_name)
    end

    def get_var_print_format(var_name)
      API.get_var_print_format(handle, var_name)
    end

    def commit_header
      API.commit_header(handle)
    end

    def commit_case_record
      API.commit_case_record(handle)
    end
  end
end
