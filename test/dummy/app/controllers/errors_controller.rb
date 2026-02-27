# frozen_string_literal: true

class RecordInvalidDummy
  include ActiveModel::Model

  attr_accessor :name

  validates :name, presence: true
end

class ErrorsController < ApplicationController
  def bad_request
    raise ActionController::BadRequest, "dummy bad request"
  end

  def unknown_format
    raise ActionController::UnknownFormat, "dummy unknown format"
  end

  def parameter_missing
    raise ActionController::ParameterMissing, :widget
  end

  def record_not_found
    raise ActiveRecord::RecordNotFound, "dummy record missing"
  end

  def record_invalid
    invalid_record = RecordInvalidDummy.new
    invalid_record.valid?
    raise ActiveRecord::RecordInvalid, invalid_record
  end

  def statement_invalid
    raise ActiveRecord::StatementInvalid, "dummy statement invalid"
  end

  def not_implemented
    raise ActionController::NotImplemented, "dummy not implemented"
  end

  def invalid_authenticity_token
    raise ActionController::InvalidAuthenticityToken, "dummy invalid authenticity token"
  end

  def action_not_found
    raise AbstractController::ActionNotFound, "dummy action not found"
  end

  def read_only_record
    raise ActiveRecord::ReadOnlyRecord, "dummy read only record"
  end

  def record_not_saved
    raise ActiveRecord::RecordNotSaved, "dummy record not saved"
  end
end
