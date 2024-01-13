# frozen_string_literal: true

FactoryBot.define do
  factory :expense do
    name { "renta departamento" }
    amount { 10_000 }
  end
end
