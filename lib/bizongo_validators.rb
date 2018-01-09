require "bizongo_validators/version"
# require "bizongo_validators/random_module"
require "active_record"
# require "bizongo_validators/contact_number_validator"

module BizongoValidators
  autoload :ContactNumberValidator, 'bizongo_validators/contact_number_validator'
end
