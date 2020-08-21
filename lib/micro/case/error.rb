# frozen_string_literal: true

module Micro
  class Case
    module Error
      class UnexpectedResult < TypeError
        MESSAGE = 'must return an instance of Micro::Case::Result'.freeze

        def initialize(context)
          super("#{context} #{MESSAGE}")
        end
      end

      class ResultIsAlreadyDefined < ArgumentError
        def initialize; super('result is already defined'.freeze); end
      end

      class InvalidResultType < TypeError
        def initialize; super('type must be a Symbol'.freeze); end
      end

      class InvalidResult < TypeError
        def initialize(is_success, type, use_case)
          base =
            "The result returned from #{use_case.class.name}#call! must be a Hash."

          result = is_success ? 'Success'.freeze : 'Failure'.freeze

          example =
            if type === :ok || type === :error || type === :exception
              "#{result}(result: { key: 'value' })"
            else
              "#{result}(:#{type}, result: { key: 'value' })"
            end

          super("#{base}\n\nExample:\n  #{example}")
        end
      end

      class InvalidResultInstance < ArgumentError
        def initialize; super('argument must be an instance of Micro::Case::Result'.freeze); end
      end

      class InvalidUseCase < TypeError
        def initialize; super('use case must be a kind or an instance of Micro::Case'.freeze); end
      end

      class InvalidInvocationOfTheThenMethod < StandardError
        def initialize(class_name)
          super("Invalid invocation of the #{class_name}then method")
        end
      end

      def self.by_wrong_usage?(exception)
        case exception
        when Kind::Error, ArgumentError, InvalidResult, UnexpectedResult then true
        else false
        end
      end
    end
  end
end
