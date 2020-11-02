require 'book_test_helper'
require 'review/book/bibliography'

class BibliographyTest < Test::Unit::TestCase
  include BookTestHelper
  def setup
    config = {}
    @bib = Book::Bibliography.new(bibfile, config)
  end

  def test_new
    assert @bib
  end

  def test_ref_text
    assert_equal '[Thomas et al. 2009]', @bib.format('text').ref('pickaxe')
  end

  def test_cite_html
    assert_equal '[Thomas et al. 2009]', @bib.format('html').ref('pickaxe')
  end

  def test_ref_latex
    assert_equal '[Thomas et al. 2009]', @bib.format('latex').ref('pickaxe')
  end

  def test_list
    expect = <<-EOS
Fraassen, B.C. van. 1989. Laws and Symmetry. Oxford University Press, Oxford.
Thomas, D., Fowler, C., and Hunt, A. 2009. Programming Ruby 1.9: The Pragmatic Programmer’s Guide. The Pragmatic Bookshelf, Raleigh, North Carolina.
EOS
    assert_equal expect.chomp, @bib.format('text').list
  end

  def test_list_html
    expect = <<-EOS
<ol class="csl-bibliography">
  <li class="csl-entry"><span style="font-variant: small-caps">Fraassen, B.C. van</span>. 1989. <i>Laws and Symmetry</i>. Oxford University Press, Oxford.</li>
  <li class="csl-entry"><span style="font-variant: small-caps">Thomas, D., Fowler, C., and Hunt, A.</span> 2009. <i>Programming Ruby 1.9: The Pragmatic Programmer’s Guide</i>. The Pragmatic Bookshelf, Raleigh, North Carolina.</li>
</ol>
EOS
    assert_equal expect.chomp, @bib.format('html').list
  end

  def test_list_latex
    expect = <<-EOS
\\begin{enumerate}
\\item  Fraassen, B.C. van. 1989. \\emph{Laws and Symmetry}. Oxford University Press, Oxford.
\\item  Thomas, D., Fowler, C., and Hunt, A. 2009. \\emph{Programming Ruby 1.9: The Pragmatic Programmer’s Guide}. The Pragmatic Bookshelf, Raleigh, North Carolina.
\\end{enumerate}
EOS
    assert_equal expect.chomp, @bib.format('latex').list
  end

  private

  def bibfile
    <<-EOS
@book{pickaxe,
  address = {Raleigh, North Carolina},
  author = {Thomas, Dave and Fowler, Chad and Hunt, Andy},
  publisher = {The Pragmatic Bookshelf},
  series = {The Facets of Ruby},
  title = {Programming Ruby 1.9: The Pragmatic Programmer's Guide},
  year = {2009}
}
@book{fraassen_1989,
  Address = {Oxford},
  Author = {Bas C. van Fraassen},
  Publisher = {Oxford University Press},
  Title = {Laws and Symmetry},
  Year = 1989
}
EOS
  end
end
