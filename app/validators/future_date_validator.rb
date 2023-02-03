class FutureDateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    if (value.present? && (value < 18.years || value > 100.years))
      message = options[:message] || :future_date
      record.errors.add(attribute, message)
    end
  end
end