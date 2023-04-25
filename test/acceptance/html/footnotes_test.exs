defmodule Acceptance.Html.FootnotesTest do
  use Support.AcceptanceTestCase

  describe "Footnotes" do
    test "without errors" do
      markdown = "foo[^1] again\n\n[^1]: bar baz"

      html = """
      <p>
      foo<a href=\"#fn:1\" id=\"fnref:1\" class=\"footnote\" title=\"see footnote\">1</a> again</p>
      <div class=\"footnotes\">
        <hr>
        <ol>
          <li id=\"fn:1\">
      <a class=\"reversefootnote\" href=\"#fnref:1\" title=\"return to article\">&#x21A9;</a>      <p>
      bar baz      </p>
          </li>
        </ol>
      </div>
      """

      messages = []

      assert as_html(markdown, footnotes: true) == {:ok, html, messages}
    end
  end
end

# SPDX-License-Identifier: Apache-2.0
