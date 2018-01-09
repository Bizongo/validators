require "bizongo_validators/version"
# require "bizongo_validators/random_module"
require "active_record"

module BizongoValidators
  module ContactNumberValidator
    extend ActiveSupport::Concern

    included do
      class_attribute :contact_field

      before_validation :format_contact_number, if: :contact_number_present
      validate :validate_contact_number, if: :contact_number_present

      private

      def format_contact_number
        self[contact_field] = "+91#{self[contact_field]}" if !self[contact_field].starts_with?("+91")
      end

      def validate_contact_number
        errors.add(self.contact_field, " is not valid") if !self[contact_field].match(/^\+91[789][0-9]{9}/)
      end

      def contact_number_present
        self[contact_field].present?
      end

    end

    module ClassMethods
      def contact_number_column_name(name)
        binding.pry
        self.contact_field = name
      end
    end
  end

end
