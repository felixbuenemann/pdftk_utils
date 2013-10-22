# PdftkUtils

This gem provides some simple pdf utilities based on PDFtk and was ported from [gs\_pdf\_utils](https://github.com/felixbuenemann/gs_pdf_utils).

Currently it provides methods for detecting pdf files by magic, counting pdf pages
and extracting a single, all or a range of pages from a pdf.

It is less resource hungry and faster than eg. ghostscript or imagemagick for the tasks provided.

It's still in alpha state and has no spec coverage, still it might suite your needs.

## Installation

Add this line to your application's Gemfile:

    gem 'pdftk_utils', :git => "https://github.com/felixbuenemann/pdftk_utils"

And then execute:

    $ bundle

Due to it's early state, gem is not currently released on rubygems.

## Usage

```ruby
pdf = PdftkUtils::PdfFile.new "test.pdf"
# get page count
pdf.pages
# extract a page to page1.pdf
pdf.extract_page(1, "page1.pdf")
# extract all pages to separate pdfs (page-1.pdf, page-2.pdf, ...)
pdf.extract_pages("page-%d.pdf")
# extract pages 2 to 5
pdf.extract_page_range(2..5, "page2-5.pdf")
# append test2.pdf and test3.pdf to test.pdf and write to merged.pdf
pdf.append_files "test2.pdf", "test3.pdf", "merged.pdf"
# check if file is a pdf, by checking magic bytes
PdftkUtils.is_pdf? "test.pdf"
```

## Configuration

If pdftk is not in your path, you can configure it:
```ruby
PdftkUtils.config do |c|
  c.pdftk_binary = "/path/to/pdftk"
end
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
