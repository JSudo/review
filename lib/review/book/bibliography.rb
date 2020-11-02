require 'bibtex'
require 'citeproc'
require 'csl/styles'

module ReVIEW
  module Book
    class Bibliography
      def initialize(bibfile, config = nil)
        @bibtex = BibTeX.parse(bibfile, filter: :latex)
        @config = config
        format('text')
      end

      def format(format)
        style = @config['bib-csl-style'] || 'acm-siggraph'
        @citeproc = CiteProc::Processor.new(style: style, format: format)
        @citeproc.import(@bibtex.to_citeproc)
        self
      end

      def ref(key)
        @citeproc.render(:citation, id: key)
      end

      def list
        @citeproc.bibliography.join
      end
    end
  end
end
