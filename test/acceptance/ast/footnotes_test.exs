defmodule Acceptance.Ast.FootnotesTest do
  use ExUnit.Case
  import Support.Helpers, only: [as_ast: 2, parse_html: 1]

  @moduletag :ast

  describe "Footnotes" do

    test "without errors" do
      markdown = "foo[^1] again\n\n[^1]: bar baz"
      html     = [ ~s{<p>foo<a href="#fn:1" id="fnref:1" class="footnote" title="see footnote">1</a> again</p>}, 
        ~s{<div class="footnotes">}, 
        ~s{<hr>}, 
        ~s{<ol>}, 
        ~s{<li id="fn:1"><p>bar baz<a class="reversefootnote" href="#fnref:1" title="return to article">&#x21A9;</a></p>}, 
        ~s{</li>}, 
        ~s{</ol>}, 
        ~s{}, 
        ~s{</div>} ] |> Enum.join("\n")
        ast      = parse_html(html)
        messages = []

        assert as_ast(markdown, footnotes: true) == {:ok, ast, messages}
        end

    test "undefined footnotes" do
      markdown = "foo[^1]\nhello\n\n[^2]: bar baz"
      html     = ~s{<p>foo[^1]\nhello</p>\n}
      ast      = parse_html(html)
      messages = [{:error, 1, "footnote 1 undefined, reference to it ignored"}]

      assert as_ast(markdown, footnotes: true) == {:error, [ast], messages}
    end

    @tag :ast
    test "undefined footnotes (none at all)" do
      markdown = "foo[^1]\nhello"
      html     = ~s{<p>foo[^1]\nhello</p>\n}
      ast      = parse_html(html)
      messages = [{:error, 1, "footnote 1 undefined, reference to it ignored"}]

      assert as_ast(markdown, footnotes: true) == {:error, [ast], messages}
    end

    @tag :ast
    test "illdefined footnotes" do
      markdown = "foo[^1]\nhello\n\n[^1]:bar baz"
      html     = ~s{<p>foo[^1]\nhello</p>\n<p>[^1]:bar baz</p>\n}
      ast      = parse_html(html)
      messages = [
        {:error, 1, "footnote 1 undefined, reference to it ignored"},
        {:error, 4, "footnote 1 undefined, reference to it ignored"}]

      assert as_ast(markdown, footnotes: true) == {:error, ast, messages}
    end

  end

end

# SPDX-License-Identifier: Apache-2.0
