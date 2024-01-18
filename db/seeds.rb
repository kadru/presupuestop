# frozen_string_literal: true

# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
[
  {
    name: "vivienda",
    budget: 0,
    subcategories: [
      {
        name: "renta",
        budget: 0
      }
    ]
  },
  {
    name: "caridad",
    budget: 0,
    subcategories: [
      {
        name: "impuestos",
        budget: 0
      }
    ]
  },
  {
    name: "seguros",
    budget: 0,
    subcategories: [
      {
        name: "vida",
        budget: 0
      }
    ]
  },
  {
    name: "servicios",
    budget: 0,
    subcategories: [
      {
        name: "electricidad",
        budget: 0
      }
    ]
  },
  {
    name: "vestimenta",
    budget: 0,
    subcategories: [
      {
        name: "adultos",
        budget: 0
      }
    ]
  },
  {
    name: "personal",
    budget: 0,
    subcategories: [
      name: "cuidado de niños",
      budget: 0
    ]
  },
  {
    name: "alimentación",
    budget: 0,
    subcategories: [
      {
        name: "despensa",
        budget: 0
      }
    ]
  },
  {
    name: "transporte",
    budget: 0,
    subcategories: [
      {
        name: "gasolina y aceite",
        budget: 0
      }
    ]
  },
  {
    name: "ahorros",
    budget: 0,
    subcategories: [
      {
        name: "fondo de emergencias",
        budget: 0
      }
    ]
  },
  {
    name: "salud",
    budget: 0,
    subcategories: [
      {
        name: "medicamentos",
        budget: 0
      }
    ]
  },
  {
    name: "recreación",
    budget: 0,
    subcategories: [
      {
        name: "entretenimiento",
        budget: 0
      }
    ]
  },
  {
    name: "deuda",
    budget: 0,
    subcategories: [
      {
        name: "creditos automotriz",
        budget: 0
      }
    ]
  }
].each do |cat_data|
  cat = Category.find_or_create_by!(
    name: cat_data.fetch(:name),
    budget: cat_data.fetch(:budget)
  )

  cat_data.fetch(:subcategories).each do |subcat_data|
    Subcategory.find_or_create_by!(
      name: subcat_data.fetch(:name),
      budget: subcat_data.fetch(:budget),
      category_id: cat.id
    )
  end
end
