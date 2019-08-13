require 'ostruct'
require 'test_helper'
require 'support/steps'

class Micro::Service::CallingTest < Minitest::Test
  Failure = Micro::Service::Result::Failure

  Add2ToAllNumbers1 = Micro::Service::Pipeline[
    Steps::ConvertToNumbers,
    Steps::Add2
  ]

  class Add2ToAllNumbers2
    include Micro::Service::Pipeline

    pipeline Steps::ConvertToNumbers, Steps::Add2
  end

  Add2ToAllNumbers3 = Steps::ConvertToNumbers >> Steps::Add2

  def test_the_calling_of_services
    assert_raises(ArgumentError) { Steps::ConvertToNumbers.new() }

    assert_instance_of(Failure, Steps::ConvertToNumbers.new({}).call)
    assert_instance_of(Failure, Steps::ConvertToNumbers.call({}))
    assert_instance_of(Failure, Steps::ConvertToNumbers.call)
  end

  def test_the_calling_of_collection_mapper_pipelines
    assert_raises(NoMethodError) { Add2ToAllNumbers1.new({}).call }

    assert_instance_of(Failure, Add2ToAllNumbers1.call({}))
    assert_instance_of(Failure, Add2ToAllNumbers1.call)
  end

  def test_the_calling_of_pipeline_classes
    assert_raises(ArgumentError) { Add2ToAllNumbers2.new() }
    assert_instance_of(Failure, Add2ToAllNumbers2.new({}).call)
    assert_instance_of(Failure, Add2ToAllNumbers2.call({}))
    assert_instance_of(Failure, Add2ToAllNumbers2.call)
  end

  def test_the_calling_of_pipeline_classes
    assert_raises(ArgumentError) { Add2ToAllNumbers2.new() }
    assert_instance_of(Failure, Add2ToAllNumbers2.new({}).call)
    assert_instance_of(Failure, Add2ToAllNumbers2.call({}))
    assert_instance_of(Failure, Add2ToAllNumbers2.call)
  end

  def test_the_calling_of_a_pipeline_created_from_composition_operators
    def test_the_calling_of_collection_mapper_pipelines
      assert_raises(NoMethodError) { Add2ToAllNumbers3.new({}).call }

      assert_instance_of(Failure, Add2ToAllNumbers3.call({}))
      assert_instance_of(Failure, Add2ToAllNumbers3.call)
    end
  end
end
