require "bizongo_validators/version"
require "bizongo_validators/random_module"

module BizongoValidators
  # module ContactNumberValidator
  #   autoload :ContactNumberValidator, 'bizongo_validators/contact_number_validator'
  # end

  def hello
    autoload :RandomModule, 'bizongo_validators/random_module'
  end
end
