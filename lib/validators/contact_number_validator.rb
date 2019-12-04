require 'active_record'
require 'phonelib'

module ContactNumberValidator
  extend ActiveSupport::Concern

  included do
    class_attribute :contact_field, :country_short_name_fetching_function

    before_validation :format_contact_number, if: :indian_flow
    validate :validate_indian_contact_number, if: :indian_flow
    validate :validate_international_contact_number, unless: :indian_flow

    private

    def country_short_name
      return self.send(country_short_name_fetching_function) if country_short_name_fetching_function.present?

      nil
    end

    def format_contact_number
      return if country_short_name
      self[contact_field] = "+91#{self[contact_field]}" if !self[contact_field].starts_with?("+91")
    end

    def validate_indian_contact_number
      if country_short_name
        errors.add(self.contact_field, " is not valid") if !self[contact_field].match(/^[6789][0-9]{9}/)
        return
      end
      errors.add(self.contact_field, " is not valid") if !self[contact_field].match(/^\+91[6789][0-9]{9}/)
    end

    def validate_international_contact_number
      return if self[contact_field].blank?

      errors.add(self.contact_field, " is not valid") unless Phonelib.valid_for_country? self[contact_field],
                                                                                         country_short_name
    end

    def indian_flow
      country_short_name = nil
      country_short_name = self.send(country_short_name_fetching_function) if country_short_name_fetching_function.present?

      return false if self[contact_field].blank?

      return false if country_short_name.present? and (country_short_name != 'in' or country_short_name != 'IN')

      true
    end
  end

  module ClassMethods
    def contact_number_column_name(name, country_short_name_fetching_function=nil)
      self.contact_field = name
      self.country_short_name_fetching_function = country_short_name_fetching_function
    end
  end
end
