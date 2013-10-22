# encoding: utf-8
require 'shellwords'

module PdftkUtils
  class PdfFile
    def initialize(pdf_file, pdftk_runner = PdftkRunner.new)
      unless PdftkUtils.is_pdf? pdf_file
        raise BadFileType, "#{pdf_file} does not appear to be a PDF", caller
      end
      @file = pdf_file
      @pdftk_runner = pdftk_runner
    end

    def pages
      @pages ||= count_pages
    end

    def extract_page(page, targetfile)
      extract_page_range(page..page, targetfile)
    end

    def extract_page_range(page_range, targetfile)
      page_from = page_range.first
      page_to = page_range.last
      if page_from < 1 || page_from > page_to || page_to > pages
        raise OutOfBounds, "page range #{page_range} is out of bounds (1..#{pages})", caller
      end
      @pdftk_runner.run "#{@file.shellescape} cat #{page_from}-#{page_to} output #{targetfile.shellescape}"
      if File.size(targetfile) == 0
        raise ProcessingError, "extracted page is 0 bytes", caller
      end
      targetfile
    end

    # targetfile_template = "test-%d.pdf"
    def extract_pages(targetfile_template)
      @pdftk_runner.run "#{@file.shellescape} burst output #{targetfile_template.shellescape}"
      File.delete("doc_data.txt") if File.exists? "doc_data.txt"
      targetfiles = (1..pages).map {|page| sprintf(targetfile_template, page)}
    end

    def append_files(*pdf_files, targetfile)
      pdf_files.each do |pdf_file|
        unless PdftkUtils.is_pdf? pdf_file
          raise BadFileType, "#{pdf_file} does not appear to be a PDF", caller
        end
      end
      @pdftk_runner.run "#{@file.shellescape} #{pdf_files.map(&:shellescape).join ' '} cat output #{targetfile.shellescape}"
      targetfile
    end

    private

    def count_pages
      output = @pdftk_runner.run_with_output "#{@file.shellescape} dump_data"
      num_pages = output.match(/^NumberOfPages: (\d+)$/)[1].to_i
      if num_pages == 0
        raise ProcessingError, "could not determine number of pages", caller
      end
      num_pages
    end

  end
end
