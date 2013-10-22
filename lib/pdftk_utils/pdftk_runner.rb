# encoding: utf-8
require 'shellwords'

module PdftkUtils
  class PdftkRunner
    def initialize(pdftk_binary = PdftkUtils.pdftk_binary)
      @pdftk = pdftk_binary
      @common_args = common_args
    end

    def run(args)
      run_with_output(args)
      nil
    end

    def run_with_output(args)
      cmd = build_pdftk_command(args)
      output = `#{cmd}`
      if $?.to_i > 0
        raise CommandFailed, "command #{cmd} failed with output: #{output}", caller
      end
      output
    end

    private

    def build_pdftk_command(args)
      cmd = "#{@pdftk.shellescape} #{@common_args} #{args} 2>&1"
    end
  end
end
