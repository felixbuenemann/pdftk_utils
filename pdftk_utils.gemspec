# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pdftk_utils/version'

Gem::Specification.new do |gem|
  gem.name          = "pdftk_utils"
  gem.version       = PdftkUtils::VERSION
  gem.authors       = ["Felix Buenemann"]
  gem.email         = ["buenemann@louis.info"]
  gem.description   = %q{The pdftk_utils gem is a port of gs_pdf_utils to pdftk and provides simple pdf processing.}
  gem.summary       = %q{PDFtk Utilities}
  gem.homepage      = "http://github.com/fbuenemann/pdftk_utils"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
end
