require 'active_record'
require 'phonelib'

module ContactNumberValidator
  extend ActiveSupport::Concern

  included do
    class_attribute :contact_field, :country_details

    before_validation :format_contact_number, if: :is_indian_flow
    validate :validate_indian_contact_number, if: :is_indian_flow
    validate :validate_international_contact_number, unless: :is_indian_flow

    private

    def format_contact_number
      country = self[country_details]
      if country.present? and country['countrySortName'].present?
        return
      end
      self[contact_field] = "+91#{self[contact_field]}" if !self[contact_field].starts_with?("+91")
    end

    def validate_indian_contact_number
      country = self[country_details]
      if country.present? and country['countrySortName'].present?
        errors.add(self.contact_field, " is not valid") if !self[contact_field].match(/^[6789][0-9]{9}/)
        return
      end
      errors.add(self.contact_field, " is not valid") if !self[contact_field].match(/^\+91[6789][0-9]{9}/)
    end

    def validate_international_contact_number
      country = self[country_details]["countrySortName"]
      errors.add(self.contact_field, " is not valid") unless Phonelib.valid_for_country? self[contact_field], country
    end

    # def contact_number_present
    #   self[contact_field].present?
    # end

    def is_indian_flow
      return false if self[contact_field].blank?

      country = self[country_details]
      return false if country.present? and
          country['countrySortName'].present? and country['countrySortName'] != 'in'

      true
    end
  end

  module ClassMethods
    def contact_number_column_name(name, mobile_number_country_details = nil)
      self.contact_field = name
      self.country_details = mobile_number_country_details
    end
  end
end
