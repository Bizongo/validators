require 'active_record'
require 'phonelib'

module ContactNumberValidator
  extend ActiveSupport::Concern

  included do
    class_attribute :contact_field, :country_short_name

    before_validation :format_contact_number, if: :indian_flow
    validate :validate_indian_contact_number, if: :indian_flow
    validate :validate_international_contact_number, unless: :indian_flow

    private

    def format_contact_number
      binding.pry
      return if country_short_name.present?
      self[contact_field] = "+91#{self[contact_field]}" if !self[contact_field].starts_with?("+91")
    end

    def validate_indian_contact_number
      binding.pry
      if country_short_name.present?
        errors.add(self.contact_field, " is not valid") if !self[contact_field].match(/^[6789][0-9]{9}/)
        return
      end
      errors.add(self.contact_field, " is not valid") if !self[contact_field].match(/^\+91[6789][0-9]{9}/)
    end

    def validate_international_contact_number
      binding.pry
      return if self[contact_field].blank?

      errors.add(self.contact_field, " is not valid") unless Phonelib.valid_for_country? self[contact_field], country_short_name
    end

    def indian_flow
      return false if self[contact_field].blank?

      return false if country_short_name.present? and country_short_name != 'in'

      true
    end
  end

  module ClassMethods
    def contact_number_column_name(name, country_short_name=nil)
      binding.pry
      self.contact_field = name
      self.country_short_name = country_short_name
    end
  end
end
