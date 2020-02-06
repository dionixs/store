# frozen_string_literal: true

require 'rexml/document'

require_relative 'lib/product'
require_relative 'lib/book'
require_relative 'lib/movie'
require_relative 'lib/drive'

types = Product.types
product = Product.choice_type_product(types)

product.save_to_xml(File.dirname(__FILE__) + '/data/products.xml')
