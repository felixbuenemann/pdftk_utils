require "pdftk_utils/version"

module PdftkUtils
  class PdftkUtilsError < StandardError; end
  class BadFileType < PdftkUtilsError; end
  class CommandFailed < PdftkUtilsError; end
  class ProcessingError < PdftkUtilsError; end
  class OutOfBounds < PdftkUtilsError; end
  class InvalidPassword < PdftkUtilsError; end

  class << self
    attr_writer :pdftk_binary
    def pdftk_binary
      @pdftk_binary ||= "pdftk"
    end

    attr_writer :qpdf_binary
    def qpdf_binary
      @qpdf_binary ||= "qpdf"
    end

    def is_pdf?(file)
      IO.binread(file, 4) == "%PDF"
    end

    def configure
      yield self
    end
  end

  autoload :ShellRunner, 'pdftk_utils/shell_runner'
  autoload :PdfFile,     'pdftk_utils/pdf_file'
end
