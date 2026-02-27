# frozen_string_literal: true

Dummy::Application.routes.draw do
  get "/errors/bad_request", to: "errors#bad_request"
  get "/errors/unknown_format", to: "errors#unknown_format"
  get "/errors/parameter_missing", to: "errors#parameter_missing"
  get "/errors/record_not_found", to: "errors#record_not_found"
  get "/errors/record_invalid", to: "errors#record_invalid"
  get "/errors/statement_invalid", to: "errors#statement_invalid"
  get "/errors/not_implemented", to: "errors#not_implemented"
  get "/errors/invalid_authenticity_token", to: "errors#invalid_authenticity_token"
  get "/errors/action_not_found", to: "errors#action_not_found"
  get "/errors/read_only_record", to: "errors#read_only_record"
  get "/errors/record_not_saved", to: "errors#record_not_saved"
end
