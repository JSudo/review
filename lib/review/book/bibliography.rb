module ReVIEW
  module Book
    class Bibliography
      def initialize(bib)
        require 'bibtex'
        require 'citeproc'
        require 'csl/styles'
        @bibtex ||= BibTeX.parse(bib, filter: :latex)
        format
      end

      def format(format = 'text')
        style = 'acm-siggraph' # TODO: set via config
        @citeproc = CiteProc::Processor.new style: style, format: format
        @citeproc.import @bibtex.to_citeproc
      end

      def cite(key)
        @citeproc.render :citation, id: key
      end

      def list
        @citeproc.bibliography.join
      end
    end
  end
end
